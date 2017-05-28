//
//  ViewController.m
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/26/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "TOViewController.h"
#import "TOSteamCatalogImporter.h"

@interface TOViewController ()

@property (nonatomic, strong) TOSteamCatalogImporter *importer;

@end

@implementation TOViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *realmFileURL = [documentsURL URLByAppendingPathComponent:@"SteamDatabase.realm"];

    self.importer = [[TOSteamCatalogImporter alloc] initWithRealmFileURL:realmFileURL];

    UIBarButtonItem *startButton = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(start)];
    self.navigationItem.rightBarButtonItem = startButton;
}

- (void)start
{
    [self.importer startImporting];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
