//
//  CHLoginViewController.m
//  hubs
//
//  Created by Sergey Seroshtan on 28.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import "CHLoginViewController.h"

#import <RestKit/RestKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

#pragma mark - Storyboard identifiers
static NSString * const kSignInSuccessSegue = @"CHSignInSuccessSegue";

@interface CHLoginViewController () <UITextFieldDelegate>

@end

@implementation CHLoginViewController

#pragma mark - Initialization

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UI actions
- (IBAction)signIn:(id)sender {
    if (![self.userNameTextField.text exist]) {
        [CHAlert textFiledIsEmpty:self.userNameLabel.text];
        [self.userNameTextField becomeFirstResponder];
        return;
    } else if (![self.userPasswordTextField.text exist]) {
        [CHAlert textFiledIsEmpty:self.userPasswordLabel.text];
        [self.userPasswordTextField becomeFirstResponder];
        return;
    }
    
    [self hideKeyboard];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager.HTTPClient setAuthorizationHeaderWithUsername:self.userNameTextField.text
            password:self.userPasswordTextField.text];
    
    [objectManager getObjectsAtPath:@"login" parameters:nil
            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
    {
        [hud hide:YES];
        [self performSegueWithIdentifier:kSignInSuccessSegue sender:sender];
    } failure:^(RKObjectRequestOperation *operation, NSError *error)
    {
        [CHAlert userNameOrPasswordIsInvalid];
        [hud hide:YES];
    }];
}

#pragma mark - Private
#pragma mark - UI helpers
- (void)hideKeyboard
{
    [self.view endEditing:YES];
}
@end
