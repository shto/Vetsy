//
//  FEMainViewController.m
//  FB Events
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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    viewLoadingEvents.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    if ([[FESessionSingleton sharedSession] eventsURL]) {
        // load events
        FEEventLoader *eventLoader = [[FEEventLoader alloc] initWithEventsURL:[[FESessionSingleton sharedSession] eventsURL]
                                                                  andDelegate:self];
        [eventLoader startGettingEvents];
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

#pragma mark - FEEventLoaderDelegate

- (void)eventsLoaded:(NSArray *)events {
    viewLoadingEvents.hidden = YES;
    labelNumberOfEvents.text = [NSString stringWithFormat:@"Number of events: %d", [events count]];
    
    for (Event *event in events) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@", event.start_time]];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
        NSInteger hourStart = [components hour];
        
        date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@", event.end_time]];
        components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
        NSInteger hourEnd = [components hour];
        
        NSLog(@"event name: %@\nevent start hour:%d\nevent end hour:%d\n",
              event.name, hourStart, hourEnd);
    }
}

@end
