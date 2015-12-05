//
//  ViewController.h
//  Jogger
//
//  Created by Thomas Sin on 2015-11-28.
//  Copyright © 2015 sin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripFactory.h"
#import <MapKit/MapKit.h>
#import "Pin.h"
#import "Localizable.strings"
#import "FileLogging.h"

@interface MapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* currentLocation;
@property (strong, nonatomic) MKPolyline* polyline;
@property (strong, nonatomic) MKPolylineView* lineView;
@property (strong, nonatomic) NSMutableArray* allPins;
@property (strong, nonatomic) NSMutableArray* allLocs;
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;
@end

