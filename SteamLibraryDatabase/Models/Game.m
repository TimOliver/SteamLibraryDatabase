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

+ (NSDictionary *)preprocessedJSON:(NSDictionary *)dictionary
{
    // Convert Developers and Publishers to Objects

    NSMutableDictionary *game = [dictionary mutableCopy];

    NSArray *publishers = game[@"publishers"];
    if (publishers.count) {
        NSMutableArray *newPublishers = [NSMutableArray array];

        for (NSString *publisher in publishers) {
            NSDictionary *publisherDict = @{@"name" : publisher};
            [newPublishers addObject:publisherDict];
        }

        game[@"publishers"] = newPublishers;
    }

    NSArray *developers = game[@"developers"];
    if (developers.count) {
        NSMutableArray *newDevelopers = [NSMutableArray array];

        for (NSString *developer in developers) {
            NSDictionary *developerDict = @{@"name" : developer};
            [newDevelopers addObject:developerDict];
        }

        game[@"developers"] = newDevelopers;
    }


    return game;
}

@end
