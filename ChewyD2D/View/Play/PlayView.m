//
//  PlayView.m
//  TemplateObjC
//
//  Created by Dung Do on 3/10/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import "PlayView.h"
#import "Constant.h"
#import "HUDHelper.h"
#import "RewardView.h"
#import "LogViewModel.h"
#import "UtilityClass.h"

@implementation PlayView {
    int loop, loopClock, stopPosition;
    NSTimer *run;
    short reward;
    LogViewModel *logVM;
    BOOL isTouch;
}

#pragma -
#pragma - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isTouch = NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segue_play_reward"]) {
        RewardView *viewReward = (RewardView *) [segue destinationViewController];
        viewReward.reward = reward;
    }
}

#pragma -
#pragma - On Click Event

- (IBAction)onClickRun:(id)sender {
    if (isTouch) {
        return;
    }
    isTouch = YES;
    
    reward = [self getReward];
    if (reward == 1) {
        stopPosition = 114; //Ve
    } else if (reward == 2) {
        stopPosition = 136; //Non
    } else if (reward == 3) {
        srand(0);
        short position = (arc4random() % 2);
        if (position == 0) {
            stopPosition = 125; //MocKhoa
        } else {
            stopPosition = 147; //MocKhoa
        }
    } else if (reward == 4) {
        stopPosition = 142; //10
    }  else if (reward == 5) {
        stopPosition = 119; //20
    } else if (reward == 6) {
        stopPosition = 153; //50
    } else {
        stopPosition = 131; //Set
    }
    
    if (reward != 0) {
        loop = 0;
        loopClock = 0;
        run = [NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(runWheel) userInfo:nil repeats:YES];
        
        logVM = [[LogViewModel alloc] init];
        LogModel *log = [[LogModel alloc] init];
        log.name = LOG_PLAY;
        log.desc = @"Vào quay thưởng";
        log.date = [NSDate date];
        CLLocationCoordinate2D location = [[UtilityClass sharedInstance] getLocation];
        log.location = [NSString stringWithFormat:@"%f, %f", location.latitude, location.longitude];
        [logVM loadLogs];
        [logVM.arrLog addObject:log];
        [logVM saveLogs];
    } else {
        // Total of reward amount is 0.
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)runWheel {
    if (loop == stopPosition) {
        [self hightlightRewardFirst:6 second:11 thrid:17 four:23 five:28 six:34 seven:39 eight:45];
        [run invalidate];
        run = nil;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"segue_play_reward" sender:nil];
        });
    } else {
        if (loop >= 108) {
            ++loop;
            ++loopClock;
            [self drawWheelWithAngle:8];
            DLOG(@"%d - %d", loopClock, loop);
            [self hightlightRewardFirst:6 second:11 thrid:17 four:23 five:28 six:34 seven:39 eight:45];
        } else if (loop >= 72) {
            ++loop;
            ++loopClock;
            [self drawWheelWithAngle:10];
            [self hightlightRewardFirst:4 second:9 thrid:14 four:18 five:22 six:27 seven:31 eight:36];
            if (loopClock == 36) {
                loopClock = 0;
            }
        } else if (loop >= 36) {
            ++loop;
            ++loopClock;
            [self drawWheelWithAngle:20];
            [self hightlightRewardFirst:2 second:4 thrid:7 four:9 five:11 six:13 seven:16 eight:18];
            if (loopClock == 18) {
                loopClock = 0;
            }
        } else {
            ++loop;
            ++loopClock;
            [self drawWheelWithAngle:30];
            [self hightlightRewardFirst:2 second:3 thrid:5 four:6 five:8 six:9 seven:11 eight:12];
            if (loopClock == 12) {
                loopClock = 0;
            }
        }
    }
}

- (void)drawWheelWithAngle:(float) angle {
    CGFloat radians = atan2f(self.imgWheel.transform.b, self.imgWheel.transform.a);
    CGFloat degrees = radians * (180 / M_PI);
    CGAffineTransform transform = CGAffineTransformMakeRotation((angle + degrees) * M_PI/180);
    self.imgWheel.transform = transform;
}

- (void)hightlightRewardFirst:(int)first second:(int)second thrid:(int)thrid four:(int)four five:(int)five six:(int)six seven:(int)seven eight:(int)eight{
    if (loopClock == first) {
        self.imgReward_1.hidden = NO;
        self.imgReward_2.hidden = YES;
        self.imgReward_3.hidden = YES;
        self.imgReward_4.hidden = YES;
        self.imgReward_5.hidden = YES;
        self.imgReward_6.hidden = YES;
        self.imgReward_7.hidden = YES;
        self.imgReward_8.hidden = YES;
    } else if (loopClock == second) {
        self.imgReward_1.hidden = YES;
        self.imgReward_2.hidden = NO;
        self.imgReward_3.hidden = YES;
        self.imgReward_4.hidden = YES;
        self.imgReward_5.hidden = YES;
        self.imgReward_6.hidden = YES;
        self.imgReward_7.hidden = YES;
        self.imgReward_8.hidden = YES;
    } else if (loopClock == thrid) {
        self.imgReward_1.hidden = YES;
        self.imgReward_2.hidden = YES;
        self.imgReward_3.hidden = NO;
        self.imgReward_4.hidden = YES;
        self.imgReward_5.hidden = YES;
        self.imgReward_6.hidden = YES;
        self.imgReward_7.hidden = YES;
        self.imgReward_8.hidden = YES;
    } else if (loopClock == four) {
        self.imgReward_1.hidden = YES;
        self.imgReward_2.hidden = YES;
        self.imgReward_3.hidden = YES;
        self.imgReward_4.hidden = NO;
        self.imgReward_5.hidden = YES;
        self.imgReward_6.hidden = YES;
        self.imgReward_7.hidden = YES;
        self.imgReward_8.hidden = YES;
    } else if (loopClock == five) {
        self.imgReward_1.hidden = YES;
        self.imgReward_2.hidden = YES;
        self.imgReward_3.hidden = YES;
        self.imgReward_4.hidden = YES;
        self.imgReward_5.hidden = NO;
        self.imgReward_6.hidden = YES;
        self.imgReward_7.hidden = YES;
        self.imgReward_8.hidden = YES;
    } else if (loopClock == six) {
        self.imgReward_1.hidden = YES;
        self.imgReward_2.hidden = YES;
        self.imgReward_3.hidden = YES;
        self.imgReward_4.hidden = YES;
        self.imgReward_5.hidden = YES;
        self.imgReward_6.hidden = NO;
        self.imgReward_7.hidden = YES;
        self.imgReward_8.hidden = YES;
    } else if (loopClock == seven) {
        self.imgReward_1.hidden = YES;
        self.imgReward_2.hidden = YES;
        self.imgReward_3.hidden = YES;
        self.imgReward_4.hidden = YES;
        self.imgReward_5.hidden = YES;
        self.imgReward_6.hidden = YES;
        self.imgReward_7.hidden = NO;
        self.imgReward_8.hidden = YES;
    } else if (loopClock == eight) {
        self.imgReward_1.hidden = YES;
        self.imgReward_2.hidden = YES;
        self.imgReward_3.hidden = YES;
        self.imgReward_4.hidden = YES;
        self.imgReward_5.hidden = YES;
        self.imgReward_6.hidden = YES;
        self.imgReward_7.hidden = YES;
        self.imgReward_8.hidden = NO;
    } else {
        self.imgReward_1.hidden = YES;
        self.imgReward_2.hidden = YES;
        self.imgReward_3.hidden = YES;
        self.imgReward_4.hidden = YES;
        self.imgReward_5.hidden = YES;
        self.imgReward_6.hidden = YES;
        self.imgReward_7.hidden = YES;
        self.imgReward_8.hidden = YES;
    }
}

- (short)getReward {
    return [self random:[[USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_1] intValue]
                      b:[[USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_2] intValue]
                      c:[[USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_3] intValue]
                      d:[[USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_4] intValue]
                      e:[[USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_5] intValue]
                      f:[[USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_6] intValue]
                      g:[[USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_7] intValue]];
}

- (short)random:(int)a b:(int)b c:(int)c d:(int)d e:(int)e f:(int)f g:(int)g {
    int total = a + b + c + d + e + f + g;
    if (total == 0) {
        return 0;
    }
    
    srand(0);
    int position = (arc4random() % total) + 1;
    
    if (position <= a) {
        return 1;
    } else if (position <= a + b) {
        return 2;
    } else if (position <= a + b + c) {
        return 3;
    } else if (position <= a + b + c + d) {
        return 4;
    } else if (position <= a + b + c + d + e) {
        return 5;
    } else if (position <= a + b + c + d + e + f) {
        return 6;
    } else {
        return 7;
    }
}

@end
