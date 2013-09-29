//
//  CHDataMapping.h
//  hubs
//
//  Created by Sergey Seroshtan on 29.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <RestKit/RestKit.h>

@interface CHDataMapping : NSObject

+ (RKMapping *)responseHubMapping;

+ (RKMapping *)responseTopicMapping;
+ (RKMapping *)requestTopicMapping;

+ (RKMapping *)responseUserInfoMapping;

@end
