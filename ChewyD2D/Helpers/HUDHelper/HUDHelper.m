//
//  MBProgressHUD+Title.m
//  Demo
//
//  Created by Dung Do on 9/18/16.
//  Copyright © 2016 Dung Do. All rights reserved.
//

#import "HUDHelper.h"

@implementation HUDHelper {
    UIView *oldView;
}

@synthesize hud;

+ (HUDHelper *)sharedInstance {
    static HUDHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HUDHelper alloc] init];
    });
    return instance;
}

- (void)showLoadingWithTitle:(nonnull NSString *)title onView:(UIView *)view {
    if (view != oldView) {
        self.hud = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:self.hud];
        oldView = view;
    }
    
    if (title == nil || [title isEqualToString:@""]) {
        self.hud.label.text = @"Loading...";
    } else {
        self.hud.label.text = title;
    }
    
    [self.hud showAnimated:TRUE];
}

- (void) hideLoading {
    [self.hud hideAnimated:TRUE];
}

- (void)showToastWithMessage:(NSString *)message onView:(UIView *)view {
    MBProgressHUD *toast = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:toast];
    
    toast.mode = MBProgressHUDModeText;
    toast.detailsLabel.text = message;
    [toast.detailsLabel setFont:[UIFont boldSystemFontOfSize:17]];
    toast.margin = 10.f;
    [toast setOffset:CGPointMake(0, 275.f)];
    [toast showAnimated:TRUE];
    [toast hideAnimated:TRUE afterDelay:2.5];
}

@end
