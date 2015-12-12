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
    [self addChildViewController:self.mapViewController];
    [self.viewForMap addSubview:self.mapViewController.view];
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
