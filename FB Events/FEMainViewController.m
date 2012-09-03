//
//  FEMainViewController.m
//  Vetsy
//
//  Created by Andrei on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FEMainViewController.h"

@interface FEMainViewController ()

@end

@implementation FEMainViewController

@synthesize labelInformativeText;
@synthesize viewLoadingEvents;
@synthesize labelLoadingEvents;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        allEvents = nil;
    }
    return self;
}

- (void)dealloc
{
    [allEvents release];
    [super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary *)change 
                       context:(void *)context
{
    if ([keyPath isEqualToString:kNumberOfLoadedEvents]) {
        NSInteger newValue = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
        if (newValue == [allEvents count]) {
            labelInformativeText.text = @"Loaded all events. You can now sync.";
            viewLoadingEvents.hidden = YES;

            [eventLoader removeObserver:self forKeyPath:kNumberOfLoadedEvents];
            [eventLoader release];
        } else {
            labelLoadingEvents.text = [NSString stringWithFormat:@"Loading %d/%d events...",
                                        eventLoader.numberOfLoadedEvents, [allEvents count]];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    viewLoadingEvents.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    if ([[FESessionSingleton sharedSession] eventsURL] && !allEvents) {
        [self getEvents];
    }
}

- (void)getEvents {
    // load events
    eventLoader = [[FEEventLoader alloc] initWithEventsURL:[[FESessionSingleton sharedSession] eventsURL]
                                                              andDelegate:self];
    
    // add observer for changes to the number of loaded events counter
    [eventLoader addObserver:self
                  forKeyPath:kNumberOfLoadedEvents
                     options:NSKeyValueObservingOptionNew 
                     context:NULL];
    
    [eventLoader startGettingEvents];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - IBActions

- (IBAction)allEvents:(id)sender {
    FEEventsTableViewController *allEventsViewController = [[FEEventsTableViewController alloc] initWithNibName:@"FEEventsTableViewController" 
                                                                                                         bundle:nil];
    allEventsViewController.events = allEvents;
    [self.navigationController pushViewController:allEventsViewController animated:YES];
    [allEventsViewController release];
}

- (IBAction)syncNow:(id)sender {    
    // test: add 1 event
    Event *anEvent = [allEvents objectAtIndex:0];
    NSError *error = nil;
    BOOL success = YES;
    if (anEvent.loaded) {
        success = [FEEventHelper addEventToCalendar:anEvent error:&error];
    } else {
        NSLog(@"event not loaded yet. try again in a second.");
    }
    
    if (!success) {
        NSLog(@"There is a problem: %@", [error localizedDescription]);
    }
    
    // first, get the stored set of event IDs + last updated
    
    // then get the set of Facebook IDs we have now + last updated
    
    // make a diff between the 2 and figure out which ones should be
    // taken again from Facebook - get back a set/array
    
    // save that array to Calendar
}

#pragma mark - FEEventLoaderDelegate

- (void)eventsLoaded:(NSArray *)events {
    allEvents = [events retain];
}

@end
