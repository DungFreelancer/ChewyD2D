//
//  LogViewModel.m
//  TemplateObjC
//
//  Created by Dung Do on 3/14/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import "LogViewModel.h"
#import "UtilityClass.h"

@implementation LogViewModel

- (id)init {
    if (self = [super init]) {
        self.arrLog = [[NSMutableArray<LogModel *> alloc] init];
        [self loadLogs];
    }
    
    return self;
}

- (void)loadLogs {
    NSString *path = [NSString stringWithFormat:@"%@/%@", [[UtilityClass sharedInstance] applicationDocumentDirectoryString], @"Logs.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.arrLog = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
}

- (void)saveLogs {
    NSString *path = [NSString stringWithFormat:@"%@/%@", [[UtilityClass sharedInstance] applicationDocumentDirectoryString], @"Logs.plist"];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject: self.arrLog];
    [data writeToFile:path atomically:YES];
}

- (void)clearLogs {
    NSString *path = [NSString stringWithFormat:@"%@/%@", [[UtilityClass sharedInstance] applicationDocumentDirectoryString], @"Logs.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        [fileManager removeItemAtPath:path error:nil];
        [self.arrLog removeAllObjects];
    }
}

@end
