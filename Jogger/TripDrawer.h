//
//  TripDrawer.h
//  Jogger
//
//  Created by Thomas Sin on 2015-12-05.
//  Copyright © 2015 sin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Trip.h"

@interface TripDrawer : NSObject
- (id)initWithTrip:(Trip*)trip withMapView:(MKMapView*)mapView;
- (void)drawLineAtOnceWithColor:(UIColor*)color withLineWidth:(int)lineWidth;
@property (nonatomic, strong) MKPolyline* polyline;
@property (nonatomic, strong) MKPolylineView* lineView;
@property (nonatomic, strong) MKMapView* mapView;
@end
