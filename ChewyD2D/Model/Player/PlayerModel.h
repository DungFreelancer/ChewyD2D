//
//  UserModel.h
//  TemplateObjC
//
//  Created by Dung Do on 3/11/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerModel : NSObject <NSCoding>

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *phone;
@property(strong, nonatomic) NSString *reward;
@property(strong, nonatomic) NSDate *date;
@property(strong, nonatomic) NSString *location;

@end
