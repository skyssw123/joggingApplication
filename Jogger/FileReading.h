//
//  FileReading.h
//  Jogger
//
//  Created by Thomas Sin on 2015-12-01.
//  Copyright © 2015 sin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TripFactory.h"

@interface FileReading : NSObject
@property (strong, nonatomic) NSString *fileHeaderMessage;
@property (strong, nonatomic) NSString *documentDirectory;
@property (strong, nonatomic) NSString *filePath;
@property (strong, nonatomic) NSString *dirPath;
@property (strong, nonatomic) NSString *fileName;
+ (FileReading *) sharedInstance;
- (NSString*)readFile:(TripPeriod)period;
@end
