//
//  Constant.h
//  TemplateObjC
//
//  Created by Dung Do on 9/18/16.
//  Copyright © 2016 Dung Do. All rights reserved.
//

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define APP_DELEGATE    ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define USER_DEFAULT    [NSUserDefaults standardUserDefaults]

#define IS_IPHONE   [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"]

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

#ifdef DEBUG
#   define DLOG(FORMAT, ...) printf("🔵%s[line %d]: %s🔵\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#   define ELOG(FORMAT, ...) printf("🔴%s[line %d]: %s🔴\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#   define DLOG(...)
#   define ELOG(...)
#endif

// Default account
#define PASS_SETTING @"CJcontrol"

// Log
#define LOG_SETTING @"Setting"
#define LOG_CHANGE_REWARD @"Change_gift"
#define LOG_PLAY @"Play"
#define LOG_GET_REWARD @"Get_gift"
#define LOG_USER @"User"

// Email
#define EMAIL_ADDRESS @"ChewyTBTq5@gmail.com"
#define EMAIL_SUBJECT @"Báo cáo D2D"

// PREFERENCE
#define PREF_IS_FIST_TIME @"isFistTime"
#define PREF_AMOUNT_REWARD_1 @"amount_reward_1"
#define PREF_AMOUNT_REWARD_2 @"1amount_reward_2"
#define PREF_AMOUNT_REWARD_3 @"amount_reward_3"
#define PREF_AMOUNT_REWARD_4 @"amount_reward_4"
#define PREF_AMOUNT_REWARD_5 @"amount_reward_5"
#define PREF_AMOUNT_REWARD_6 @"amount_reward_6"
#define PREF_AMOUNT_REWARD_7 @"amount_reward_7"
