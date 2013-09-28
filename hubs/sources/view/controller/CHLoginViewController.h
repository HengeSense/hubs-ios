//
//  CHLoginViewController.h
//  hubs
//
//  Created by Sergey Seroshtan on 28.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHLoginViewController : UIViewController

/// @name UI outlets
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextField;

/// @name UI actions
- (IBAction)signIn:(id)sender;

@end
