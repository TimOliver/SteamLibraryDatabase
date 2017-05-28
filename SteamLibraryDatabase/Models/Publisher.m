//
//  Publisher.m
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/26/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "Publisher.h"
#import "Game.h"

@implementation Publisher

+ (NSString *)primaryKey { return @"name"; }

+ (NSDictionary *)linkingObjectsProperties {
    return @{
             @"games": [RLMPropertyDescriptor descriptorWithClass:Game.class propertyName:@"publishers"],
             };
}

@end
