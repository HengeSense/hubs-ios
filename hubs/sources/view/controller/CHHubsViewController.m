//
//  CHHubsViewController.m
//  hubs
//
//  Created by Sergey Seroshtan on 28.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import "CHHubsViewController.h"

#import <RestKit/RestKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "CHHub.h"
#import "CHTopicsViewController.h"

#import "CHDataMapping.h"

#pragma mark - Storyboard identifiers
static NSString * const kShowHubTopicsSegue = @"CHShowHubTopicsSegue";

@interface CHHubsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *hubs;
@property (weak, nonatomic) CHHub *selectedHub;

@end

@implementation CHHubsViewController

#pragma mark - Initialization

#pragma UI lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadHubs];
}

#pragma mark - Segue processing
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CHTopicsViewController *topicsViewController = segue.destinationViewController;
    topicsViewController.hub = self.selectedHub;
}

#pragma mark - UI actions

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedHub = [self getHubForIndexPath:indexPath];
    [self performSegueWithIdentifier:kShowHubTopicsSegue sender:tableView];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hubs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellResuseId = @"CHHubsViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellResuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellResuseId];
    }
    CHHub *hub = [self getHubForIndexPath:indexPath];
    if (hub == nil) {
        return cell;
    }
    cell.textLabel.text = hub.title;
    cell.detailTextLabel.text = [hub.topicsCount stringValue];
    return cell;
}

#pragma mark - Private
- (CHHub *)getHubForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.hubs.count) {
        return self.hubs[indexPath.row];
    }
    return nil;
}

- (void)loadHubs
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:YES];

    RKMapping *hubMapping = [CHDataMapping responseHubMapping];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:hubMapping
            method:RKRequestMethodGET pathPattern:nil keyPath:nil
            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"hubs" parameters:nil
            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
    {
        self.hubs = [mappingResult array];
        [self.rootTableView reloadData];
        [hud hide:YES];
    } failure:^(RKObjectRequestOperation *operation, NSError *error)
    {
        [hud hide:YES];
    }];
}
@end
