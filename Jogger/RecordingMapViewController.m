//
//  RecordingMapViewController.m
//  Jogger
//
//  Created by Thomas Sin on 2015-12-25.
//  Copyright © 2015 sin. All rights reserved.
//

#import "RecordingMapViewController.h"
#import "Colors.h"

@interface RecordingMapViewController ()
@end

@implementation RecordingMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsUserLocation = YES;
    //[self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
//    
//   
//    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude - 0.003, (self.mapView.userLocation.coordinate.longitude));
//    
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.05 , 0.05);
//    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMake(centerCoordinate, span);
//    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
//    [self.mapView setRegion:adjustedRegion animated:YES];
//    [self.mapView regionThatFits:adjustedRegion];
    
    
    //centerCoord.longitude += self.mapView.region.span.longitudeDelta * 0.00004;
    
    // Do any additional setup after loading the view.
}



- (void)viewWillAppear:(BOOL)animated
{
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude - 0.002, (self.mapView.userLocation.coordinate.longitude));
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(centerCoordinate, 1200, 1200);
    [self.mapView setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if([overlay class] == MKPolyline.class)
    {
        MKOverlayView* overlayView = nil;
        MKPolyline* polyline = (MKPolyline *)overlay;
        MKPolylineView  * routeLineView = [[MKPolylineView alloc] initWithPolyline:polyline];
        if([polyline.title isEqualToString:@"routeLine"])
        {
            routeLineView.fillColor = [UIColor blackColor];
            routeLineView.strokeColor = [UIColor blackColor];
            routeLineView.lineWidth = 8;
        }
        
        overlayView = routeLineView;
        return overlayView;
    } else {
        return nil;
    }
    return nil;
}



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if (self.i == 0)
    {
        self.i ++;
        return nil;
    }
    
    else if (self.i == 1)
    {
        self.i++;
        MKPinAnnotationView* annView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
        annView.pinTintColor = PRIMARY_BUTTON_COLOR;
        return annView;
    }
    else if (self.i == 2)
    {
        self.i = 1;
        MKPinAnnotationView* annView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
        annView.pinTintColor = SECONDARY_BUTTON_COLOR;
        return annView;
    }
    
    else
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
