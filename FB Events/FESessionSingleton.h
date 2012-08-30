//
//  FESessionSingleton.h
//  FB Events
//
//  Created by Andrei on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FESessionSingleton : NSObject {
    FBSession *session;
    
    NSString *eventsURL;
}

@property (strong, nonatomic) FBSession *session;
@property (strong, nonatomic) NSString *eventsURL;

+ (FBSession *)session;
+ (FESessionSingleton *)sharedSession;

@end
