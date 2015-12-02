//
//  FileReading.m
//  Jogger
//
//  Created by Thomas Sin on 2015-12-01.
//  Copyright © 2015 sin. All rights reserved.
//

#import "FileReading.h"
#import "Trip.h"
#import "Settings.h"

@implementation FileReading
+ (FileReading *)sharedInstance
{
    static FileReading *sharedInstance = nil;
    static dispatch_once_t dispatchQueue;
    
    dispatch_once(&dispatchQueue, ^{
        sharedInstance = [[FileReading alloc] init];
        sharedInstance.fileName = DEFAULT_FILENAME;
        sharedInstance.documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        sharedInstance.dirPath = sharedInstance.documentDirectory;
        sharedInstance.filePath = [NSString stringWithFormat:@"%@/%@", sharedInstance.documentDirectory, DEFAULT_FILENAME];
    });
    
    return sharedInstance;
}

-(NSString*)readFile:(TripPeriod)period
{
    NSData* wholeData = [self readWholeFile];
    NSString* stringData = [[NSString alloc]initWithData:wholeData encoding:NSUTF8StringEncoding];
    for()
}

-(NSData*)readWholeFile
{
    NSFileHandle *fileHandler = [NSFileHandle fileHandleForReadingAtPath:self.filePath];
    if(!fileHandler)
    {
        return nil;
    }
    else
    {
        return [fileHandler readDataToEndOfFile];
    }
}
@end
