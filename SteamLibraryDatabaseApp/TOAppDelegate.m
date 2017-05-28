//
//  AppDelegate.m
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/26/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "TOAppDelegate.h"
#import "TOViewController.h"

@interface TOAppDelegate ()

@end

@implementation TOAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[TOViewController new]];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
