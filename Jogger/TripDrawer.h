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
#import "SpeedEvent.h"

@interface TripDrawer : NSObject
- (id)initWithTrip:(Trip*)trip withMapView:(MKMapView*)mapView;
- (void)drawLineAtOnceWithColor;
- (void)drawSpeedingEvents;
@property (nonatomic, strong) MKPolyline* polyline;
@property (nonatomic, strong) NSMutableArray* speedEventArray;
@property (nonatomic, strong) NSMutableArray* speedEventlineArray;
@property (nonatomic, strong) MKMapView* mapView;
@property (nonatomic, strong) Trip* trip;
@end
