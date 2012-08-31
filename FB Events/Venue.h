//
//  Venue.h
//  Vetsy
//
//  Created by Andrei on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FacebookObject.h"

@interface Venue : FacebookObject

@property (nonatomic, retain) NSString *street;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, readwrite) CGPoint geoCoordinates;

@end
