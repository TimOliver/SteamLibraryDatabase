//
//  Developer.m
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/26/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "Developer.h"
#import "Game.h"

@implementation Developer

+ (NSString *)primaryKey { return @"name"; }

+ (NSDictionary *)linkingObjectsProperties {
    return @{
             @"games": [RLMPropertyDescriptor descriptorWithClass:Game.class propertyName:@"developers"],
             };
}

@end
