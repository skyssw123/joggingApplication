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
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsUserLocation = YES;
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    self.locationManager = [[CLLocationManager alloc] init];
    
    bool a = [CLLocationManager locationServicesEnabled];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager requestAlwaysAuthorization];
    
    
    [self.locationManager startUpdatingLocation];
    
    
    
    self.geocoder = [[CLGeocoder alloc] init];
    
    
    CLLocation *location = [self.locationManager location];
    
    
    long latitude = location.coordinate.latitude;
    long longitude = location.coordinate.longitude;
    
    
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
}

- (IBAction)startButtonClicked:(id)sender {
    CLLocation *location = [self.locationManager location];
    long latitude = location.coordinate.latitude;
    long longitude = location.coordinate.longitude;
    [self.mapView setCenterCoordinate:location.coordinate animated:YES];
}


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"location delegation called..");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
