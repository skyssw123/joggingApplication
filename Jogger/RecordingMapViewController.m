//
//  RecordingMapViewController.m
//  Jogger
//
//  Created by Thomas Sin on 2015-12-25.
//  Copyright © 2015 sin. All rights reserved.
//

#import "RecordingMapViewController.h"

@interface RecordingMapViewController ()

@end

@implementation RecordingMapViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsUserLocation = YES;
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    //[self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
   
    
    
    
    //centerCoord.longitude += self.mapView.region.span.longitudeDelta * 0.00004;
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated:(BOOL)animated
{
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(self.mapView.userLocation.location.coordinate.latitude - 0.003, (self.mapView.userLocation.location.coordinate.longitude));
    [self.mapView setCenterCoordinate:centerCoordinate animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
//    if([overlay class] == MKPolyline.class)
//    {
//        MKOverlayView* overlayView = nil;
//        MKPolyline* polyline = (MKPolyline *)overlay;
//        MKPolylineView  * routeLineView = [[MKPolylineView alloc] initWithPolyline:polyline];
//        if([polyline.title isEqualToString:@"routeLine"])
//        {
//            routeLineView.fillColor = [UIColor blackColor];
//            routeLineView.strokeColor = [UIColor blackColor];
//            routeLineView.lineWidth = 8;
//        } else if([polyline.title isEqualToString:@"speedLine"])
//        {
//            routeLineView.fillColor = [UIColor blueColor];
//            routeLineView.strokeColor = [UIColor blueColor];
//            routeLineView.lineWidth = 12;
//        } else if([polyline.title isEqualToString:@"brakeLine"])
//        {
//            routeLineView.fillColor = [UIColor brownColor];
//            routeLineView.strokeColor = [UIColor brownColor];
//            routeLineView.lineWidth = 15;
//        }
//        
//        overlayView = routeLineView;
//        return overlayView;
//    } else {
//        return nil;
//    }
    return nil;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
