//
//  AccountViewModel.h
//  TemplateObjC
//
//  Created by Dung Do on 3/11/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountModel.h"

@interface AccountViewModel : NSObject

@property(nonatomic, strong) NSMutableArray<AccountModel *> *arrAccount;

- (id)init;
- (void)loadAccounts;
- (void)saveAccounts;
- (void)clearAccounts;

@end
