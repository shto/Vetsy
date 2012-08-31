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

@synthesize labelNumberOfEvents;
@synthesize viewLoadingEvents;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    viewLoadingEvents.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    if ([[FESessionSingleton sharedSession] eventsURL] && !allEvents) {
        // load events
        FEEventLoader *eventLoader = [[FEEventLoader alloc] initWithEventsURL:[[FESessionSingleton sharedSession] eventsURL]
                                                                  andDelegate:self];
        [eventLoader startGettingEvents];
        [eventLoader release];
    }
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
    // first, get the stored set of event IDs + last updated
    
    // then get the set of Facebook IDs we have now + last updated
    
    // make a diff between the 2 and figure out which ones should be
    // taken again from Facebook - get back a set/array
    
    // save that array to Calendar
}

#pragma mark - FEEventLoaderDelegate

- (void)eventsLoaded:(NSArray *)events {
    allEvents = [events retain];
    viewLoadingEvents.hidden = YES;
    labelNumberOfEvents.text = [NSString stringWithFormat:@"Number of events: %d", [events count]];
    
    for (Event *event in events) {
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
//        NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@", event.start_time]];
//        NSCalendar *calendar = [NSCalendar currentCalendar];
//        NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
//        NSInteger hourStart = [components hour];
//        
//        date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@", event.end_time]];
//        components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
//        NSInteger hourEnd = [components hour];
//        
//        NSLog(@"event name: %@\nevent start hour:%d\nevent end hour:%d\n",
//              event.name, hourStart, hourEnd);
    }
}

@end
