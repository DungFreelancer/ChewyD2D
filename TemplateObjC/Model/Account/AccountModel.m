//
//  Account.m
//  TemplateObjC
//
//  Created by Dung Do on 3/11/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.pass forKey:@"pass"];
    [aCoder encodeObject:self.role forKey:@"role"];
    [aCoder encodeBool:self.haveSetting forKey:@"haveSetting"];
    [aCoder encodeBool:self.havePlay forKey:@"havePlay"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [self init]) {
        self.ID = [NSString stringWithFormat:@"%@", [aDecoder decodeObjectForKey:@"ID"]];
        self.pass = [NSString stringWithFormat:@"%@", [aDecoder decodeObjectForKey:@"pass"]];
        self.role = [NSString stringWithFormat:@"%@", [aDecoder decodeObjectForKey:@"role"]];
        self.haveSetting = [aDecoder decodeBoolForKey:@"haveSetting"];
        self.havePlay = [aDecoder decodeBoolForKey:@"havePlay"];
    }
    
    return self;
}

@end
