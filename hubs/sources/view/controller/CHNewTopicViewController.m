//
//  CHNewTopicViewController.m
//  hubs
//
//  Created by Sergey Seroshtan on 28.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import "CHNewTopicViewController.h"

#import "CHHub.h"

@interface CHNewTopicViewController ()
        <UIAlertViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate>

@property (strong, nonatomic) NSArray *hubs;

@end

@implementation CHNewTopicViewController

#pragma mark - UI lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    CHHub *hub1 = [[CHHub alloc] init];
    hub1.uid = @"1";
    hub1.title = @"Hobbies";
    
    CHHub *hub2 = [[CHHub alloc] init];
    hub2.uid = @"2";
    hub2.title = @"Java";
    
    CHHub *hub3 = [[CHHub alloc] init];
    hub3.uid = @"3";
    hub3.title = @"Cofee";
    
    self.hubs = @[ hub1, hub2, hub3 ];
}

#pragma mark - UI actions
- (IBAction)createTopic:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Topic was successfully created"
            delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
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

@end
