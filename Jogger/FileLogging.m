//
//  FileLogging.m
//  Jogger
//
//  Created by Thomas Sin on 2015-11-30.
//  Copyright © 2015 sin. All rights reserved.
//

#import "FileLogging.h"
#define DEFAULT_FILENAME @"logs.txt"

@implementation FileLogging

+ (FileLogging *)sharedInstance
{
    static FileLogging *sharedInstance = nil;
    static dispatch_once_t dispatchQueue;
    
    dispatch_once(&dispatchQueue, ^{
        sharedInstance = [[FileLogging alloc] init];
        sharedInstance.fileName = DEFAULT_FILENAME;
        sharedInstance.documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        sharedInstance.dirPath = sharedInstance.documentDirectory;
        sharedInstance.filePath = [NSString stringWithFormat:@"%@/%@", sharedInstance.documentDirectory, DEFAULT_FILENAME];
    });

    return sharedInstance;
}



- (void) log:(NSString *) message
{
    [self log:message createFileAutomatically:YES];
}



- (BOOL) log:(NSString *) message createFileAutomatically:(BOOL) autoCreate
{
    //#ifdef DEBUG
    NSFileHandle *fileHandler = [NSFileHandle fileHandleForWritingAtPath:self.filePath];
    NSString *content;
    BOOL fileCreated = NO;
    if(!fileHandler)
    {
        //create file
        [[NSFileManager defaultManager] createFileAtPath:self.filePath contents:nil attributes:nil];
        fileHandler = [NSFileHandle fileHandleForWritingAtPath:self.filePath];
        content = [NSString stringWithFormat:@"%@ %@", [[NSDate date] descriptionWithLocale:[NSLocale systemLocale]], message];
        if(self.fileHeaderMessage){
            [fileHandler writeData:[self.fileHeaderMessage dataUsingEncoding:NSUTF8StringEncoding]];
        }
        fileCreated = YES;
    }
    else
    {
        content = [NSString stringWithFormat:@"\n%@ %@", [[NSDate date] descriptionWithLocale:[NSLocale systemLocale]], message];
        [fileHandler seekToEndOfFile];
    }
    
    NSLog(@"%@", content);
    [fileHandler writeData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandler closeFile];
    //#endif
    return fileCreated;
}



- (NSString *) moveFileTo:(NSString *) directory withNewFileName:(NSString *) fileName
{
    NSString *newFilePath = [NSString stringWithFormat:@"%@/%@", directory, fileName];
    [[NSFileManager defaultManager] moveItemAtPath:self.filePath toPath:newFilePath error:nil];
    return newFilePath;
}



- (void) deleteFile:(NSError **)error
{
    [[NSFileManager defaultManager] removeItemAtPath:self.filePath error:error];
}



- (void) addFileHeaderMessage:(NSString *) header
{
    if(self.fileHeaderMessage)
        self.fileHeaderMessage = [self.fileHeaderMessage stringByAppendingString:header];
    else
        self.fileHeaderMessage = header;
    
    [self log:self.fileHeaderMessage];
}



@end