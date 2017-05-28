//
//  Movie.m
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/26/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "Movie.h"

@implementation Movie

+ (NSDictionary *)JSONInboundMappingDictionary
{
    return @{@"id" : @"movieID",
             @"name" : @"name",
             @"thumbnail" : @"thumbnailURL",
             @"webm.480" : @"smallMovieURL",
             @"webm.max" : @"maxMovieURL",
             @"highlight" : @"highlight"};
}

@end

