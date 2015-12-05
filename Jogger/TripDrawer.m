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
    if(trip == nil)
        return nil;
    self = [super init];
    if(self)
    {
        int i = 0;
        CLLocationCoordinate2D coordinates[trip.allLocs.count];
        for (CLLocation *currentPin in trip.allLocs) {
            coordinates[i] = currentPin.coordinate;
            i++;
    	}
    
        _trip = trip;
        _polyline = [MKPolyline polylineWithCoordinates:coordinates count:trip.allLocs.count];
        _lineView = [[MKPolylineView alloc] initWithPolyline:_polyline];
        _mapView = mapView;
        return self;
    }
    
    return nil;
}


- (void)drawLineAtOnceWithColor:(UIColor*)color withLineWidth:(int)lineWidth
{
    if(self == nil)
        return ;
    
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
