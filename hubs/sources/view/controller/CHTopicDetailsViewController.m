//
//  CHTopicDetailsViewController.m
//  hubs
//
//  Created by Sergey Seroshtan on 28.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import "CHTopicDetailsViewController.h"

@interface CHTopicDetailsViewController ()

@end

@implementation CHTopicDetailsViewController

#pragma mark - UI lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = self.topic.title;
    self.topicDetailsTextView.text = self.topic.details;
}

@end
