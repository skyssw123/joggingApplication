//
//  ScoringViewController.m
//  Jogger
//
//  Created by Thomas Sin on 2015-12-11.
//  Copyright © 2015 sin. All rights reserved.
//

#import "ScoringViewController.h"

@interface ScoringViewController ()

@end

@implementation ScoringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapViewController = [[MapViewController alloc]initWithNibName:@"MapView" bundle:nil];
    self.mapViewController.view.frame = CGRectMake(0, 0, self.viewForMap.frame.size.width, self.viewForMap.frame.size.height);
    Trip* trip = [TripFactory produceTripWithLogs:lastTrip];
    self.mapViewController.trip = trip;
    [self addChildViewController:self.mapViewController];
    [self.viewForMap addSubview:self.mapViewController.view];
    
    self.scrollView.alwaysBounceHorizontal = NO;
    
    self.distanceValueLabel.text = [NSString stringWithFormat:@"%.2f", (trip.totalDistance / 1000.0) ];
    self.caloriesValueLabel.text =  [NSString stringWithFormat:@"%.2f", trip.calories ];
    self.speedValueLabel.text = [NSString stringWithFormat:@"%.2f", (trip.avgVelocity * 3600.0 / 1000.0) ];
    
    // Create date from the elapsed time
    NSTimeInterval timeInterval = [trip.endLoc.timestamp timeIntervalSinceDate:trip.startLoc.timestamp];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH : mm : ss.S"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.timeValueLabel.text = timeString;
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

@end
