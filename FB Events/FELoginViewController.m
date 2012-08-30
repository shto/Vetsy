//
//  FEViewController.m
//  FB Events
//
//  Created by Andrei on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FELoginViewController.h"

@interface FELoginViewController ()

@end

@implementation FELoginViewController

@synthesize buttonLoginLogout;
@synthesize textNoteOrLink;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Facebook

// FBSample logic
// main helper method to update the UI to reflect the current state of the session.
- (void)updateView {
    // get the app delegate, so that we can reference the session property
    if (theSession.isOpen) {        
        // valid account UI is shown whenever the session is open
        [self.buttonLoginLogout setTitle:@"Log out" forState:UIControlStateNormal];
        [[FESessionSingleton sharedSession] setEventsURL:
         [NSString stringWithFormat:@"https://graph.facebook.com/me/events?access_token=%@", theSession.accessToken]];
                
        NSLog(@"token: https://graph.facebook.com/me/friends?access_token=%@", theSession.accessToken);
        [self dismissModalViewControllerAnimated:YES];
    } else {        
        // login-needed account UI is shown whenever the session is closed
        [self.buttonLoginLogout setTitle:@"Log in" forState:UIControlStateNormal];        
        [self.textNoteOrLink setText:@"Login to create a link to fetch account data"];        
    }
}

#pragma mark - IBActions

- (IBAction)loginToFacebook:(id)sender {
    // get session
    theSession = [FESessionSingleton session];
    
    // this button's job is to flip-flop the session from open to closed
    if (theSession.isOpen) {
        // if a user logs out explicitly, we delete any cached token information, and next
        // time they run the applicaiton they will be presented with log in UX again; most
        // users will simply close the app or switch away, without logging out; this will
        // cause the implicit cached-token login to occur on next launch of the application
        [theSession closeAndClearTokenInformation];
    } else {
        if (theSession.state != FBSessionStateCreated) {
            // Create a new, logged out session.
            theSession = [[FBSession alloc] init];
        }
        
        // if the session isn't open, let's open it now and present the login UX to the user
        [theSession openWithCompletionHandler:^(FBSession *session, 
                                                FBSessionState status, 
                                                NSError *error) {
            // and here we make sure to update our UX according to the new session state
            [self updateView];
        }];
    } 
}

@end
