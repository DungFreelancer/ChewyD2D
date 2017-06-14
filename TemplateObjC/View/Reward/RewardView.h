//
//  RewardView.h
//  TemplateObjC
//
//  Created by Dung Do on 3/10/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import "BaseView.h"

@interface RewardView : BaseView

@property (nonatomic) short reward;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward;

@end
