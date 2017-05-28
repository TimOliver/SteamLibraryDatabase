//
//  Publisher.h
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/26/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import <Realm/Realm.h>

@interface Publisher : RLMObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, readonly) RLMLinkingObjects *games;

@end

RLM_ARRAY_TYPE(Publisher)
