//
//  AccountViewModel.m
//  TemplateObjC
//
//  Created by Dung Do on 3/11/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import "AccountViewModel.h"
#import "UtilityClass.h"

@implementation AccountViewModel

- (id)init{
    if (self = [super init]) {
        self.arrAccount = [[NSMutableArray<AccountModel *> alloc] init];
        [self loadAccounts];
    }
    
    return self;
}

- (void)loadAccounts {
    NSString *path = [NSString stringWithFormat:@"%@/%@", [[UtilityClass sharedInstance] applicationDocumentDirectoryString], @"Accounts.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.arrAccount = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
}

- (void)saveAccounts {
    NSString *path = [NSString stringWithFormat:@"%@/%@", [[UtilityClass sharedInstance] applicationDocumentDirectoryString], @"Accounts.plist"];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject: self.arrAccount];
    [data writeToFile:path atomically:YES];
}

- (void)clearAccounts {
    NSString *path = [NSString stringWithFormat:@"%@/%@", [[UtilityClass sharedInstance] applicationDocumentDirectoryString], @"Accounts.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        [fileManager removeItemAtPath:path error:nil];
        [self.arrAccount removeAllObjects];
    }
}

@end
