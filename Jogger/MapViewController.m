//
//  MapViewController.m
//  Jogger
//
//  Created by Thomas Sin on 2015-12-11.
//  Copyright © 2015 sin. All rights reserved.
//

#import "MapViewController.h"
#import "Colors.h"

@interface MapViewController ()
@end

@implementation MapViewController
int i = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsUserLocation = NO;
    
    Trip* trip = [TripFactory produceTripWithLogs:lastTrip];
    self.tripDrawer = [[TripDrawer alloc] initWithTrip:trip withMapView:self.mapView];
    [self.tripDrawer drawLineAtOnceWithColor];
    [self.tripDrawer drawSpeedingEvents];
    [self.tripDrawer drawBrakingEvents];
    
    CLLocationCoordinate2D centerCoord = CLLocationCoordinate2DMake( ((trip.minLatitude + trip.maxLatitude)/2.0), ((trip.minLongitude + trip.maxLongitude)/2.0));
    

    MKCoordinateSpan span = MKCoordinateSpanMake((trip.maxLatitude - trip.minLatitude) * 5, (trip.maxLongitude - trip.minLongitude) * 5);
    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMake(centerCoord, span);
    
    [self.mapView setRegion:adjustedRegion animated:YES];
    [self.mapView regionThatFits:adjustedRegion];
    
    
    
    // Do any additional setup after loading the view.
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
        } else if([polyline.title isEqualToString:@"speedLine"])
        {
            routeLineView.fillColor = [UIColor blueColor];
            routeLineView.strokeColor = [UIColor blueColor];
            routeLineView.lineWidth = 12;
        } else if([polyline.title isEqualToString:@"brakeLine"])
        {
            routeLineView.fillColor = [UIColor brownColor];
            routeLineView.strokeColor = [UIColor brownColor];
            routeLineView.lineWidth = 15;
        }
        
        overlayView = routeLineView;
        return overlayView;
    } else {
        return nil;
    }
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
//    if (i != 1)
//    {
//        i++;
//        MKPinAnnotationView* annView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
//        annView.pinTintColor = PRIMARY_BUTTON_COLOR;
//        return annView;
//    }
//    else
//    {
//        i = 0;
//        MKPinAnnotationView* annView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
//        annView.pinTintColor = SECONDARY_BUTTON_COLOR;
//        return annView;
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
