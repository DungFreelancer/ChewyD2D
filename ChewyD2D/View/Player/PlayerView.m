//
//  PlayerView.m
//  TemplateObjC
//
//  Created by Dung Do on 4/17/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import "PlayerView.h"
#import "PlayerViewModel.h"
#import "LogViewModel.h"
#import "Constant.h"
#import "UtilityClass.h"
#import "CALayer+BorderShadow.h"

@implementation PlayerView {
    NSTimer *runStandby;
    BOOL isTouch;
    short indexStanby;
    LogViewModel *logVM;
}

#pragma -
#pragma - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    [self.viewSetting.layer setBorderWithRadius:10.0f Color:[UIColor whiteColor]];
    [self.btnSetting.layer setBorderWithRadius:10.0f Color:[UIColor redColor]];
    [self checkFistTime];
    
    logVM = [[LogViewModel alloc] init];
    
    isTouch = NO;
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(showStandBy) userInfo:nil repeats:YES];
    
    // Handle single tap.
    self.txtName.delegate = self;
    self.txtPhone.delegate = self;
    self.txtPassSetting.delegate = self;
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickStandby:)];
    [self.viewSetting addGestureRecognizer:singleTapGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [self onClickStandby:nil];
    
    self.txtName.text = @"";
    self.txtPhone.text = @"";
}

- (void)showStandBy {
    NSString *name = [NSString stringWithFormat:@"LoadingView_%d", indexStanby];
    [self.btnStandby setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    
    if (indexStanby == 2) {
        indexStanby = 1;
    } else {
        indexStanby++;
    }
    
    if (!isTouch) {
        [self.txtName resignFirstResponder];
        [self.txtPhone resignFirstResponder];
        [self.txtPassSetting resignFirstResponder];
        
        [self.view bringSubviewToFront:self.btnStandby];
        self.btnStandby.hidden = NO;
    } else {
        isTouch = NO;
    }
}

- (void)checkFistTime {
    if ([USER_DEFAULT boolForKey:PREF_IS_FIST_TIME] == NO) {
        [USER_DEFAULT setBool:YES forKey:PREF_IS_FIST_TIME];
        
        // set default amount of reward.
        [USER_DEFAULT setObject:@"0" forKey:PREF_AMOUNT_REWARD_1];
        [USER_DEFAULT setObject:@"0" forKey:PREF_AMOUNT_REWARD_2];
        [USER_DEFAULT setObject:@"0" forKey:PREF_AMOUNT_REWARD_3];
        [USER_DEFAULT setObject:@"0" forKey:PREF_AMOUNT_REWARD_4];
        [USER_DEFAULT setObject:@"0" forKey:PREF_AMOUNT_REWARD_5];
        [USER_DEFAULT setObject:@"0" forKey:PREF_AMOUNT_REWARD_6];
        [USER_DEFAULT setObject:@"0" forKey:PREF_AMOUNT_REWARD_7];
        
        [USER_DEFAULT synchronize];
    }
}

#pragma -
#pragma - On Click Event

- (IBAction)onClickOK:(id)sender {
    if (self.txtName.text.length > 0 &&
        self.txtPhone.text.length >= 8) {
        CLLocationCoordinate2D location = [[UtilityClass sharedInstance] getLocation];
        
        PlayerViewModel *playerVM = [[PlayerViewModel alloc] init];
        PlayerModel *player = [[PlayerModel alloc] init];
        player.name = self.txtName.text;
        player.phone = [self formatPhoneNumber:self.txtPhone.text];
        player.date = [NSDate date];
        player.location = [NSString stringWithFormat:@"%f, %f", location.latitude, location.longitude];
        [playerVM loadPlayers];
        [playerVM.arrPlayer addObject:player];
        [playerVM savePlayers];
        
        [self performSegueWithIdentifier:@"segue_player_play" sender:nil];
    } else if (self.txtName.text.length == 0) {
        [[UtilityClass sharedInstance] showAlertOnViewController:self withTitle:@"Xin nhập tên" andMessage:nil andButton:@"OK"];
    } else if (self.txtPhone.text.length < 8) {
        [[UtilityClass sharedInstance] showAlertOnViewController:self withTitle:@"Số điện thoại phải từ 8 ký tự trở lên" andMessage:nil andButton:@"OK"];
    }
}

- (NSString *)formatPhoneNumber:(NSString *)phoneNumber {
    if ([phoneNumber characterAtIndex:0] == '0') {
        return [NSString stringWithFormat:@"84%@", [phoneNumber substringFromIndex:1]];
    }
    
    return phoneNumber;
}

- (IBAction)onClickShowSetting:(id)sender {
    [self.view bringSubviewToFront:self.viewSetting];
    self.viewSetting.hidden = NO;
}

- (IBAction)onClickStandby:(id)sender {
    self.btnStandby.hidden = YES;
    isTouch = YES;
    
    if (sender != self.txtName &&
        sender != self.txtPhone &&
        sender != self.txtPassSetting) {
        [self.txtName resignFirstResponder];
        [self.txtPhone resignFirstResponder];
        [self.txtPassSetting resignFirstResponder];
    }
}

- (IBAction)onClickSetting:(id)sender {
    if ([self.txtPassSetting.text isEqualToString:PASS_SETTING]) {
        LogModel *log = [[LogModel alloc] init];
        log.name = LOG_SETTING;
        log.desc = @"Vào setting";
        log.date = [NSDate date];
        CLLocationCoordinate2D location = [[UtilityClass sharedInstance] getLocation];
        log.location = [NSString stringWithFormat:@"%f, %f", location.latitude, location.longitude];
        [logVM loadLogs];
        [logVM.arrLog addObject:log];
        [logVM saveLogs];
        
        [self performSegueWithIdentifier:@"segue_player_setting" sender:nil];
    }
    
    self.viewSetting.hidden = YES;
    self.txtPassSetting.text = @"";
    [self.txtPassSetting resignFirstResponder];
}

#pragma -
#pragma - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self onClickStandby:textField];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self onClickStandby:textField];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self onClickStandby:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.txtName) {
        [self.txtPhone becomeFirstResponder];
    } else if (textField == self.txtPhone) {
        [self.txtPhone resignFirstResponder];
        [self onClickOK:nil];
    } else if (textField == self.txtPassSetting) {
        [self.txtPassSetting resignFirstResponder];
        [self onClickSetting:nil];
    }
    
    return YES;
}

@end
