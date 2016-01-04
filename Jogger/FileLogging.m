//
//  FileLogging.m
//  Jogger
//
//  Created by Thomas Sin on 2015-11-30.
//  Copyright © 2015 sin. All rights reserved.
//

#import "FileLogging.h"
#import "Localizable.strings"
#import "Settings.h"

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
        //content = [NSString stringWithFormat:@"%@ %@", [[NSDate date] descriptionWithLocale:[NSLocale systemLocale]], message];
        content = [NSString stringWithFormat:@"%@", message];
        if(self.fileHeaderMessage){
            [fileHandler writeData:[self.fileHeaderMessage dataUsingEncoding:NSUTF8StringEncoding]];
        }
        fileCreated = YES;
    }
    else
    {
        //content = [NSString stringWithFormat:@"\n%@ %@", [[NSDate date] descriptionWithLocale:[NSLocale systemLocale]], message];
        content = [NSString stringWithFormat:@"\n%@", message];
        [fileHandler seekToEndOfFile];
    }
    
    NSLog(@"%@", content);
    [fileHandler writeData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandler closeFile];
    //#endif
    return fileCreated;
}

- (BOOL) fileExists:(NSString *) fileName
{
    NSString *newFilePath = [NSString stringWithFormat:@"%@/%@", self.dirPath, fileName];
    return [[NSFileManager defaultManager] fileExistsAtPath:newFilePath];
}

- (NSString *) moveFileFrom:(NSString*)oldFileName withNewFileName:(NSString *) newFileName
{
    NSString *oldFilePath = [NSString stringWithFormat:@"%@/%@", self.dirPath, oldFileName];
    NSString *newFilePath = [NSString stringWithFormat:@"%@/%@", self.dirPath, newFileName];
    [[NSFileManager defaultManager] moveItemAtPath:oldFilePath toPath:newFilePath error:nil];
    return newFilePath;
}

- (void) deleteFile:(NSString *)fileName withError:(NSError **)error
{
    NSString *newFilePath = [NSString stringWithFormat:@"%@/%@", self.dirPath, fileName];
    [[NSFileManager defaultManager] removeItemAtPath:newFilePath error:error];
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