//
//  PlayView.h
//  TemplateObjC
//
//  Created by Dung Do on 3/10/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import "BaseView.h"

@interface PlayView : BaseView

@property (weak, nonatomic) IBOutlet UIImageView *imgWheel;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_1;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_2;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_3;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_4;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_5;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_6;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_7;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward_8;
- (IBAction)onClickRun:(id)sender;

@end
