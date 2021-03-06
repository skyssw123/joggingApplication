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
@property (weak, nonatomic) IBOutlet UIView *fourthView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIView *viewForMap;
@property (weak, nonatomic) IBOutlet UILabel *timeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *caloriesValueLabel;
@property (strong, nonatomic) NSTimer* timer;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* currentLocation;
@property (strong, nonatomic) NSMutableArray* allPins;
@property (strong, nonatomic) NSMutableArray* allLocs;
@property (strong, nonatomic) RecordingMapViewController* recordingMapViewController;
@property (strong, nonatomic) NSDate* startDate;
@property (strong, nonatomic) MKPolyline* polyline;
@property (strong, nonatomic) NSMutableArray* arrayCoords;
@property (weak, nonatomic) IBOutlet UIButton *hybridButton;
@property (weak, nonatomic) IBOutlet UIButton *satelliteButton;
@property (weak, nonatomic) IBOutlet UIButton *standardButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *discardButton;
@property (weak, nonatomic) IBOutlet UIView *saveDiscardButtonView;

- (IBAction)hybridButtonClicked:(id)sender;
- (IBAction)satelliteButtonClicked:(id)sender;
- (IBAction)standardButtonClicked:(id)sender;
- (IBAction)saveButtonClicked:(id)sender;
- (IBAction)discardButtonClicked:(id)sender;
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;
@end

