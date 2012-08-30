//
//  FEAppDelegate.h
//  FB Events
//
//  Created by Andrei on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "FESessionSingleton.h"
#import "FEMainViewController.h"

@class FELoginViewController;

@interface FEAppDelegate : UIResponder <UIApplicationDelegate> {
    FBSession *sharedSession;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FELoginViewController *viewController;

@end
