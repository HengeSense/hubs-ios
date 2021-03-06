//
//  CHNewTopicViewController.h
//  hubs
//
//  Created by Sergey Seroshtan on 28.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHNewTopicViewController : UIViewController

/// @name UI outlets
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;
@property (weak, nonatomic) IBOutlet UIPickerView *hubsPicker;


/// @name UI actions
- (IBAction)createTopic:(id)sender;

@end
