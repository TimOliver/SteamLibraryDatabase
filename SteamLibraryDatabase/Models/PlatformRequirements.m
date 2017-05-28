//
//  TOPlatformRequirements.m
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/26/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "PlatformRequirements.h"

@implementation PlatformRequirements

+ (NSDictionary *)JSONInboundMappingDictionary
{
    return @{@"minimum" : @"minimumRequirements",
             @"recommended" : @"recommendedRequirements"};
}

@end
