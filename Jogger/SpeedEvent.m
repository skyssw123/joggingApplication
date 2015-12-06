//
//  SpeedEvent.m
//  Jogger
//
//  Created by Thomas Sin on 2015-12-06.
//  Copyright © 2015 sin. All rights reserved.
//

#import "SpeedEvent.h"

@implementation SpeedEvent
-(id)initWithLocationArray:(NSMutableArray*)array
{
    self = [super init];
    if(self)
    {
        _locationArray = [array copy];
    }
    return self;
}
@end
