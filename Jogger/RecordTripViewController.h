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
#import "TripDrawer.h"
#import "RecordingMapViewController.h"

@interface RecordTripViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIView *viewForMap;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* currentLocation;
@property (strong, nonatomic) NSMutableArray* allPins;
@property (strong, nonatomic) NSMutableArray* allLocs;
@property (strong, nonatomic) RecordingMapViewController* recordingMapViewController;

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;
@end

