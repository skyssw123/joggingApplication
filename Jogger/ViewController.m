//
//  ViewController.m
//  Jogger
//
//  Created by Thomas Sin on 2015-11-28.
//  Copyright © 2015 sin. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@property BOOL isTripBeingRecorded;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isTripBeingRecorded = NO;
    self.mapViewController = [[[NSBundle mainBundle] loadNibNamed:@"MapView" owner:self options:nil] objectAtIndex:0];
    
    
    
    [self addChildViewController:self.mapViewController];
    self.mapViewController.mapView.frame = self.viewForMap.frame;
    [self.viewForMap addSubview:self.mapViewController.mapView];
}

- (void)viewWillAppear:(BOOL)animated
{

}

- (IBAction)startButtonClicked:(id)sender
{
    if(!self.isTripBeingRecorded)
    {
        self.isTripBeingRecorded = YES;
        [self.startButton setTitle:@"STOP TRIP" forState:UIControlStateNormal];
        [self.mapViewController.locationManager startUpdatingLocation];
    }
    else
    {
        self.isTripBeingRecorded = NO;
        [self.startButton setTitle:@"START TRIP" forState:UIControlStateNormal];
        [self.mapViewController.locationManager stopUpdatingLocation];
    }
}
@end
