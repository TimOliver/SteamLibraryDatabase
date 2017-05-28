//
//  Screenshot.h
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/26/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import <Realm/Realm.h>

@interface Screenshot : RLMObject

@property (nonatomic, assign) int64_t screenshotID;
@property (nonatomic, copy) NSString *thumbnailURL;
@property (nonatomic, copy) NSString *fullImageURL;

@end

RLM_ARRAY_TYPE(Screenshot)
