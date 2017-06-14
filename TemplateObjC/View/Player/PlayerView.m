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
#import <CoreLocation/CoreLocation.h>
#import "UtilityClass.h"

@implementation PlayerView {
    NSTimer *runStandby;
    BOOL isTouch;
    short indexStanby;
    CLLocationManager *locationManager;
    LogViewModel *logVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    [self checkFistTime];
    
    logVM = [[LogViewModel alloc] init];
    
    [self getLocation];
    
    isTouch = NO;
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(showStandBy) userInfo:nil repeats:YES];
    
    // Handle single tap.
    self.txtName.delegate = self;
    self.txtPhone.delegate = self;
    self.txtPassSetting.delegate = self;
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickStandby:)];
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
    [self.viewSetting addGestureRecognizer:singleTapGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [self onClickStandby:nil];
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
        [self.view bringSubviewToFront:self.btnStandby];
        self.btnStandby.hidden = NO;
    } else {
        isTouch = NO;
    }
}

- (IBAction)onClickOK:(id)sender {
    if (self.txtName.text.length > 0 &&
        self.txtPhone.text.length >= 8) {
        LogModel *log = [[LogModel alloc] init];
        log.name = LOG_USER;
        log.desc = [NSString stringWithFormat:@"Người chơi: ten:%@ sdt:%@", self.txtName.text, self.txtPhone.text];
        log.date = [NSDate date];
        CLLocationCoordinate2D location = [self getLocation];
        log.location = [NSString stringWithFormat:@"%f, %f", location.latitude, location.longitude];
        [logVM loadLogs];
        [logVM.arrLog addObject:log];
        [logVM saveLogs];
        
        [self performSegueWithIdentifier:@"segue_player_play" sender:nil];
        
        self.txtName.text = @"";
        self.txtPhone.text = @"";
    } else if (self.txtName.text.length == 0) {
        [[UtilityClass sharedInstance] showAlertOnViewController:self withTitle:@"Xin nhập tên" andMessage:nil andButton:@"OK"];
    } else if (self.txtPhone.text.length < 8) {
        [[UtilityClass sharedInstance] showAlertOnViewController:self withTitle:@"Số điện thoại phải từ 8 ký tự trở lên" andMessage:nil andButton:@"OK"];
    }
}

- (IBAction)onClickShowSetting:(id)sender {
    [self.view bringSubviewToFront:self.viewSetting];
    self.viewSetting.hidden = NO;
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

- (IBAction)onClickStandby:(id)sender {
    self.btnStandby.hidden = YES;
    isTouch = YES;
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

- (IBAction)onClickSetting:(id)sender {
    if ([self.txtPassSetting.text isEqualToString:PASS_SETTING]) {
        LogModel *log = [[LogModel alloc] init];
        log.name = LOG_SETTING;
        log.desc = @"Vào setting";
        log.date = [NSDate date];
        CLLocationCoordinate2D location = [self getLocation];
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

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self onClickStandby:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self onClickStandby:nil];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self onClickStandby:nil];
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
