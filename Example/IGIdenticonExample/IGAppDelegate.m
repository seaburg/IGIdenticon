//
//  IGAppDelegate.m
//  IGIdenticonExample
//
//  Created by Evgeniy Yurtaev on 8/2/13.
//  Copyright (c) 2013 Evgeniy Yurtaev. All rights reserved.
//

#import "IGAppDelegate.h"
#import "IGViewController.h"

@implementation IGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	UIViewController *viewController = [[IGViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navigationController.navigationBar.barTintColor = [UIColor colorWithRed:39/255.0 green:105/255.0 blue:176/255.0 alpha:1];
    navigationController.navigationBar.tintColor = [UIColor whiteColor];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
