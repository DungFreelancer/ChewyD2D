//
//  CALayer+Utility.h
//  Demo
//
//  Created by Dung Do on 10/30/16.
//  Copyright © 2016 Dung Do. All rights reserved.
//

#import <UIKit/UIKit.h> 

@interface CALayer (BorderShadow)

- (void)setBorderWithRadius:(CGFloat)radius Color:(CGColorRef)color;

- (void)setShadowWithRadius:(CGFloat)radius;

@end
