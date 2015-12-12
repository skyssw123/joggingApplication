//
//  ViewController.m
//  Jogger
//
//  Created by Thomas Sin on 2015-11-28.
//  Copyright © 2015 sin. All rights reserved.
//

#import "RecordTripViewController.h"
#import "AppDelegate.h"
#import "Localizable.strings"
#import "Colors.h"
#import "Numbers.h"

@interface RecordTripViewController ()
@property BOOL isTripBeingRecorded;
@property NSTimeInterval prevTimestamp;
@property FileLogging* fileLogger;
@end

@implementation RecordTripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allPins = [[NSMutableArray alloc]init];
    self.fileLogger = [FileLogging sharedInstance];
    [self.startButton setTitle:@"START TRIP" forState:UIControlStateNormal];
    self.startButton.backgroundColor = PRIMARY_BRAND_COLOR;
    self.startButton.tintColor = PRIMARY_TEXT_COLOR;
    //[self.startButton setTitleColor:PRIMARY_TEXT_COLOR forState:UIControlStateNormal];
    
    self.locationManager = [(AppDelegate*)[[UIApplication sharedApplication] delegate] locationManager] ;
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestAlwaysAuthorization];
    
    self.mapViewController.view.frame = self.viewForMap.frame;
    self.mapViewController = [[MapViewController alloc]initWithNibName:@"MapView" bundle:nil];
    [self addChildViewController:self.mapViewController];
    [self.viewForMap addSubview:self.mapViewController.view];
    [self.mapViewController didMoveToParentViewController:self];
    
//    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(addPin:)];
//    recognizer.minimumPressDuration = 0.5;
//    [self.mapView addGestureRecognizer:recognizer];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
}

- (void)viewWillDisappear:(BOOL)animated
{
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSTimeInterval timeInMiliseconds = [newLocation.timestamp timeIntervalSince1970] * 1000;
    NSDate* timestamp = [newLocation timestamp];
    double latitude = [newLocation coordinate].latitude;
    double longitude = [newLocation coordinate].longitude;
    double speed = [newLocation speed];
    double horizontalAccuracy = [newLocation horizontalAccuracy];
    double verticalAccuracy = [newLocation verticalAccuracy];
    double altitude = [newLocation altitude];
    
    NSString* logString = [NSString stringWithFormat:@"timestamp=%@,latitude=%g,longitude=%g,speed=%g,horizontalAccuracy=%g,verticalAccuracy=%g,altitude=%g", timestamp, latitude, longitude, speed, horizontalAccuracy, verticalAccuracy, altitude];
    
    //[self.mapView setCenterCoordinate:newLocation.coordinate animated:YES];
    [self.allLocs addObject:newLocation];
    self.prevTimestamp = timeInMiliseconds;
    
    [self.fileLogger log:logString];
}

- (IBAction)startButtonClicked:(id)sender
{
    if(self.isTripBeingRecorded)
    {
        [self.locationManager stopUpdatingLocation];
        [self.startButton setTitle:@"START TRIP" forState:UIControlStateNormal];
        self.isTripBeingRecorded = NO;
        //[self drawLineAtOnce:self.allLocs withColor:[UIColor blackColor] withLineWidth:10];
    }
    
    else
    {
        self.allLocs = [[NSMutableArray alloc]init];
        [self.locationManager startUpdatingLocation];
        [self.fileLogger log:@"START OF TRIP"];
        [self.startButton setTitle:@"STOP TRIP" forState:UIControlStateNormal];
        self.isTripBeingRecorded = YES;
    }
}


@end
