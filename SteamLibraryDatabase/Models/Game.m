//
//  TOSteamGame.m
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/26/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "Game.h"

@implementation Game

+ (NSString *)primaryKey { return @"appID"; }


+ (NSDictionary *)JSONInboundMappingDictionary
{
    return @{@"name" : @"name",
             @"steam_appid" : @"appID",
             @"release_date.date" : @"releaseDate",
             @"website" : @"website",
             @"detailed_description" : @"detailedDescription",
             @"about_the_game" : @"aboutDescription",
             @"short_description" : @"shortDescription",
             @"supported_languages" : @"languages",
             @"screenshots" : @"screenshots",
             @"movies" : @"movies",
             @"developers" : @"developers",
             @"publishers" : @"publishers",
             @"pc_requirements" : @"pcRequirements",
             @"mac_requirements" : @"macRequirements",
             @"linux_requirements" : @"linuxRequirements",
             @"header_image" : @"headerImageURL",
             @"background" : @"backgroundImageURL"};
}

@end
