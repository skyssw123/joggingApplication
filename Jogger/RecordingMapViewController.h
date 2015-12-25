//
//  RecordingMapViewController.h
//  Jogger
//
//  Created by Thomas Sin on 2015-12-25.
//  Copyright © 2015 sin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Trip.h"
#import "TripDrawer.h"
#import "TripFactory.h"
@interface RecordingMapViewController : UIViewController<MKMapViewDelegate>
@property int i;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) TripDrawer* tripDrawer;
@end
