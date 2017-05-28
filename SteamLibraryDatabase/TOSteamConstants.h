//
//  TOSteamConstants.h
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/27/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** Steam URL for a list of all titles (including games, apps, and videos) */
NSString * const kTOSteamAppListURL = @"https://api.steampowered.com/ISteamApps/GetAppList/v0002/";

/** The URL for a single metadata entry for a Steam title */
NSString * const kTOSteamAppURL = @"https://store.steampowered.com/api/appdetails/?appids=%@";

/** The URL is rate limited to 200 every 5 minutes, or 1 every 1.5 seconds. */
CGFloat const kTOSteamAppURLRateLimit = 1.5f;
