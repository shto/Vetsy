//
//  FEFacebookObject.h
//  Vetsy
//
//  Created by Andrei on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YAJLiOS/YAJL.h>
#import "FEProxy.h"
#import "FESessionSingleton.h"

#define kFacebookGraphURL               @"https://graph.facebook.com/"

@protocol FacebookObjectDelegate <NSObject>

- (void)populateObject:(NSData *)data;

@end

@interface FacebookObject : NSObject <FEProxyProtocol, FacebookObjectDelegate> {
    NSString *objectFacebookGraphID;
    BOOL loaded;
    
    FEProxy *proxy;
}

@property (nonatomic, readonly) NSString *objectFacebookGraphID;
@property (nonatomic, readonly) BOOL loaded;

- (id)initWithID:(NSString *)objectID;

@end
