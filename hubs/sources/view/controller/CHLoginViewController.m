//
//  CHLoginViewController.m
//  hubs
//
//  Created by Sergey Seroshtan on 28.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import "CHLoginViewController.h"

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
    [self performSegueWithIdentifier:kSignInSuccessSegue sender:sender];
}
@end
