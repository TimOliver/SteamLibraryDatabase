//
//  Category.m
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/26/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "Category.h"
#import "Game.h"

@implementation Category

+ (NSString *)primaryKey { return @"categoryID"; }

+ (NSDictionary *)JSONInboundMappingDictionary
{
    return @{@"id" : @"categoryID",
             @"description" : @"name"};
}

+ (NSDictionary *)linkingObjectsProperties {
    return @{
             @"games": [RLMPropertyDescriptor descriptorWithClass:Game.class propertyName:@"categories"],
        };
}

@end
