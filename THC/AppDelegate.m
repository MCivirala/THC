//
//  AppDelegate.m
//  THC
//
//  Created by Nicolas Melo on 7/2/14.
//  Copyright (c) 2014 THC. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Case.h"
#import "PhotoInfo.h"
#import "Note.h"
#import "Building.h"
#import "BuildingPhoto.h"
//#import "CaseTableViewController.h"
//#import "AggregateMapViewController.h"
#import "ExploreCasesContainerViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [Case registerSubclass];
    [PhotoInfo registerSubclass];
    [Note registerSubclass];
    [Building registerSubclass];
    [BuildingPhoto registerSubclass];
    
    [Parse setApplicationId:@"rW4V8SnA9hN7UOqTYFsYOqVcwbPzjybEo2ej9c0F"
                  clientKey:@"29l3eEqh8bXXBziYQhYVLwApxK8IaIxBjjYRNrha"];
    
//    AggregateMapViewController *aggregateViewController = [[AggregateMapViewController alloc] init];
//    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:aggregateViewController];

    ExploreCasesContainerViewController *xvc = [[ExploreCasesContainerViewController alloc] init];
    
    
    self.window.rootViewController = xvc;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
