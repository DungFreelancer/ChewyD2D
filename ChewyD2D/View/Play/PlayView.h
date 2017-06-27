//
//  PlayView.h
//  TemplateObjC
//
//  Created by Dung Do on 3/10/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import "BaseView.h"

@interface PlayView : BaseView

@property (weak, nonatomic) IBOutlet UIImageView *imgBackGround;
@property (weak, nonatomic) IBOutlet UIImageView *imgWheel;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_1;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_2;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_3;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_4;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_5;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_6;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_7;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_8;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_1_2;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_2_2;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_3_2;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_4_2;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_5_2;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_6_2;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_7_2;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_8_2;

- (IBAction)onClickRun:(id)sender;

@end
