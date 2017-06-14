//
//  RewardView.m
//  TemplateObjC
//
//  Created by Dung Do on 3/10/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import "RewardView.h"
#import "UtilityClass.h"
#import "Constant.h"
#import "HUDHelper.h"
#import <CoreLocation/CoreLocation.h>
#import "LogViewModel.h"

@implementation RewardView {
    CLLocationManager *locationManager;
    LogViewModel *logVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getLocation];
    
    logVM = [[LogViewModel alloc] init];
    LogModel *log = [[LogModel alloc] init];
    log.name = LOG_GET_REWARD;
    NSString *rewardName;
    if (self.reward == 1) {
        rewardName = @"Trúng Vé";
    } else if (self.reward == 2) {
        rewardName = @"Trúng Nón";
    } else if (self.reward == 3) {
        rewardName = @"Trúng Móc Khoá";
    } else if (self.reward == 4) {
        rewardName = @"Trúng Voucher 10%";
    } else if (self.reward == 5) {
        rewardName = @"Trúng Voucher 20%";
    } else if (self.reward == 6) {
        rewardName = @"Trúng Voucher 50%";
    } else if (self.reward == 7) {
        rewardName = @"Trúng Voucher Mini Set";
    }
    log.desc = rewardName;
    log.date = [NSDate date];
    CLLocationCoordinate2D location = [self getLocation];
    log.location = [NSString stringWithFormat:@"%f, %f", location.latitude, location.longitude];
    [logVM loadLogs];
    [logVM.arrLog addObject:log];
    [logVM saveLogs];
    
    [self.imgReward setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Reward_%d", self.reward]]];
    
    [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(goBackToPlayer) userInfo:nil repeats:NO];
}

- (void)goBackToPlayer {
    if (self.reward == 1) {
        int amount = [[USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_1] intValue];
        [USER_DEFAULT setObject:[NSString stringWithFormat:@"%d", --amount] forKey:PREF_AMOUNT_REWARD_1];
    } else if (self.reward == 2) {
        int amount = [[USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_2] intValue];
        [USER_DEFAULT setObject:[NSString stringWithFormat:@"%d", --amount] forKey:PREF_AMOUNT_REWARD_2];
    } else if (self.reward == 3) {
        int amount = [[USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_3] intValue];
        [USER_DEFAULT setObject:[NSString stringWithFormat:@"%d", --amount] forKey:PREF_AMOUNT_REWARD_3];
    } else if (self.reward == 4) {
        int amount = [[USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_4] intValue];
        [USER_DEFAULT setObject:[NSString stringWithFormat:@"%d", --amount] forKey:PREF_AMOUNT_REWARD_4];
    } else if (self.reward == 5) {
        int amount = [[USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_5] intValue];
        [USER_DEFAULT setObject:[NSString stringWithFormat:@"%d", --amount] forKey:PREF_AMOUNT_REWARD_5];
    } else if (self.reward == 6) {
        int amount = [[USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_6] intValue];
        [USER_DEFAULT setObject:[NSString stringWithFormat:@"%d", --amount] forKey:PREF_AMOUNT_REWARD_6];
    } else if (self.reward == 7) {
        int amount = [[USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_7] intValue];
        [USER_DEFAULT setObject:[NSString stringWithFormat:@"%d", --amount] forKey:PREF_AMOUNT_REWARD_7];
    }
    
    [USER_DEFAULT synchronize];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (CLLocationCoordinate2D)getLocation {
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    return coordinate;
}

@end
