//
//  ViewController.h
//  Jogger
//
//  Created by Thomas Sin on 2015-11-28.
//  Copyright © 2015 sin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Pin.h"
#import "MapViewController.h"

@interface ViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIView *viewForMap;
@property (strong, nonatomic) MKPolyline* polyline;
@property (strong, nonatomic) MKPolylineView* lineView;
@property (strong, nonatomic) NSMutableArray* allPins;
@property (strong, nonatomic) MapViewController* mapViewController;


@end

