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

@interface FEMainViewController : UIViewController <FEEventLoaderDelegate> {
    NSArray *allEvents;
}

@property (nonatomic, assign) IBOutlet UIView *viewLoadingEvents;
@property (nonatomic, assign) IBOutlet UILabel *labelNumberOfEvents;

@end
