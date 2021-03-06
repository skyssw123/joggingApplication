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
#import "Trip.h"
#import "TripFactory.h"
#import "TripDrawer.h"
#import "Numbers.h"
#import "Settings.h"
#import "ScoringViewController.h"
#import "TripFactory.h"

@interface RecordTripViewController ()
@property BOOL isTripBeingRecorded;
@property NSTimeInterval prevTimestamp;
@property FileLogging* fileLogger;
@end

@implementation RecordTripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.startButton setEnabled:NO];
    
    self.arrayCoords = [[NSMutableArray alloc]init];
    self.allPins = [[NSMutableArray alloc]init];
    self.fileLogger = [FileLogging sharedInstance];
    [self.startButton setTitle:@"Start Running" forState:UIControlStateNormal];
    self.startButton.backgroundColor = PRIMARY_BUTTON_COLOR;
    self.startButton.tintColor = PRIMARY_TEXT_COLOR;
    [self setValueLabelZero];
    
    self.saveButton.backgroundColor = PRIMARY_BUTTON_COLOR;
    self.saveButton.tintColor = PRIMARY_TEXT_COLOR;
    self.discardButton.backgroundColor = SECONDARY_BUTTON_COLOR;
    self.discardButton.tintColor = PRIMARY_TEXT_COLOR;
    self.saveDiscardButtonView.hidden = YES;
    
    self.locationManager = [(AppDelegate*)[[UIApplication sharedApplication] delegate] locationManager];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestAlwaysAuthorization];
    
    
    self.recordingMapViewController = [[RecordingMapViewController alloc]initWithNibName:@"MapView" bundle:nil];
    self.recordingMapViewController.view.frame = CGRectMake(0.0, 0.0, self.viewForMap.frame.size.width, self.viewForMap.frame.size.height);
    
//    CALayer* bottomBorder1 = [CALayer layer];
//    bottomBorder1.frame = CGRectMake(0.0, 0.0, self.startButton.frame.size.width, 1);
//    bottomBorder1.backgroundColor = [UIColor lightGrayColor].CGColor;
//    CALayer* bottomBorder2 = [CALayer layer];
//    bottomBorder2.frame = CGRectMake(0.0, 0.0, self.startButton.frame.size.width, 1);
//    bottomBorder2.backgroundColor = [UIColor lightGrayColor].CGColor;
//    CALayer* bottomBorder3 = [CALayer layer];
//    bottomBorder3.frame = CGRectMake(0.0, 0.0, self.startButton.frame.size.width, 1);
//    bottomBorder3.backgroundColor = [UIColor lightGrayColor].CGColor;
//    [self.secondView.layer addSublayer:bottomBorder1];
//    [self.thirdView.layer addSublayer:bottomBorder2];
//    [self.fourthView.layer addSublayer:bottomBorder3];

    [self addChildViewController:self.recordingMapViewController];
    [self.viewForMap addSubview:self.recordingMapViewController.view];
    
    [self.recordingMapViewController didMoveToParentViewController:self];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerExpired) userInfo:nil repeats:NO];
//    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(addPin:)];
//    recognizer.minimumPressDuration = 0.5;
//    [self.mapView addGestureRecognizer:recognizer];
    //[self.startButton setEnabled:YES];
}

- (void)setValueLabelZero
{
    self.timeValueLabel.text = @"00 : 00 : 00.0";
    self.distanceValueLabel.text = @"0";
    self.caloriesValueLabel.text = @"0";
    self.speedValueLabel.text = @"0";
}

- (void)timerExpired
{
    [self.timer invalidate];
    self.timer = nil;
    [self.startButton setEnabled:YES];
}

- (IBAction)hybridButtonClicked:(id)sender {
    self.recordingMapViewController.mapView.hidden = YES;
    [self.standardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.hybridButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.satelliteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.recordingMapViewController.mapView setMapType:MKMapTypeHybrid];
    self.recordingMapViewController.mapView.hidden = NO;
}

- (IBAction)satelliteButtonClicked:(id)sender {
    self.recordingMapViewController.mapView.hidden = YES;
    [self.standardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.hybridButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.satelliteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.recordingMapViewController.mapView setMapType:MKMapTypeSatellite];
    self.recordingMapViewController.mapView.hidden = NO;
}

- (IBAction)standardButtonClicked:(id)sender {
    self.recordingMapViewController.mapView.hidden = YES;
    [self.standardButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.hybridButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.satelliteButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.recordingMapViewController.mapView setMapType:MKMapTypeStandard];
    self.recordingMapViewController.mapView.hidden = NO;
}

- (IBAction)saveButtonClicked:(id)sender
{
    FileLogging* sharedInstance = [FileLogging sharedInstance];
    
    if(![sharedInstance fileExists:DEFAULT_FIRST_TRIP_FILENAME])
    {
        [sharedInstance moveFileFrom:DEFAULT_FILENAME withNewFileName:DEFAULT_FIRST_TRIP_FILENAME];
    }
    
    else if(![sharedInstance fileExists:DEFAULT_SECOND_TRIP_FILENAME])
    {
        [sharedInstance moveFileFrom:DEFAULT_FILENAME withNewFileName:DEFAULT_SECOND_TRIP_FILENAME];
    }
    
    else if(![sharedInstance fileExists:DEFAULT_LAST_TRIP_FILENAME])
    {
        [sharedInstance moveFileFrom:DEFAULT_FILENAME withNewFileName:DEFAULT_LAST_TRIP_FILENAME];
    }
    
    else
    {
        [sharedInstance deleteFile:DEFAULT_FIRST_TRIP_FILENAME withError:nil];
        [sharedInstance moveFileFrom:DEFAULT_SECOND_TRIP_FILENAME withNewFileName:DEFAULT_FIRST_TRIP_FILENAME];
        [sharedInstance moveFileFrom:DEFAULT_LAST_TRIP_FILENAME withNewFileName:DEFAULT_SECOND_TRIP_FILENAME];
        [sharedInstance moveFileFrom:DEFAULT_FILENAME withNewFileName:DEFAULT_LAST_TRIP_FILENAME];
    }
    
    UITabBarController *tabBarController = (UITabBarController *)self.navigationController.tabBarController;
    UINavigationController* navigationController = [tabBarController.childViewControllers objectAtIndex:0];
    ScoringViewController* scoringViewController = [navigationController.childViewControllers objectAtIndex:0];
    [scoringViewController updateData:[TripFactory produceTripWithLogs:lastTrip]];
    scoringViewController.dropdownMenuBarLabel.text = @"Last Work-out";
    self.saveDiscardButtonView.hidden = YES;
    self.startButton.hidden = NO;
    [self setValueLabelZero];
}

- (IBAction)discardButtonClicked:(id)sender
{
    [[FileLogging sharedInstance] deleteFile:DEFAULT_FILENAME withError:nil];
    self.saveDiscardButtonView.hidden = YES;
    self.startButton.hidden = NO;
    [self setValueLabelZero];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if(newLocation.horizontalAccuracy <= self.locationManager.desiredAccuracy)
        return;
    NSTimeInterval timeInMiliseconds = [newLocation.timestamp timeIntervalSince1970] * 1000;
    NSDate* timestamp = [newLocation timestamp];
    double latitude = [newLocation coordinate].latitude;
    double longitude = [newLocation coordinate].longitude;
    double speed = [newLocation speed];
    double horizontalAccuracy = [newLocation horizontalAccuracy];
    double verticalAccuracy = [newLocation verticalAccuracy];
    double altitude = [newLocation altitude];
    
    NSString* logString = [NSString stringWithFormat:@"timestamp=%@,latitude=%.16f,longitude=%.16f,speed=%.16f,horizontalAccuracy=%.16f,verticalAccuracy=%.16f,altitude=%.16f", timestamp, latitude, longitude, speed, horizontalAccuracy, verticalAccuracy, altitude];
    
    //[self.mapView setCenterCoordinate:newLocation.coordinate animated:YES];
    [self.allLocs addObject:newLocation];
    self.prevTimestamp = timeInMiliseconds;
    
    [self.fileLogger log:logString];
    
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(self.recordingMapViewController.mapView.userLocation.coordinate.latitude - 0.002, (self.recordingMapViewController.mapView.userLocation.coordinate.longitude));
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(centerCoordinate, 1200, 1200);
    [self.recordingMapViewController.mapView setRegion:region animated:YES];
    
    
    
    Trip* trip = [TripFactory produceTripWithLocations:self.allLocs];
    [self updateLabelAndDrawRoute:trip];
    
    
//    CLLocationCoordinate2D coords[self.allLocs.count];
//    int i = 0;
//    for (CLLocation* object in self.allLocs) {
//        coords[i] = object.coordinate;
//        i++;
//    }
//    
//    [self.recordingMapViewController.mapView removeOverlay:self.polyline];
//    self.polyline = [MKPolyline polylineWithCoordinates:coords count:self.allLocs.count];
//    [self.recordingMapViewController.mapView addOverlay:self.polyline];
}

- (void)updateLabelAndDrawRoute:(Trip*) trip
{
    self.distanceValueLabel.text = [NSString stringWithFormat:@"%.2f", (trip.totalDistance / 1000.0) ];
    self.caloriesValueLabel.text =  [NSString stringWithFormat:@"%.2f", trip.calories ];
    self.speedValueLabel.text = [NSString stringWithFormat:@"%.2f", (trip.avgVelocity * 3600.0 / 1000.0) ];
    if(KEEP_TRACK_USER_MODE)
        [[[TripDrawer alloc]initWithTrip:trip withMapView:self.recordingMapViewController.mapView] keepDrawingLine];
}

- (IBAction)startButtonClicked:(id)sender
{
    //Stop button clicked
    if(self.isTripBeingRecorded)
    {
        [self.startButton setTitle:@"Start Running" forState:UIControlStateNormal];
        
        self.startButton.backgroundColor = PRIMARY_BUTTON_COLOR;
        [self.timer invalidate];
        self.timer = nil;
        self.isTripBeingRecorded = NO;
        //[self drawLineAtOnce:self.allLocs withColor:[UIColor blackColor] withLineWidth:10];
        
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"HH:mm a, MMM dd, yyyy"];
        [self.recordingMapViewController.mapView addAnnotation:[[Pin alloc]initWithCoordinate:self.recordingMapViewController.mapView.userLocation.coordinate withTitle:@"Stop" withSubtitle:[df stringFromDate:[NSDate date]]]];
        
        self.startButton.hidden = YES;
        self.saveDiscardButtonView.hidden = NO;
        [self.locationManager stopUpdatingLocation];
        [self updateLabelAndDrawRoute:[TripFactory produceTripWithLogs:currentTrip]];
    }
    
    //Start button clicked
    else
    {
        [self removeAllPinsButUserLocation];
        FileLogging* sharedInstance = [FileLogging sharedInstance];
        if([sharedInstance fileExists:DEFAULT_FILENAME])
            [sharedInstance deleteFile:DEFAULT_FILENAME withError:nil];
        
        self.startDate = [NSDate date];
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"HH:mm a, MMM dd, yyyy"];
        [self.recordingMapViewController.mapView addAnnotation:[[Pin alloc]initWithCoordinate:self.recordingMapViewController.mapView.userLocation.coordinate withTitle:@"Start" withSubtitle:[df stringFromDate:self.startDate]]];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        self.allLocs = [[NSMutableArray alloc]init];
        [self.locationManager startUpdatingLocation];
        [self.fileLogger log:@"START OF TRIP"];
        [self.startButton setTitle:@"Stop Running" forState:UIControlStateNormal];
        self.startButton.backgroundColor = SECONDARY_BUTTON_COLOR;
        self.isTripBeingRecorded = YES;
    }
}

- (void)removeAllPinsButUserLocation
{
    CLLocation* userLocation = [self.recordingMapViewController.mapView userLocation];
    [self.recordingMapViewController.mapView removeAnnotations:[self.recordingMapViewController.mapView annotations]];
    
    if ( userLocation != nil ) {
        [self.recordingMapViewController.mapView addAnnotation:userLocation]; // will cause user location pin to blink
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
