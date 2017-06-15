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
    [aCoder encodeObject:self.reward forKey:@"reward"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.location forKey:@"location"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [self init]) {
        self.name = [NSString stringWithFormat:@"%@", [aDecoder decodeObjectForKey:@"name"]];
        self.phone = [NSString stringWithFormat:@"%@", [aDecoder decodeObjectForKey:@"phone"]];
        self.reward = [NSString stringWithFormat:@"%@", [aDecoder decodeObjectForKey:@"reward"]];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
    }
    
    return self;
}

@end
