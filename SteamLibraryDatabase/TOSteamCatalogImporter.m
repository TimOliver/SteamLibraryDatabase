//
//  TOSteamCatalogImporter.m
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/27/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "TOSteamConstants.h"

#import "TOSteamCatalogImporter.h"
#import "RLMObject+JSON.h"
#import <Realm/Realm.h>
#import "AFNetworking.h"
#import "App.h"

#import "Category.h"
#import "Developer.h"
#import "Game.h"
#import "Genre.h"
#import "Movie.h"
#import "PlatformRequirements.h"
#import "Publisher.h"
#import "Screenshot.h"

@interface TOSteamCatalogImporter ()

@property (nonatomic, strong) AFURLSessionManager *sessionManager;

@property (nonatomic, readonly) RLMRealmConfiguration *catalogRealmConfiguration;
@property (nonatomic, readonly) RLMRealm *catalogRealm;

@property (nonatomic, readonly) RLMRealmConfiguration *cacheConfiguration;
@property (nonatomic, strong) RLMRealm *cacheRealm;
@property (nonatomic, strong) RLMResults *pendingApps;

@property (nonatomic, strong) NSTimer *requestTimer;

@end

@implementation TOSteamCatalogImporter

- (instancetype)init
{
    if (self = [super init]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

        NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        _steamCatalogRealmURL = [documentsURL URLByAppendingPathComponent:@"SteamDatabase.realm"];

        _downloadFolderURL = [documentsURL URLByAppendingPathComponent:@"SteamCatalog"];
    }

    return self;
}

- (void)startImporting
{

}

- (void)startDownloadingCatalog
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:self.downloadFolderURL.path isDirectory:nil] == NO) {
        [fileManager createDirectoryAtPath:self.downloadFolderURL.path withIntermediateDirectories:YES attributes:nil error:nil];
    }

    if (self.cacheRealm.isEmpty) {
        [self requestContentsForCacheRealm];
        return;
    }

    self.pendingApps = [App objectsInRealm:self.cacheRealm where:@"downloaded == 0"];

    [self.requestTimer invalidate];
    self.requestTimer = [NSTimer scheduledTimerWithTimeInterval:kTOSteamAppURLRateLimit repeats:YES block:^(NSTimer * _Nonnull timer) {
        App *app = self.pendingApps.firstObject;
        [self downloadJSONForApp:app];
    }];
}

- (void)downloadJSONForApp:(App *)app
{
    NSString *formattedAppURL = [NSString stringWithFormat:kTOSteamAppURL, @(app.appID)];
    NSURL *URL = [NSURL URLWithString:formattedAppURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    [app.realm transactionWithBlock:^{
        app.downloaded = YES;
    }];

    int64_t appID = app.appID;

    NSURLSessionDownloadTask *downloadTask = [self.sessionManager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSString *fileName = [NSString stringWithFormat:@"%lld.json", appID];
        return [self.downloadFolderURL URLByAppendingPathComponent:fileName];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [app.realm transactionWithBlock:^{
                    app.downloaded = NO;
                }];
            });
        }
    }];
    [downloadTask resume];
}

- (void)importApp:(App *)app
{
    NSString *formattedAppURL = [NSString stringWithFormat:kTOSteamAppURL, @(app.appID)];
    NSURL *URL = [NSURL URLWithString:formattedAppURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDataTask *task = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return ;
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self importApp:app withResponse:responseObject];
        });
    }];
    [task resume];
}

- (void)importApp:(App *)app withResponse:(NSDictionary *)response
{
    // Key is the ID number of the app
    NSString *key = response.allKeys.firstObject;

    // If this is not a game, mark it as 'done' and move on
    NSDictionary *data = response[key][@"data"];
    if ([data[@"type"] isEqualToString:@"game"] == NO) {
        [app.realm transactionWithBlock:^{
            app.downloaded = YES;
        }];

        return;
    }

    Game *game = [[Game alloc] initWithJSONDictionary:data];

    // Save the game to our Realm
    RLMRealm *catalogRealm = self.catalogRealm;
    [catalogRealm transactionWithBlock:^{
        [Game createOrUpdateInRealm:catalogRealm withValue:game];
    }];

    // Mark it as done in the cache Realm
    [app.realm transactionWithBlock:^{
        app.downloaded = YES;
    }];
}

#pragma mark - Apps Realm -

- (RLMRealmConfiguration *)catalogRealmConfiguration
{
    RLMRealmConfiguration *configuration = [[RLMRealmConfiguration alloc] init];
    configuration.fileURL = self.steamCatalogRealmURL;
    configuration.objectClasses = @[[Category class], [Developer class], [Game class],
                                    [Genre class], [Movie class], [PlatformRequirements class],
                                    [Publisher class], [Screenshot class]];
    configuration.deleteRealmIfMigrationNeeded = YES;
    return configuration;
}

- (RLMRealm *)catalogRealm
{
    return [RLMRealm realmWithConfiguration:self.catalogRealmConfiguration error:nil];
}

#pragma mark - Cache Realm -
- (void)requestContentsForCacheRealm
{
    NSURL *appsURL = [NSURL URLWithString:kTOSteamAppListURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:appsURL];

    NSURLSessionDataTask *task = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return ;
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self saveContentsToCacheRealm:responseObject];
        });
    }];
    [task resume];
}

- (void)saveContentsToCacheRealm:(NSDictionary *)contents
{
    NSArray *appList = contents[@"applist"][@"apps"];
    if (appList == nil) { return; }

    [self.cacheRealm transactionWithBlock:^{
        [App createOrUpdateInRealm:self.cacheRealm withJSONArray:appList];
    }];

    [self startImporting];
}

- (RLMRealmConfiguration *)cacheConfiguration
{
    NSString *cacheDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *cacheFilePath = [cacheDirectory stringByAppendingPathComponent:@"SteamAppCache.realm"];

    RLMRealmConfiguration *configuration = [[RLMRealmConfiguration alloc] init];
    configuration.fileURL = [NSURL fileURLWithPath:cacheFilePath];
    configuration.objectClasses = @[[App class]];
    return configuration;
}

- (RLMRealm *)cacheRealm
{
    if (_cacheRealm) { return _cacheRealm; }

    _cacheRealm = [RLMRealm realmWithConfiguration:self.cacheConfiguration error:nil];
    return _cacheRealm;
}

@end
