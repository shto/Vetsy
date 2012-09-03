//
//  FEMainViewController.h
//  Vetsy
//
//  Created by Andrei on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEEventLoader.h"
#import "FEEventHelper.h"
#import "FESessionSingleton.h"
#import "FEEventsTableViewController.h"

#define kNumberOfLoadedEvents           @"numberOfLoadedEvents"

@interface FEMainViewController : UIViewController <FEEventLoaderDelegate> {
    NSArray *allEvents;
    FEEventLoader *eventLoader;
}

@property (nonatomic, assign) IBOutlet UIView *viewLoadingEvents;
@property (nonatomic, assign) IBOutlet UILabel *labelInformativeText;
@property (nonatomic, assign) IBOutlet UILabel *labelLoadingEvents;

@end
