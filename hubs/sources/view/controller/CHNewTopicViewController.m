//
//  CHNewTopicViewController.m
//  hubs
//
//  Created by Sergey Seroshtan on 28.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import "CHNewTopicViewController.h"

#import <RestKit/RestKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "CHEmpty.h"
#import "CHHub.h"
#import "CHTopic.h"
#import "CHDataMapping.h"

@interface CHNewTopicViewController ()
        <UIAlertViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSArray *hubs;

@end

@implementation CHNewTopicViewController

#pragma mark - UI lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadHubs];
}

#pragma mark - UI actions
- (IBAction)createTopic:(id)sender
{
    if (![self.titleTextField.text exist]) {
        [CHAlert textFiledIsEmpty:@"Title"];
        [self.titleTextField becomeFirstResponder];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:YES];
    
    CHHub *hub = [self getHubForRow:[self.hubsPicker selectedRowInComponent:0]];
    if (hub == nil) {
        [CHAlert textFiledIsEmpty:@"Hub"];
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSString stringWithFormat:@"like"] forKey:@"reaction"];
    [parameters setObject:[NSString stringWithFormat:@"%@", self.titleTextField.text] forKey:@"title"];
    [parameters setObject:[NSString stringWithFormat:@"%@", hub.uid] forKey:@"hub"];
    if ([self.detailsTextView.text exist]) {
        [parameters setObject:[NSString stringWithFormat:@"%@", self.detailsTextView.text] forKey:@"summary"];
    }
    
    void(^successCompletion)(void) = ^ {
        [hud hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Topic was successfully created"
                delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    };

    void(^failedCompletion)(NSError *error) = ^(NSError *error) {
        NSHTTPURLResponse *response = [error.userInfo valueForKeyPath:AFNetworkingOperationFailingURLResponseErrorKey];
        if (response != nil && (response.statusCode / 100) == 2) {
            successCompletion();
            return;
        }
        
        [hud hide:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Topic was not created"
                delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    };

    [[RKObjectManager sharedManager] postObject:nil path:@"topic" parameters:parameters
            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
    {
        successCompletion();
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failedCompletion(error);
    }];
    
}

- (IBAction)finishTopicEditing:(id)sender
{
    [self.detailsTextView resignFirstResponder];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.tabBarController setSelectedIndex:0];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.hubs.count;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    CHHub *hub = [self getHubForRow:row];
    if (hub) {
        return hub.title;
    }
    return @"";
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Finish"
            style:UIBarButtonItemStylePlain target:self action:@selector(finishTopicEditing:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

 - (void)textViewDidEndEditing:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - Private
- (CHHub *)getHubForRow:(NSInteger)row
{
    if (row < self.hubs.count) {
        return self.hubs[row];
    }
    return nil;
}

- (void)loadHubs
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:YES];

    RKMapping *hubMapping = [CHDataMapping responseHubMapping];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:hubMapping
            method:RKRequestMethodGET pathPattern:nil keyPath:nil
            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];

    [[RKObjectManager sharedManager] getObjectsAtPath:@"hubs" parameters:nil
            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
    {
        self.hubs = [mappingResult array];
        [self.hubsPicker reloadAllComponents];
        [hud hide:YES];
    } failure:^(RKObjectRequestOperation *operation, NSError *error)
    {
        [hud hide:YES];
    }];
}
@end
