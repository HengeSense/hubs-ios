//
//  CHHubsViewController.m
//  hubs
//
//  Created by Sergey Seroshtan on 28.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import "CHHubsViewController.h"

#import "CHTopicsViewController.h"

#import "CHHub.h"

#pragma mark - Storyboard identifiers
static NSString * const kShowHubTopicsSegue = @"CHShowHubTopicsSegue";

@interface CHHubsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *hubs;
@property (weak, nonatomic) CHHub *selectedHub;

@end

@implementation CHHubsViewController

#pragma mark - Initialization

#pragma UI lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    CHHub *hub1 = [[CHHub alloc] init];
    hub1.uid = @"1";
    hub1.title = @"Hobbies";

    CHHub *hub2 = [[CHHub alloc] init];
    hub2.uid = @"2";
    hub2.title = @"Java";

    CHHub *hub3 = [[CHHub alloc] init];
    hub3.uid = @"3";
    hub3.title = @"Cofee";

    self.hubs = @[ hub1, hub2, hub3 ];
    // Do any additional setup after loading the view.
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellResuseId];
    }
    CHHub *hub = [self getHubForIndexPath:indexPath];
    if (hub == nil) {
        return cell;
    }
    cell.textLabel.text = hub.title;
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
@end
