//
//  ScoringViewController.m
//  Jogger
//
//  Created by Thomas Sin on 2015-12-11.
//  Copyright © 2015 sin. All rights reserved.
//

#import "ScoringViewController.h"
#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)


@interface ScoringViewController ()

@end

@implementation ScoringViewController
CAShapeLayer *openMenuShape;
CAShapeLayer *closedMenuShape;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.clock1ImageView.tintColor = [UIColor lightGrayColor];
    self.clock2ImageView.tintColor = [UIColor lightGrayColor];
    self.mapViewController = [[MapViewController alloc]initWithNibName:@"MapView" bundle:nil];
    self.mapViewController.view.frame = CGRectMake(0, 0, self.viewForMap.frame.size.width, self.viewForMap.frame.size.height);
    Trip* trip = [TripFactory produceTripWithLogs:lastTrip];
    
    [self updateLabel:trip];
    [self addChildViewController:self.mapViewController];
    [self.viewForMap addSubview:self.mapViewController.view];
    self.scrollView.alwaysBounceHorizontal = NO;
    self.dropdownMenuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
    self.dropdownMenuBarLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent:0.8];
    self.dropdownMenuBar.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [self.dropdownButton setImage:[UIImage imageNamed:@"dropdown-arrow.png"] forState:UIControlStateNormal];
    [self.dropdownButton setImage:[UIImage imageNamed:@"dropdown-arrow-upsidedown.png"] forState:UIControlStateHighlighted];
    self.dropdownButton.imageView.tintColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
    self.dropdownMenuView.hidden = YES;
}

-(void) updateLabel:(Trip*) trip
{
    if(trip == nil)
    {
        //Error banner goes in here!!
        return;
    }
    self.mapViewController.trip = trip;
    self.distanceValueLabel.text = [NSString stringWithFormat:@"%.2f", (trip.totalDistance / 1000.0) ];
    self.caloriesValueLabel.text =  [NSString stringWithFormat:@"%.2f", trip.calories ];
    self.speedValueLabel.text = [NSString stringWithFormat:@"%.2f", (trip.avgVelocity * 3600.0 / 1000.0) ];
    // Create date from the elapsed time
    NSTimeInterval timeInterval = [trip.endLoc.timestamp timeIntervalSinceDate:trip.startLoc.timestamp];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH : mm : ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.timeValueLabel.text = timeString;
    self.startValueLabel.text = [self getAddressFromLatLon:trip.startLoc.coordinate.latitude withLongitude:trip.startLoc.coordinate.longitude];
    self.endValueLabel.text = [self getAddressFromLatLon:trip.endLoc.coordinate.latitude withLongitude:trip.endLoc.coordinate.longitude];
}

-(NSString *)getAddressFromLatLon:(double)pdblLatitude withLongitude:(double)pdblLongitude
{
    //    https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=YOUR_API_KEY
    //server key : AIzaSyBsaSP3zPO0N_vnzB3PjGaCERZXDo7dmig
    NSString* serverKey = @"AIzaSyBsaSP3zPO0N_vnzB3PjGaCERZXDo7dmig";
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&key=%@",pdblLatitude, pdblLongitude, serverKey];
    NSError* error;
    
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    NSArray* locationArray = [dictionary valueForKey:@"results"];
    NSDictionary* locationDict = [locationArray objectAtIndex:0];
    NSString* locationString = [locationDict valueForKey:@"formatted_address"];
    //NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSASCIIStringEncoding error:&error];
   // locationString = [locationString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    return locationString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)dropdownButtonPressed:(id)sender {
    [self toggleMenu];
}

- (void) toggleMenu {
    if(self.dropdownMenuView.hidden)
    {
        [self showMenu];
    }
    else
    {
        [self hideMenu];
    }
}

- (void) showMenu
{
    self.dropdownMenuView.hidden = NO;
}

- (void) hideMenu
{
    self.dropdownMenuView.hidden = YES;
}

- (IBAction)firstWorkoutButtonPressed:(id)sender
{
    self.dropdownMenuBarLabel.text = @"First Work-out";
    [self updateLabel:[TripFactory produceTripWithLogs:firstTrip]];
    self.dropdownMenuView.hidden = YES;
}

- (IBAction)secondWorkoutButtonPressed:(id)sender
{
    self.dropdownMenuBarLabel.text = @"Second Work-out";
    [self updateLabel:[TripFactory produceTripWithLogs:secondTrip]];
    [self.mapViewController drawTrip];
    self.dropdownMenuView.hidden = YES;
}

- (IBAction)lastWorkoutButtonPressed:(id)sender
{
    self.dropdownMenuBarLabel.text = @"Last Work-out";
    [self updateLabel:[TripFactory produceTripWithLogs:lastTrip]];
    [self.mapViewController drawTrip];
    self.dropdownMenuView.hidden = YES;
}

- (IBAction)displayGestureForTapRecognizer:(UITapGestureRecognizer *)sender
{
    // Get the location of the gesture
    CGPoint tapLocation = [sender locationInView:self.view];
    // NSLog(@"Tap location X:%1.0f, Y:%1.0f", tapLocation.x, tapLocation.y);
    
    // If menu is open, and the tap is outside of the menu, close it.
    if (!CGRectContainsPoint(self.dropdownMenuView.frame, tapLocation) && !self.dropdownMenuView.hidden) {
        [self hideMenu];
    }
}
@end
