//
//  CHAlert.m
//  hubs
//
//  Created by Sergey Seroshtan on 28.09.13.
//  Copyright (c) 2013 Sergey Seroshtan. All rights reserved.
//

#import "CHAlert.h"

@implementation CHAlert

+ (void)textFiledIsEmpty:(NSString *)textFieldName
{
    NSString *title = [NSString stringWithFormat:@"Field '%@' is empty", textFieldName];
    NSString *message = [NSString stringWithFormat:@"Please put correct value to the filed '%@'", textFieldName];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil
            cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

@end
