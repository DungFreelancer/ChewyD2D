//
//  SettingView.m
//  TemplateObjC
//
//  Created by Dung Do on 3/11/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import "SettingView.h"
#import "Constant.h"
#import "UtilityClass.h"
#import "HUDHelper.h"
#import "LogViewModel.h"
#import "PlayerViewModel.h"
#import "CALayer+BorderShadow.h"

@implementation SettingView {
    LogViewModel *logVM;
    PlayerViewModel *playerVM;
}

#pragma -
#pragma - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.btnSave.layer setBorderWithRadius:10.0f Color:[UIColor redColor]];
    [self.btnReport.layer setBorderWithRadius:10.0f Color:[UIColor redColor]];
    
    logVM = [[LogViewModel alloc] init];
    playerVM = [[PlayerViewModel alloc] init];
    
    [self setStatus];
    
    self.txtAmountReward_1.delegate = self;
    self.txtAmountReward_2.delegate = self;
    self.txtAmountReward_3.delegate = self;
    self.txtAmountReward_4.delegate = self;
    self.txtAmountReward_5.delegate = self;
    self.txtAmountReward_6.delegate = self;
    self.txtAmountReward_7.delegate = self;
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickTap:)];
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
}

- (void)onClickTap:(id)sender {
    [self.txtAmountReward_1 resignFirstResponder];
    [self.txtAmountReward_2 resignFirstResponder];
    [self.txtAmountReward_3 resignFirstResponder];
    [self.txtAmountReward_4 resignFirstResponder];
    [self.txtAmountReward_5 resignFirstResponder];
    [self.txtAmountReward_6 resignFirstResponder];
    [self.txtAmountReward_7 resignFirstResponder];
}

- (void)setStatus {
    self.txtAmountReward_1.text = [USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_1];
    self.txtAmountReward_2.text = [USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_2];
    self.txtAmountReward_3.text = [USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_3];
    self.txtAmountReward_4.text = [USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_4];
    self.txtAmountReward_5.text = [USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_5];
    self.txtAmountReward_6.text = [USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_6];
    self.txtAmountReward_7.text = [USER_DEFAULT objectForKey:PREF_AMOUNT_REWARD_7];
}

#pragma -
#pragma - On Click Event

- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickSave:(id)sender {
    // Save log.
    LogModel *log = [[LogModel alloc] init];
    log.name = LOG_CHANGE_REWARD;
    NSString *desc = [NSString stringWithFormat:@"Thay đổi số quà: Vé:%@ - Nón:%@ - MócKhoá:%@ - V10:%@ - V20:%@ - V50:%@ - VSet:%@", self.txtAmountReward_1.text, self.txtAmountReward_2.text, self.txtAmountReward_3.text, self.txtAmountReward_4.text, self.txtAmountReward_5.text, self.txtAmountReward_6.text, self.txtAmountReward_7.text];
    log.desc = desc;
    log.date = [NSDate date];
    CLLocationCoordinate2D location = [[UtilityClass sharedInstance] getLocation];
    log.location = [NSString stringWithFormat:@"%f, %f", location.latitude, location.longitude];
    [logVM loadLogs];
    [logVM.arrLog addObject:log];
    [logVM saveLogs];
    
    // Change reward.
    [USER_DEFAULT setObject:self.txtAmountReward_1.text forKey:PREF_AMOUNT_REWARD_1];
    [USER_DEFAULT setObject:self.txtAmountReward_2.text forKey:PREF_AMOUNT_REWARD_2];
    [USER_DEFAULT setObject:self.txtAmountReward_3.text forKey:PREF_AMOUNT_REWARD_3];
    [USER_DEFAULT setObject:self.txtAmountReward_4.text forKey:PREF_AMOUNT_REWARD_4];
    [USER_DEFAULT setObject:self.txtAmountReward_5.text forKey:PREF_AMOUNT_REWARD_5];
    [USER_DEFAULT setObject:self.txtAmountReward_6.text forKey:PREF_AMOUNT_REWARD_6];
    [USER_DEFAULT setObject:self.txtAmountReward_7.text forKey:PREF_AMOUNT_REWARD_7];
    [USER_DEFAULT synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickSync:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setToRecipients:@[EMAIL_ADDRESS]];
        CLLocationCoordinate2D location = [[UtilityClass sharedInstance] getLocation];
        [mail setSubject:[NSString stringWithFormat:@"%@ - %@ - %f, %f", EMAIL_SUBJECT, [[UtilityClass sharedInstance] DateToString:[NSDate date] withFormate:@"dd/MM/yyyy HH:mm"],location.latitude, location.longitude]];
        
        [mail addAttachmentData:[[self getSystemContent] dataUsingEncoding:NSUTF8StringEncoding] mimeType:@"text" fileName:@"System"];
        [mail addAttachmentData:[[self getPlayerContent] dataUsingEncoding:NSUTF8StringEncoding] mimeType:@"text" fileName:@"Player"];
        
        [self presentViewController:mail animated:YES completion:NULL];
    } else {
        ELOG(@"This device cannot send email");
    }
}

- (NSString *)getSystemContent {
    [logVM loadLogs];
    NSMutableString *content = [[NSMutableString alloc] init];
    
    [content appendFormat:@"Name\tDescription\tDate\tLocation\n"];
    for (LogModel *log in logVM.arrLog) {
        NSString *date = [[UtilityClass sharedInstance] DateToString:log.date withFormate:@"dd/MM/yyyy HH:mm"];
        
        [content appendFormat:@"%@\t%@\t%@\t%@\n", log.name, log.desc, date, log.location];
    }
    
    return content;
}

- (NSString *)getPlayerContent {
    [playerVM loadPlayers];
    NSMutableString *content = [[NSMutableString alloc] init];
    
    [content appendFormat:@"Name\tPhone\tReward\tDate\tLocation\n"];
    for (PlayerModel *player in playerVM.arrPlayer) {
        NSString *date = [[UtilityClass sharedInstance] DateToString:player.date withFormate:@"dd/MM/yyyy HH:mm"];
        
        [content appendFormat:@"%@\t%@\t%@\t%@\t%@\n", player.name, player.phone, player.reward, date, player.location];
    }
    
    return content;
}

#pragma mark -
#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultSent:
            DLOG(@"You sent the email");
            [[HUDHelper sharedInstance] showToastWithMessage:@"You sent the email" onView:self.view];
            [logVM clearLogs];
            [playerVM clearPlayers];
            break;
        case MFMailComposeResultSaved:
            DLOG(@"You saved a draft of this email");
            [[HUDHelper sharedInstance] showToastWithMessage:@"You saved a draft of this email" onView:self.view];
            break;
        case MFMailComposeResultCancelled:
            ELOG(@"You cancelled sending this email");
            [[HUDHelper sharedInstance] showToastWithMessage:@"You cancelled sending this email" onView:self.view];
            break;
        case MFMailComposeResultFailed:
            ELOG(@"An error occurred when trying to compose this email");
            [[HUDHelper sharedInstance] showToastWithMessage:@"An error occurred when trying to compose this email" onView:self.view];
            break;
        default:
            ELOG(@"An error occurred when trying to compose this email");
            [[HUDHelper sharedInstance] showToastWithMessage:@"An error occurred when trying to compose this email" onView:self.view];
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.txtAmountReward_1) {
        [self.txtAmountReward_2 becomeFirstResponder];
    } else if (textField == self.txtAmountReward_2) {
        [self.txtAmountReward_3 becomeFirstResponder];
    } else if (textField == self.txtAmountReward_3) {
        [self.txtAmountReward_4 becomeFirstResponder];
    } else if (textField == self.txtAmountReward_4) {
        [self.txtAmountReward_5 becomeFirstResponder];
    } else if (textField == self.txtAmountReward_5) {
        [self.txtAmountReward_6 becomeFirstResponder];
    } else if (textField == self.txtAmountReward_6) {
        [self.txtAmountReward_7 becomeFirstResponder];
    } else if (textField == self.txtAmountReward_7) {
        [self.txtAmountReward_7 resignFirstResponder];
        [self onClickSave:nil];
    }
    
    return YES;
}

@end
