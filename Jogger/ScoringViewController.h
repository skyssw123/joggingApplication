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

@end
