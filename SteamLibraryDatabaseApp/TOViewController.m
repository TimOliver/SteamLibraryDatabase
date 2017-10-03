//
//  ViewController.m
//  SteamLibraryDatabase
//
//  Created by Tim Oliver on 5/26/17.
//  Copyright © 2017 Tim Oliver. All rights reserved.
//

#import "TOViewController.h"
#import "TOSteamCatalogImporter.h"
#import <Realm/Realm.h>
#import "App.h"
#import "TOScrollBar.h"

@interface TOViewController ()

@property (nonatomic, strong) TOSteamCatalogImporter *importer;
@property (nonatomic, strong) RLMResults *apps;
@property (nonatomic, strong) RLMNotificationToken *notificationToken;

@end

@implementation TOViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    TOScrollBar *scrollBar = [[TOScrollBar alloc] initWithStyle:TOScrollBarStyleDefault];
    [scrollBar addToScrollView:self.tableView];
    self.tableView.separatorInset = [scrollBar adjustedTableViewSeparatorInsetForInset:self.tableView.separatorInset];

    self.importer = [[TOSteamCatalogImporter alloc] init];

    RLMRealm *appsRealm = [RLMRealm realmWithConfiguration:self.importer.steamAppsRealmConfiguration error:nil];
    self.apps = [App allObjectsInRealm:appsRealm];

    __weak typeof(self) weakSelf = self;
    self.notificationToken = [self.apps addNotificationBlock:^(RLMResults *results, RLMCollectionChange *changes, NSError *error) {
        if (error) {
            NSLog(@"Failed to open Realm on background worker: %@", error);
            return;
        }

        UITableView *tableView = weakSelf.tableView;
        // Initial run of the query will pass nil for the change information
        if (!changes) {
            [tableView reloadData];
            return;
        }

        // Query results have changed, so apply them to the UITableView
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:[changes deletionsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView insertRowsAtIndexPaths:[changes insertionsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView reloadRowsAtIndexPaths:[changes modificationsInSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
    }];

    UIBarButtonItem *startButton = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(start)];
    self.navigationItem.rightBarButtonItem = startButton;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    App *app = self.apps[indexPath.row];
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lld", app.appID];
    cell.accessoryType = app.downloaded ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

    return cell;
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
