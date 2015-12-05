//
//  TripDrawer.m
//  Jogger
//
//  Created by Thomas Sin on 2015-12-05.
//  Copyright © 2015 sin. All rights reserved.
//

#import "TripDrawer.h"
#import "Pin.h"

@implementation TripDrawer
- (id)initWithTrip:(Trip*)trip withMapView:(MKMapView*)mapView
{
    TripDrawer* tripDrawer = [[TripDrawer alloc] init];
    int i = 0;
    CLLocationCoordinate2D coordinates[trip.allLocs.count];
    for (CLLocation *currentPin in trip.allLocs) {
        coordinates[i] = currentPin.coordinate;
        i++;
    }
    
    tripDrawer.trip = trip;
    tripDrawer.polyline = [MKPolyline polylineWithCoordinates:coordinates count:trip.allLocs.count];
    tripDrawer.lineView = [[MKPolylineView alloc] initWithPolyline:tripDrawer.polyline];
    tripDrawer.mapView = mapView;
    
    return tripDrawer;
}


- (void)drawLineAtOnceWithColor:(UIColor*)color withLineWidth:(int)lineWidth
{
    // create an array of coordinates from allPins
    
    self.lineView.strokeColor = color;
    self.lineView.lineWidth = lineWidth;

    Pin* startPin = [[Pin alloc]initWithCoordinate:self.trip.startLoc.coordinate withTitle:@"START" withSubtitle:self.trip.startLoc.timestamp];
    [self.mapView addAnnotation:startPin];
    
    Pin* endPin = [[Pin alloc]initWithCoordinate:self.trip.endLoc.coordinate withTitle:@"END" withSubtitle:self.trip.endLoc.timestamp];
    [self.mapView addAnnotation:endPin];
    
    [self.mapView addOverlay:self.polyline];
}

- (void)removeOverlay
{
    [self.mapView removeOverlay:self.polyline];
}
@end
