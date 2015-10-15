//
//  WLIAppDelegate.m
//  WeLike
//
//  Created by Planet 1107 on 9/20/13.
//  Copyright (c) 2013 Planet 1107. All rights reserved.
//

#import "WLIAppDelegate.h"
#import "WLINewPostViewController.h"
#import "WLINearbyViewController.h"
#import "WLIPopularViewController.h"
#import "WLIProfileViewController.h"
#import "WLITimelineViewController.h"
#import "WLIConnect.h"

@implementation WLIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    CLAuthorizationStatus locationAuthorizationStatus = [CLLocationManager authorizationStatus];
    if (locationAuthorizationStatus != kCLAuthorizationStatusDenied) {
        self.locationManager = [[CLLocationManager alloc] init];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
            [self.locationManager performSelector:@selector(requestWhenInUseAuthorization) withObject:nil];
        }
    }
    
    [self createViewHierarchy];
    
    // navigation bar appearance
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:255.0f/255.0f green:80.0f/255.0f blue:70.0f/255.0f alpha:1.0f]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav-back64.png"] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    } else {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav-back44.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    // status bar appearance
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - UITabBarControllerDelegate methods

- (BOOL)tabBarController:(UITabBarController *)tabBarController  shouldSelectViewController:(UIViewController *)viewController {
    
    UINavigationController *navigationViewController = (UINavigationController *)viewController;
    if ([navigationViewController.topViewController isKindOfClass:[WLINewPostViewController class]]) {
        WLINewPostViewController *newPostViewController = [[WLINewPostViewController alloc] initWithNibName:@"WLINewPostViewController" bundle:nil];
        UINavigationController *newPostNavigationController = [[UINavigationController alloc] initWithRootViewController:newPostViewController];
        newPostNavigationController.navigationBar.translucent = NO;
        [tabBarController presentViewController:newPostNavigationController animated:YES completion:nil];
        return NO;
    } else {
        return YES;
    }
}


#pragma mark - Other methods

- (void)createViewHierarchy {
    
    WLITimelineViewController *timelineViewController = [[WLITimelineViewController alloc] initWithNibName:@"WLITimelineViewController" bundle:nil];
    UINavigationController *timelineNavigationController = [[UINavigationController alloc] initWithRootViewController:timelineViewController];
    timelineNavigationController.navigationBar.translucent = NO;
    
    WLIPopularViewController *popularViewController = [[WLIPopularViewController alloc] initWithNibName:@"WLIPopularViewController" bundle:nil];
    UINavigationController *popularNavigationController = [[UINavigationController alloc] initWithRootViewController:popularViewController];
    popularNavigationController.navigationBar.translucent = NO;
    
    WLINewPostViewController *newPostViewController = [[WLINewPostViewController alloc] initWithNibName:@"WLINewPostViewController" bundle:nil];
    UINavigationController *newPostNavigationController = [[UINavigationController alloc] initWithRootViewController:newPostViewController];
    newPostNavigationController.navigationBar.translucent = NO;
    
    WLINearbyViewController *nearbyViewController = [[WLINearbyViewController alloc] initWithNibName:@"WLINearbyViewController" bundle:nil];
    UINavigationController *nearbyNavigationController = [[UINavigationController alloc] initWithRootViewController:nearbyViewController];
    nearbyNavigationController.navigationBar.translucent = NO;
    
    WLIProfileViewController *profileViewController = [[WLIProfileViewController alloc] initWithNibName:@"WLIProfileViewController" bundle:nil];
    UINavigationController *profileNavigationController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    profileNavigationController.navigationBar.translucent = NO;
    
    self.tabBarController = [[WLITabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.tabBarController.viewControllers = @[timelineNavigationController, popularNavigationController,newPostNavigationController, nearbyNavigationController, profileNavigationController];

    UITabBarItem *timelineTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Timeline" image:[[UIImage imageNamed:@"tabbar-timeline"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar-timeline"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    timelineViewController.tabBarItem = timelineTabBarItem;
    UITabBarItem *popularTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Popular" image:[[UIImage imageNamed:@"tabbar-popular"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar-popular"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    popularViewController.tabBarItem = popularTabBarItem;
    UITabBarItem *newPostTabBarItem = [[UITabBarItem alloc] initWithTitle:@"New post" image:[[UIImage imageNamed:@"tabbar-newpost"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar-newpost"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    newPostViewController.tabBarItem = newPostTabBarItem;
    UITabBarItem *nearbyTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Nearby" image:[[UIImage imageNamed:@"tabbar-nearby"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar-nearby"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    nearbyViewController.tabBarItem = nearbyTabBarItem;
    UITabBarItem *profileTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[[UIImage imageNamed:@"tabbar-profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar-profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    profileViewController.tabBarItem = profileTabBarItem;
    
    self.window.rootViewController = self.tabBarController;
}

@end
