//
//  ViewController.m
//  Jogger
//
//  Created by Thomas Sin on 2015-11-28.
//  Copyright © 2015 sin. All rights reserved.
//

#import "MapViewController.h"
#import "Localizable.strings"
#import "Colors.h"

@interface MapViewController ()
@property BOOL isTripBeingRecorded;
@property NSTimeInterval prevTimestamp;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.allPins = [[NSMutableArray alloc]init];
    [self.startButton setTitle:@"START TRIP" forState:UIControlStateNormal];
    self.startButton.backgroundColor = PRIMARY_BRAND_COLOR;
    self.startButton.tintColor = PRIMARY_TEXT_COLOR;
    //[self.startButton setTitleColor:PRIMARY_TEXT_COLOR forState:UIControlStateNormal];
    
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsUserLocation = YES;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestAlwaysAuthorization];
    
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(addPin:)];
    recognizer.minimumPressDuration = 0.5;
    [self.mapView addGestureRecognizer:recognizer];
}


- (void)viewWillAppear:(BOOL)animated
{

}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSTimeInterval timeInMiliseconds = [newLocation.timestamp timeIntervalSince1970];
    NSLog(@"timestamp Mili  %f", timeInMiliseconds);
    NSLog(@"timestamp   %@", newLocation.timestamp);
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    if(timeInMiliseconds - self.prevTimestamp > 15)
    {
        [self.mapView setCenterCoordinate:newLocation.coordinate animated:YES];
        [self.allLocs addObject:newLocation];
        self.prevTimestamp = timeInMiliseconds;
    }
}

- (IBAction)startButtonClicked:(id)sender
{
    if(self.isTripBeingRecorded)
    {
        [self.locationManager stopUpdatingLocation];
        [self.startButton setTitle:@"START TRIP" forState:UIControlStateNormal];
        self.isTripBeingRecorded = NO;
        [self drawLineAtOnce:self.allLocs withColor:[UIColor blackColor] withLineWidth:10];
    }
    
    else
    {
        self.allLocs = [[NSMutableArray alloc]init];
        [self.locationManager startUpdatingLocation];
        [self.startButton setTitle:@"STOP TRIP" forState:UIControlStateNormal];
        self.isTripBeingRecorded = YES;
    }
}

- (void)addPin:(UIGestureRecognizer *)recognizer {
    
    if (recognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    // convert touched position to map coordinate
    CGPoint userTouch = [recognizer locationInView:self.mapView];
    CLLocationCoordinate2D mapPoint = [self.mapView convertPoint:userTouch toCoordinateFromView:self.mapView];
    
    // and add it to our view and our array
    Pin *newPin = [[Pin alloc]initWithCoordinate:mapPoint];
    
    
    [self.mapView addAnnotation:newPin];
    [self.allPins addObject:newPin];
    [self drawLineAtOnce:self.allPins withColor:[UIColor blackColor] withLineWidth:10];
    
}
- (void)drawLineAtOnce:(NSMutableArray*)allPins withColor:(UIColor*)color withLineWidth:(int)lineWidth
{
    [self.mapView removeOverlay:self.polyline];
    // create an array of coordinates from allPins
    CLLocationCoordinate2D coordinates[allPins.count];
    int i = 0;
    for (CLLocation *currentPin in allPins) {
        coordinates[i] = currentPin.coordinate;
        i++;
    }
    
    self.polyline = [MKPolyline polylineWithCoordinates:coordinates count:allPins.count];
    self.lineView = [[MKPolylineView alloc] initWithPolyline:self.polyline];
    self.lineView.strokeColor = color;
    self.lineView.lineWidth = lineWidth;

    [self.mapView addOverlay:self.polyline];
    
    // for a laugh: how many polylines are we drawing here?
    self.title = [[NSString alloc]initWithFormat:@"%lu", (unsigned long)self.mapView.overlays.count];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    return self.lineView;
}

@end
