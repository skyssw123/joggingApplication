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
    
    tripDrawer.polyline = [MKPolyline polylineWithCoordinates:coordinates count:trip.allLocs.count];
    tripDrawer.lineView = [[MKPolylineView alloc] initWithPolyline:tripDrawer.polyline];
    
    tripDrawer.mapView = mapView;
    
    return tripDrawer;
}

- (void)addPin:(UIGestureRecognizer *)recognizer {
    
//    if (recognizer.state != UIGestureRecognizerStateBegan) {
//        return;
//    }
//    
//    // convert touched position to map coordinate
//    CGPoint userTouch = [recognizer locationInView:self.mapView];
//    CLLocationCoordinate2D mapPoint = [self.mapView convertPoint:userTouch toCoordinateFromView:self.mapView];
//    
//    // and add it to our view and our array
//    Pin *newPin = [[Pin alloc]initWithCoordinate:mapPoint];
//    
//    
//    [self.mapView addAnnotation:newPin];
//    [self.allPins addObject:newPin];
//    [self drawLineAtOnce:self.allPins withColor:[UIColor blackColor] withLineWidth:10];
    
}
- (void)drawLineAtOnceWithColor:(UIColor*)color withLineWidth:(int)lineWidth
{
    // create an array of coordinates from allPins
    
    self.lineView.strokeColor = color;
    self.lineView.lineWidth = lineWidth;
    
    [self.mapView addOverlay:self.polyline];
}

- (void)removeOverlay
{
    [self.mapView removeOverlay:self.polyline];
}
@end
