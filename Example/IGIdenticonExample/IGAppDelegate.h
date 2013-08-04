//
//  IGAppDelegate.h
//  IGIdenticonExample
//
//  Created by Evgeniy Yurtaev on 8/2/13.
//  Copyright (c) 2013 Evgeniy Yurtaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IGViewController;

@interface IGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) IGViewController *viewController;

@end
