//
//  CHTopicTableViewCell.h
//  hubs
//
//  Created by Sergey Seroshtan on 29.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHTopicTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
