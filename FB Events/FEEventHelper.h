//
//  FEEventHelper.h
//  Vetsy
//
//  Created by Andrei on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
#import "Event.h"

@interface FEEventHelper : NSObject

+ (BOOL)addEventToCalendar:(Event *)event error:(NSError **)error;

@end
