//
//  CHDataMapping.m
//  hubs
//
//  Created by Sergey Seroshtan on 29.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import "CHDataMapping.h"

#import "CHHub.h"
#import "CHTopic.h"
#import "CHUserInfo.h"

@implementation CHDataMapping

+ (RKMapping *)responseHubMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[CHHub class]];
    [mapping addAttributeMappingsFromDictionary:@{
        @"id" : @"uid",
        @"title" : @"title",
        @"topicsCount" : @"topicsCount"
    }];
    return mapping;
}

+ (RKMapping *)responseTopicMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[CHTopic class]];
    [mapping addAttributeMappingsFromDictionary:@{
        @"id" : @"uid",
        @"title" : @"title",
        @"summary" : @"details"
    }];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"hub" toKeyPath:@"hub"
            withMapping:[self responseHubMapping]]];

    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"owner" toKeyPath:@"owner"
            withMapping:[self responseUserInfoMapping]]];
    
    return mapping;
}

+ (RKMapping *)requestTopicMapping
{
    RKObjectMapping *mapping = [RKObjectMapping requestMapping];
    [mapping addAttributeMappingsFromDictionary: @{
        @"title" : @"title",
        @"hub" : @"hub.uid",
        @"summary" : @"details"
    }];
    return mapping;
}

+ (RKMapping *)responseUserInfoMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[CHUserInfo class]];
    [mapping addAttributeMappingsFromDictionary:@{
        @"name" : @"name",
        @"fullName" : @"fullName"
    }];
    return mapping;
}

@end
