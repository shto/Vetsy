//
//  FEEventsTableViewController.h
//  Vetsy
//
//  Created by Andrei on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface FEEventsTableViewController : UITableViewController {
    NSArray *events;
}

@property (nonatomic, retain) NSArray *events;

@end
