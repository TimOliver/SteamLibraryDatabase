//
//  Category.h
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/26/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import <Realm/Realm.h>

@interface Category : RLMObject

@property (nonatomic, assign) uint64_t categoryID;
@property (nonatomic, copy) NSString *name;

@end

RLM_ARRAY_TYPE(Category)
