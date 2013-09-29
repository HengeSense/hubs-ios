//
//  CHTopicsViewController.m
//  hubs
//
//  Created by Sergey Seroshtan on 28.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import "CHTopicsViewController.h"

#import <RestKit/RestKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "CHTopic.h"
#import "CHTopicDetailsViewController.h"

#import "CHDataMapping.h"

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
    [self loadTopics];
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
    cell.textLabel.text = topic.title;
    cell.detailTextLabel.text = topic.owner.fullName;
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

- (void)loadTopics
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:YES];
    
    RKResponseDescriptor *responseDescriptor =
            [RKResponseDescriptor responseDescriptorWithMapping:[CHDataMapping responseTopicMapping]
            method:RKRequestMethodGET pathPattern:nil keyPath:nil
            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"topics" parameters:@{ @"hub" : self.hub.uid }
            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
    {
        self.topics = [mappingResult array];
        [self.rootTableView reloadData];
        [hud hide:YES];
    } failure:^(RKObjectRequestOperation *operation, NSError *error)
    {
        [hud hide:YES];
    }];
}

@end
