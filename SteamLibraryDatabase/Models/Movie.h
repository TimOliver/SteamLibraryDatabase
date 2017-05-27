//
//  Movie.h
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/26/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import <Realm/Realm.h>

@interface Movie : RLMObject

@property (nonatomic, assign) uint64_t movieID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *thumbnailURL;
@property (nonatomic, copy) NSString *smallMovieURL;
@property (nonatomic, copy) NSString *maxMovieURL;
@property (nonatomic, assign) BOOL highlight;

@end

RLM_ARRAY_TYPE(Movie)
