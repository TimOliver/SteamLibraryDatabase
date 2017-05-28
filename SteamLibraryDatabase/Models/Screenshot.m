//
//  Screenshot.m
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/26/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "Screenshot.h"

@implementation Screenshot

+ (NSDictionary *)JSONInboundMappingDictionary
{
    return @{@"id" : @"screenshotID",
             @"path_thumbnail" : @"thumbnailURL",
             @"path_full" : @"fullImageURL"};
}

@end
