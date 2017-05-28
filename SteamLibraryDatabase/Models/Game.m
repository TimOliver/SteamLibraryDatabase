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
             @"release_date" : @"releaseDate",
             @"website" : @"website",
             @"detailed_description" : @"detailedDescription",
             @"about_the_game" : @"aboutDescription",
             @"short_description" : @"shortDescription",
             @"supported_languages" : @"languages",
             @"screenshots" : @"screenshots",
             @"genres" : @"genres",
             @"categories" : @"categories",
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

    // Convert date format from Steam to NSDate standard
    NSString *releaseDate = game[@"release_date"][@"date"];
    NSDateFormatter *dateFromFormatter = [[NSDateFormatter alloc] init];
    dateFromFormatter.dateFormat = @"MMM d, yyyy";
    NSDate *date = [dateFromFormatter dateFromString:releaseDate];

    NSDateFormatter *dateToFormatter = [[NSDateFormatter alloc] init];
    dateToFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    game[@"release_date"] = [dateToFormatter stringFromDate:date];

    NSDictionary *pcRequirements = game[@"pc_requirements"];
    if (pcRequirements.count == 0) { [game removeObjectForKey:@"pc_requirements"]; }

    NSDictionary *macRequirements = game[@"mac_requirements"];
    if (macRequirements.count == 0) { [game removeObjectForKey:@"mac_requirements"]; }

    NSDictionary *linuxRequirements = game[@"linux_requirements"];
    if (linuxRequirements.count == 0) { [game removeObjectForKey:@"linux_requirements"]; }

    return game;
}

@end
