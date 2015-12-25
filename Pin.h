//
//  Pin.h
//  Jogger
//
//  Created by Thomas Sin on 2015-11-28.
//  Copyright © 2015 sin. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface Pin : MKAnnotationView

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate withTitle:(NSString*)title withSubtitle:(NSString*)subtitle;

@end