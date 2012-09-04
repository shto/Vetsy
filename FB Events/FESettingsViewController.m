//
//  FESettingsViewController.m
//  Vetsy
//
//  Created by Andrei on 9/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FESettingsViewController.h"

@interface FESettingsViewController ()

@end

@implementation FESettingsViewController

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

- (IBAction)clearPreviouslySyncedEvents:(id)sender {
    NSString *actionSheetTitle = @"Are you sure you want to remove all synced Facebook events from your calendar?";
    UIActionSheet *areYouSureActionSheet = [[UIActionSheet alloc] initWithTitle:actionSheetTitle
                                                                       delegate:self
                                                              cancelButtonTitle:@"No, never mind"
                                                         destructiveButtonTitle:@"Yes, delete synced events" 
                                                              otherButtonTitles:nil];
    
    [areYouSureActionSheet showInView:self.view];
    [areYouSureActionSheet release];
}

#pragma mark - UIActionSheet Delegate methods

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
        {
            // Yes, remove
            NSError *error = nil;
            BOOL successfullyRemoved = [FEEventHelper removeSyncedEvents:&error];
            if (!successfullyRemoved) {
                NSLog(@"not successfully removed: %@", [error localizedDescription]);
            }
            break;
        }
        case 1:
            // Never mind
            break;
        default:
            break;
    }
}

@end
