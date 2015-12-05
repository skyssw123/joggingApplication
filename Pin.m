//
//  Pin.m
//  Jogger
//
//  Created by Thomas Sin on 2015-11-28.
//  Copyright © 2015 sin. All rights reserved.
//

#import "Pin.h"

@implementation Pin

- (id)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate withTitle:(NSString*)title withSubtitle:(NSString*)subtitle
{
    
    self = [super init];
    if (self) {
        _coordinate = newCoordinate;
        _title = [title copy];
        _subtitle = [subtitle copy];
    }
    return self;
}

@end