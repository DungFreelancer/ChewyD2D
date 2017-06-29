//
//  RewardView.m
//  TemplateObjC
//
//  Created by Dung Do on 3/10/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import "RewardView.h"
#import "LogViewModel.h"
#import "PlayerViewModel.h"

@implementation RewardView {
    LogViewModel *logVM;
}

#pragma -
#pragma - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    CLLocationCoordinate2D location = [[UtilityClass sharedInstance] getLocation];
    log.location = [NSString stringWithFormat:@"%f, %f", location.latitude, location.longitude];
    [logVM loadLogs];
    [logVM.arrLog addObject:log];
    [logVM saveLogs];
    
    PlayerViewModel *playerVM = [[PlayerViewModel alloc] init];
    [playerVM loadPlayers];
    [playerVM.arrPlayer lastObject].reward = rewardName;
    [playerVM savePlayers];
    
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

@end
