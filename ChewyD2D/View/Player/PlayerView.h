//
//  PlayerView.h
//  TemplateObjC
//
//  Created by Dung Do on 4/17/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import "BaseView.h"

@interface PlayerView : BaseView <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnStandby;
- (IBAction)onClickStandby:(id)sender;
- (IBAction)onClickOK:(id)sender;
- (IBAction)onClickShowSetting:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewSetting;
@property (weak, nonatomic) IBOutlet UITextField *txtPassSetting;
@property (weak, nonatomic) IBOutlet UIButton *btnSetting;
- (IBAction)onClickSetting:(id)sender;

@end
