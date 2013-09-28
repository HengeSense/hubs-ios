//
//  CHLoginViewController.m
//  hubs
//
//  Created by Sergey Seroshtan on 28.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import "CHLoginViewController.h"

static NSString * const kSignInSuccessSegue = @"signInSuccessSegue";

@interface CHLoginViewController () <UITextFieldDelegate>

@end

@implementation CHLoginViewController

#pragma mark - Initialization
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma UI lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UI actions
- (IBAction)signIn:(id)sender {
    if (![self.userNameTextField.text exist]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Field 'Name' is empty"
                message:@"Please put correct value to the filed 'Name'"
                delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [self.userNameTextField becomeFirstResponder];
        return;
    } else if (![self.userPasswordTextField.text exist]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Field 'Password' is empty"
                message:@"Please put correct value to the filed 'Password'"
                delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [self.userPasswordTextField becomeFirstResponder];
        return;
    }
    [self performSegueWithIdentifier:kSignInSuccessSegue sender:sender];
}
@end
