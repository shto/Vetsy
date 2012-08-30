//
//  FEMainViewController.h
//  FB Events
//
//  Created by Andrei on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEEventLoader.h"
#import "FESessionSingleton.h"

@interface FEMainViewController : UIViewController <FEEventLoaderDelegate> {
    
}

@property (nonatomic, assign) IBOutlet UIView *viewLoadingEvents;
@property (nonatomic, assign) IBOutlet UILabel *labelNumberOfEvents;

@end
