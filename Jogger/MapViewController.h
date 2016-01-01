//
//  MapViewController.h
//  Jogger
//
//  Created by Thomas Sin on 2015-12-11.
//  Copyright © 2015 sin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Trip.h"
#import "TripDrawer.h"
#import "TripFactory.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, MKAnnotation>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) TripDrawer* tripDrawer;
@property (strong, nonatomic) Trip* trip;
@end
