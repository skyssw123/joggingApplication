//
//  MoreViewController.m
//  Jogger
//
//  Created by Thomas Sin on 2015-12-24.
//  Copyright © 2015 sin. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.weightValueTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"weightString"];
    if([self.weightValueTextField.text isEqualToString:@""])
        self.weightValueTextField.text = @"0";
    // Do any additional setup after loading the view.
    self.weightValueTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.weightValueTextField) {
        [theTextField resignFirstResponder];
        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:theTextField.text forKey:@"weightString"];
        [userDefaults setDouble:[theTextField.text doubleValue] forKey:@"weightDouble"];
    }
    return YES;
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
