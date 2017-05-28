//
//  App.m
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/27/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "App.h"
#import "RLMObject+JSON.h"

@implementation App

+ (NSDictionary *)JSONInboundMappingDictionary
{
    return @{@"appid" : @"appID",
             @"name" : @"name"};
}

+ (NSString *)primaryKey { return @"appID"; }

@end
