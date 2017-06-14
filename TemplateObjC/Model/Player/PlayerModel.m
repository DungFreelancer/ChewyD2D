//
//  UserModel.m
//  TemplateObjC
//
//  Created by Dung Do on 3/11/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import "PlayerModel.h"

@implementation PlayerModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [self init]) {
        self.name = [NSString stringWithFormat:@"%@", [aDecoder decodeObjectForKey:@"name"]];
        self.phone = [NSString stringWithFormat:@"%@", [aDecoder decodeObjectForKey:@"phone"]];
    }
    
    return self;
}

@end
