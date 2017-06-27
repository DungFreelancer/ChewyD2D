//
//  LogModel.h
//  TemplateObjC
//
//  Created by Dung Do on 3/14/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogModel : NSObject <NSCoding>

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *desc;
@property(strong, nonatomic) NSDate *date;
@property(strong, nonatomic) NSString *location;

@end
