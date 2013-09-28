//
//  CHTopicDetailsViewController.h
//  hubs
//
//  Created by Sergey Seroshtan on 28.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CHTopic.h"

@interface CHTopicDetailsViewController : UIViewController

/// @name Configuration
@property (strong, nonatomic) CHTopic *topic;

/// @name UI outlets
@property (strong, nonatomic) IBOutlet UITextView *topicDetailsTextView;

@end

