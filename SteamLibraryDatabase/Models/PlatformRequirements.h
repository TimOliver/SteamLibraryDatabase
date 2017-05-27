//
//  TOPlatformRequirements.h
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/26/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import <Realm/Realm.h>

@interface PlatformRequirements : RLMObject

@property (nonatomic, copy) NSString *minimumRequirements;
@property (nonatomic, copy) NSString *recommendedRequirements;

@end
