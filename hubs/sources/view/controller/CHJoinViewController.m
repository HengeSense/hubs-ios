//
//  CHJoinViewController.m
//  hubs
//
//  Created by Sergey Seroshtan on 28.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import "CHJoinViewController.h"

#import "CHHub.h"

@interface CHJoinViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *hubs;

@end

@implementation CHJoinViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CHHub *hub1 = [[CHHub alloc] init];
    hub1.uid = @"1";
    hub1.title = @"Hobbies";
    hub1.isSelected = YES;
    
    CHHub *hub2 = [[CHHub alloc] init];
    hub2.uid = @"2";
    hub2.title = @"Java";
    hub2.isSelected = NO;
    
    CHHub *hub3 = [[CHHub alloc] init];
    hub3.uid = @"3";
    hub3.title = @"Cofee";
    hub3.isSelected = YES;

    
    self.hubs = @[ hub1, hub2, hub3 ];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hubs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const kJoinViewControllerCell = @"CHJoinViewControllerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJoinViewControllerCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kJoinViewControllerCell];
    }
    CHHub *hub = [self getHubForIndexPath:indexPath];
    if (hub == nil) {
        return cell;
    }
    cell.textLabel.text = hub.title;
    if (hub.isSelected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHHub *hub = [self getHubForIndexPath:indexPath];
    hub.isSelected = !hub.isSelected;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Private
- (CHHub *)getHubForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.hubs.count) {
        return self.hubs[indexPath.row];
    }
    return nil;
}

@end
