//
//  CHTopic.h
//  hubs
//
//  Created by Sergey Seroshtan on 29.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CHHub.h"
#import "CHUserInfo.h"

@interface CHTopic : NSObject

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *details;
@property (strong, nonatomic) CHHub *hub;
@property (strong, nonatomic) CHUserInfo *owner;
@property (strong, nonatomic) NSArray *likes; // Array of CHUserInfo

@end
