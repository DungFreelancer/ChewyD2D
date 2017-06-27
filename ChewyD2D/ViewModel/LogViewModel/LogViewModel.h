//
//  LogViewModel.h
//  TemplateObjC
//
//  Created by Dung Do on 3/14/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogModel.h"

@interface LogViewModel : NSObject

@property(nonatomic, strong) NSMutableArray<LogModel *> *arrLog;

- (id)init;
- (void)loadLogs;
- (void)saveLogs;
- (void)clearLogs;

@end
