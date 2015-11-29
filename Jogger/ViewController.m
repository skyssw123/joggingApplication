//
//  ViewController.m
//  Jogger
//
//  Created by Thomas Sin on 2015-11-28.
//  Copyright © 2015 sin. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapViewController = [[[NSBundle mainBundle] loadNibNamed:@"MapView" owner:self options:nil] objectAtIndex:0];
    
    
    
    [self addChildViewController:self.mapViewController];
    self.mapViewController.mapView.frame = self.viewForMap.frame;
    [self.viewForMap addSubview:self.mapViewController.mapView];
}

- (void)viewWillAppear:(BOOL)animated
{

}

- (IBAction)startButtonClicked:(id)sender {
//    CLLocation *location = [self.locationManager location];
//    //MKOverlayView* overlayView = [self.mapView a];
//    [self.mapView setCenterCoordinate:location.coordinate animated:YES];
}
@end
