//
//  Account.h
//  TemplateObjC
//
//  Created by Dung Do on 3/11/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject <NSCoding>

@property(strong, nonatomic) NSString *ID;
@property(strong, nonatomic) NSString *pass;
@property(strong, nonatomic) NSString *role;
@property(nonatomic) BOOL haveSetting;
@property(nonatomic) BOOL havePlay;

@end
