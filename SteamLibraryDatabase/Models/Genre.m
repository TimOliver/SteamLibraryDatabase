//
//  Genre.m
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/26/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "Genre.h"

@implementation Genre

+ (NSString *)primaryKey { return @"genreID"; }

+ (NSDictionary *)JSONInboundMappingDictionary
{
    return @{@"id" : @"genreID",
             @"description" : @"name"};
}

@end
