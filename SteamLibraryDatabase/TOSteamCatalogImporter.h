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

- (instancetype)initWithRealmFileURL:(NSURL *)fileURL;

/* Get a copy of the Realm configuration used to control this Realm container */
@property (nonatomic, readonly) RLMRealmConfiguration *steamCatalogRealmConfiguration;

/* Start importing game info from Steam */
- (void)startImporting;

/* Cancel the importing */
- (void)stopImporting;

@end
