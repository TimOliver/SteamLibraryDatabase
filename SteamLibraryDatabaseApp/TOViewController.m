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

    self.importer = [[TOSteamCatalogImporter alloc] init];

    UIBarButtonItem *startButton = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(start)];
    self.navigationItem.rightBarButtonItem = startButton;
}

- (void)start
{
    [self.importer startDownloadingCatalog];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
