//
//  TOSteamCatalogImporter.h
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/27/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RLMRealmConfiguration;

@interface TOSteamCatalogImporter : NSObject

/* A folder to download the JSON data to */
@property (nonatomic, copy) NSURL *downloadFolderURL;

/* The location of the Realm file that will store all of the data */
@property (nonatomic, strong) NSURL *steamCatalogRealmURL;

/* Get a copy of the Realm configuration used to control this Realm container */
@property (nonatomic, readonly) RLMRealmConfiguration *steamCatalogRealmConfiguration;

/* Dump all Steam entity pages to disk */
- (void)startDownloadingCatalog;

/* Start importing game info from Steam */
- (void)startImporting;

/* Cancel the importing */
- (void)stopImporting;

@end
