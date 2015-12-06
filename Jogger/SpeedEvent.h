//
//  SpeedEvent.h
//  Jogger
//
//  Created by Thomas Sin on 2015-12-06.
//  Copyright © 2015 sin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SpeedEvent : NSObject
-(id)initWithLocationArray:(NSMutableArray*)array;
@property (nonatomic, strong) NSMutableArray* locationArray;
@end
