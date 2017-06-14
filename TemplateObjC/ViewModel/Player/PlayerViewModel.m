//
//  UserViewModel.m
//  TemplateObjC
//
//  Created by Dung Do on 3/11/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import "PlayerViewModel.h"
#import "UtilityClass.h"

@implementation PlayerViewModel

- (id)init {
    if (self = [super init]) {
        self.arrPlayer = [[NSMutableArray<PlayerModel *> alloc] init];
        [self loadPlayers];
    }
    
    return self;
}

- (void)loadPlayers {
    NSString *path = [NSString stringWithFormat:@"%@/%@", [[UtilityClass sharedInstance] applicationDocumentDirectoryString], @"Players.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.arrPlayer = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
}

- (void)savePlayers {
    NSString *path = [NSString stringWithFormat:@"%@/%@", [[UtilityClass sharedInstance] applicationDocumentDirectoryString], @"Players.plist"];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject: self.arrPlayer];
    [data writeToFile:path atomically:YES];
}

- (void)clearPlayers {
    NSString *path = [NSString stringWithFormat:@"%@/%@", [[UtilityClass sharedInstance] applicationDocumentDirectoryString], @"Players.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        [fileManager removeItemAtPath:path error:nil];
        [self.arrPlayer removeAllObjects];
    }
}

@end
