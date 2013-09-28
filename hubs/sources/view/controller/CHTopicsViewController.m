//
//  CHTopicsViewController.m
//  hubs
//
//  Created by Sergey Seroshtan on 28.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import "CHTopicsViewController.h"

#import "CHTopic.h"
#import "CHTopicDetailsViewController.h"

#pragma mark - Storyboard identifiers
static NSString * const kTopicDetailsViewControllerSegue = @"CHTopicDetailsViewControllerSegue";

@interface CHTopicsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *topics;
@property (weak, nonatomic) CHTopic *selectedTopic;

@end

@implementation CHTopicsViewController

#pragma mark - UI lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CHTopic *topic1 = [[CHTopic alloc] init];
    CHUserInfo *userInfo1 = [[CHUserInfo alloc] init];
    userInfo1.name = @"Joe";
    userInfo1.fullName = @"Joe Kent";
    topic1.owner = userInfo1;
    topic1.details = @"Lets go drink cofee";
    
    CHTopic *topic2 = [[CHTopic alloc] init];
    CHUserInfo *userInfo2 = [[CHUserInfo alloc] init];
    userInfo2.name = @"Tim";
    userInfo2.fullName = @"Tim Kent";
    topic2.owner = userInfo2;
    topic2.details = @"Lets go play football. This game is very interesting.";
    
    self.topics = @[topic1, topic2];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.hub.title) {
        self.title = self.hub.title;
    }
}

#pragma mark - Segue processing
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CHTopicDetailsViewController *topicDetailsViewController = segue.destinationViewController;
    topicDetailsViewController.topic = self.selectedTopic;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const kTopicsViewControllerCell = @"CHTopicsViewControllerCell";
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:kTopicsViewControllerCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kTopicsViewControllerCell];
    }
    CHTopic *topic = [self getTopicForIndexPath:indexPath];
    if (topic == nil) {
        return cell;
    }
    cell.textLabel.text = topic.owner.fullName;
    cell.detailTextLabel.text = topic.details;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedTopic = [self getTopicForIndexPath:indexPath];
    [self performSegueWithIdentifier:kTopicDetailsViewControllerSegue sender:tableView];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Private
- (CHTopic *)getTopicForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.topics.count) {
        return self.topics[indexPath.row];
    }
    return nil;
}

@end
