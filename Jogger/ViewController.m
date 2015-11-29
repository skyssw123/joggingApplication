//
//  ViewController.m
//  Jogger
//
//  Created by Thomas Sin on 2015-11-28.
//  Copyright © 2015 sin. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.allPins = [[NSMutableArray alloc]init];
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsUserLocation = YES;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    CLLocation *location = [self.locationManager location];
    
    
    long latitude = location.coordinate.latitude;
    long longitude = location.coordinate.longitude;
    
    
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
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
}

- (IBAction)startButtonClicked:(id)sender {
    CLLocation *location = [self.locationManager location];
    NSMutableArray* array = [self makeArray:location];
    //MKOverlayView* overlayView = [self.mapView a];
    [self.mapView setCenterCoordinate:location.coordinate animated:YES];
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
    
    [self drawLines:self];
    
}

- (IBAction)drawLines:(id)sender {
    
    // HACK: for some reason this only updates the map view every other time
    // and because life is too frigging short, let's just call it TWICE
    
    [self drawLineSubroutine];
    [self drawLineSubroutine];
    
}

- (IBAction)undoLastPin:(id)sender {
    
    // grab the last Pin and remove it from our map view
    Pin *latestPin = [self.allPins lastObject];
    [self.mapView removeAnnotation:latestPin];
    [self.allPins removeLastObject];
    
    // redraw the polyline
    [self drawLines:self];
}

- (void)drawLineSubroutine {
    
    // remove polyline if one exists
    [self.mapView removeOverlay:self.polyline];
    
    // create an array of coordinates from allPins
    CLLocationCoordinate2D coordinates[self.allPins.count];
    int i = 0;
    for (Pin *currentPin in self.allPins) {
        coordinates[i] = currentPin.coordinate;
        i++;
    }
    
    // create a polyline with all cooridnates
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coordinates count:self.allPins.count];
    [self.mapView addOverlay:polyline];
    self.polyline = polyline;
    
    // create an MKPolylineView and add it to the map view
    self.lineView = [[MKPolylineView alloc]initWithPolyline:self.polyline];
    self.lineView.strokeColor = [UIColor redColor];
    self.lineView.lineWidth = 5;
    
    // for a laugh: how many polylines are we drawing here?
    self.title = [[NSString alloc]initWithFormat:@"%lu", (unsigned long)self.mapView.overlays.count];
    
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    
    return self.lineView;
}

@end
