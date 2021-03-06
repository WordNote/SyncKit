//
//  AppDelegate.m
//  SyncKitRealm
//
//  Created by Manuel Entrena on 04/05/2017.
//  Copyright © 2017 Colourbox. All rights reserved.
//

#import "AppDelegate.h"
#import <Realm/Realm.h>
#import <SyncKit/QSCloudKitSynchronizer+Realm.h>
#import "QSCompanyTableViewController.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@property (nonatomic, strong) RLMRealm *realm;
@property (nonatomic, strong) QSCloudKitSynchronizer *synchronizer;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
    configuration.schemaVersion = 1;
    configuration.migrationBlock = ^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < 1) {
            // Nothing to do
        }
    };
    // For Extension test (app groups) uncomment below
    /*
    configuration.fileURL = [self realmPath];
     */
    self.realm = [RLMRealm realmWithConfiguration:configuration error:nil];
    UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    QSCompanyTableViewController *companyVC = (QSCompanyTableViewController *)navController.topViewController;
    if ([companyVC isKindOfClass:[QSCompanyTableViewController class]]) {
        [(QSCompanyTableViewController *)companyVC setRealm:self.realm];
        [(QSCompanyTableViewController *)companyVC setSynchronizer:self.synchronizer];
    }
    return YES;
}

//- (NSURL *)realmPath
//{
//     NSURL *groupURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.mentrena.todayextensiontest"];
//    return [groupURL URLByAppendingPathComponent:@"realmTest"];
//}

#pragma mark - Core Data Synchronizer

- (QSCloudKitSynchronizer *)synchronizer
{
    if (!_synchronizer) {
        // For Extension test (app groups):
//        _synchronizer = [QSCloudKitSynchronizer cloudKitSynchronizerWithContainerName:@"your-container-name" realmConfiguration:self.realm.configuration suiteName:@"group.com.mentrena.todayextensiontest"];
        
        _synchronizer = [QSCloudKitSynchronizer cloudKitSynchronizerWithContainerName:@"your-iCloud-container-name" realmConfiguration:self.realm.configuration];
    }

    return _synchronizer;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
