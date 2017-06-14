//
//  SettingView.h
//  TemplateObjC
//
//  Created by Dung Do on 3/11/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import "BaseView.h"
#import <MessageUI/MessageUI.h>

@interface SettingView : BaseView <MFMailComposeViewControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtAmountReward_1;
@property (weak, nonatomic) IBOutlet UITextField *txtAmountReward_2;
@property (weak, nonatomic) IBOutlet UITextField *txtAmountReward_3;
@property (weak, nonatomic) IBOutlet UITextField *txtAmountReward_4;
@property (weak, nonatomic) IBOutlet UITextField *txtAmountReward_5;
@property (weak, nonatomic) IBOutlet UITextField *txtAmountReward_6;
@property (weak, nonatomic) IBOutlet UITextField *txtAmountReward_7;
- (IBAction)onClickBack:(id)sender;
- (IBAction)onClickSave:(id)sender;
- (IBAction)onClickSync:(id)sender;

@end
