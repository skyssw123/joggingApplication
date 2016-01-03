//
//  ScoringViewController.h
//  Jogger
//
//  Created by Thomas Sin on 2015-12-11.
//  Copyright © 2015 sin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface ScoringViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewForStartEnd;
@property (weak, nonatomic) IBOutlet UIView *viewForMap;
@property (weak, nonatomic) IBOutlet UIView *ViewForShinobiChart;
@property (strong, nonatomic) MapViewController* mapViewController;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *speedValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *caloriesValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceValueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *clock2ImageView;
@property (weak, nonatomic) IBOutlet UILabel *startValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *dropdownMenuLabel;
@property (weak, nonatomic) IBOutlet UIButton *dropdownButton;

@property (weak, nonatomic) IBOutlet UILabel *endValueLabel;
@property (weak, nonatomic) IBOutlet UIView *dropdownMenuView;
@property (weak, nonatomic) IBOutlet UIImageView *clock1ImageView;

- (IBAction)dropdownButtonPressed:(id)sender;
@end
