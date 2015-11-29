//
//  MapViewController.h
//  Jogger
//
//  Created by Thomas Sin on 2015-11-29.
//  Copyright © 2015 sin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Pin.h"

@interface MapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* currentLocation;
@property (strong, nonatomic) MKPolyline* polyline;
@property (strong, nonatomic) MKPolylineView* lineView;
@property (strong, nonatomic) NSMutableArray* allPins;
@property (nonatomic, strong) NSMutableArray* locArray;

@end
