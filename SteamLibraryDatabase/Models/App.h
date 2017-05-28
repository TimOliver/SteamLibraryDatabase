//
//  App.h
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/27/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import <Realm/Realm.h>

@interface App : RLMObject

@property (nonatomic, assign) int64_t appID;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL downloaded;

@end
