//
//  UserViewModel.h
//  TemplateObjC
//
//  Created by Dung Do on 3/11/17.
//  Copyright © 2017 Dung Do. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerModel.h"

@interface PlayerViewModel : NSObject

@property(nonatomic, strong) NSMutableArray<PlayerModel *> *arrPlayer;

- (id)init;
- (void)loadPlayers;
- (void)savePlayers;
- (void)clearPlayers;

@end
