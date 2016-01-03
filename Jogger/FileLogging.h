//
//  FileLogging.h
//  Jogger
//
//  Created by Thomas Sin on 2015-11-30.
//  Copyright © 2015 sin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileLogging : NSObject
@property (strong, nonatomic) NSString *fileHeaderMessage;
@property (strong, nonatomic) NSString *documentDirectory;
@property (strong, nonatomic) NSString *filePath;
@property (strong, nonatomic) NSString *dirPath;
@property (strong, nonatomic) NSString *fileName;
+ (FileLogging *) sharedInstance;
- (void) log:(NSString *) message;
- (NSString *) moveFileTo:(NSString *) directory withNewFileName:(NSString *) fileName;
- (void) addFileHeaderMessage:(NSString *) header;
- (void) deleteFile:(NSError **)error;
@end
