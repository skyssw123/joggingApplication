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
    [self.startButton setTitle:@"Start Running" forState:UIControlStateNormal];
    self.startButton.backgroundColor = PRIMARY_BUTTON_COLOR;
    self.startButton.tintColor = PRIMARY_TEXT_COLOR;
    self.timeValueLabel.text = @"00 : 00 : 00.0";
    self.distanceValueLabel.text = @"0";
    self.caloriesValueLabel.text = @"0";
    
    self.speedValueLabel.text = @"0";
    
    self.locationManager = [(AppDelegate*)[[UIApplication sharedApplication] delegate] locationManager] ;
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestAlwaysAuthorization];
    
    
    self.recordingMapViewController = [[RecordingMapViewController alloc]initWithNibName:@"MapView" bundle:nil];
    self.recordingMapViewController.view.frame = CGRectMake(0.0, 0.0, self.viewForMap.frame.size.width, self.viewForMap.frame.size.height);
    
    CALayer* bottomBorder1 = [CALayer layer];
    bottomBorder1.frame = CGRectMake(0.0, 0.0, self.startButton.frame.size.width, 1);
    bottomBorder1.backgroundColor = [UIColor lightGrayColor].CGColor;
    CALayer* bottomBorder2 = [CALayer layer];
    bottomBorder2.frame = CGRectMake(0.0, 0.0, self.startButton.frame.size.width, 1);
    bottomBorder2.backgroundColor = [UIColor lightGrayColor].CGColor;
    CALayer* bottomBorder3 = [CALayer layer];
    bottomBorder3.frame = CGRectMake(0.0, 0.0, self.startButton.frame.size.width, 1);
    bottomBorder3.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.secondView.layer addSublayer:bottomBorder1];
    [self.thirdView.layer addSublayer:bottomBorder2];
    [self.fourthView.layer addSublayer:bottomBorder3];
    [self addChildViewController:self.recordingMapViewController];
    [self.viewForMap addSubview:self.recordingMapViewController.view];
    
    [self.recordingMapViewController didMoveToParentViewController:self];
    
//    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(addPin:)];
//    recognizer.minimumPressDuration = 0.5;
//    [self.mapView addGestureRecognizer:recognizer];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    //[self.startButton setEnabled:YES];
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
    
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(self.recordingMapViewController.mapView.userLocation.coordinate.latitude - 0.0015, (self.recordingMapViewController.mapView.userLocation.coordinate.longitude));
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(centerCoordinate, 1000, 1000);
    [self.recordingMapViewController.mapView setRegion:region animated:YES];
}

- (IBAction)startButtonClicked:(id)sender
{
    if(self.isTripBeingRecorded)
    {
        [self.locationManager stopUpdatingLocation];
        [self.startButton setTitle:@"Start Running" forState:UIControlStateNormal];
        self.startButton.backgroundColor = PRIMARY_BUTTON_COLOR;
        [self.timer invalidate];
        self.timer = nil;
        self.isTripBeingRecorded = NO;
        //[self drawLineAtOnce:self.allLocs withColor:[UIColor blackColor] withLineWidth:10];
    }
    
    else
    {
        self.startDate = [NSDate date];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        self.allLocs = [[NSMutableArray alloc]init];
        [self.locationManager startUpdatingLocation];
        [self.fileLogger log:@"START OF TRIP"];
        [self.startButton setTitle:@"Stop Running" forState:UIControlStateNormal];
        self.startButton.backgroundColor = SECONDARY_BUTTON_COLOR;
        self.isTripBeingRecorded = YES;
    }
}

- (void)updateTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH : mm : ss.S"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.timeValueLabel.text = timeString;
}

@end
