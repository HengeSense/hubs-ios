//
//  CHHub.h
//  hubs
//
//  Created by Sergey Seroshtan on 28.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHHub : NSObject

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *topicsNum;
@property (assign, nonatomic) BOOL isSelected;

@end
