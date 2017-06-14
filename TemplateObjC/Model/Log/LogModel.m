//
//  LogModel.m
//  TemplateObjC
//
//  Created by Dung Do on 3/14/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import "LogModel.h"

@implementation LogModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.location forKey:@"location"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [self init]) {
        self.name = [NSString stringWithFormat:@"%@", [aDecoder decodeObjectForKey:@"name"]];
        self.desc = [NSString stringWithFormat:@"%@", [aDecoder decodeObjectForKey:@"desc"]];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
    }
    
    return self;
}

@end
