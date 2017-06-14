//
//  UtilityClass.h
//  TemplateObjC
//
//  Created by Dung Do on 9/18/16.
//  Copyright © 2016 Dung Do. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UtilityClass : NSObject

//init
+ (UtilityClass *)sharedInstance;

//String Utillity Functions
- (NSString*)trimString:(NSString *)string;

//Directory Path Methods
- (NSString *)applicationDocumentDirectoryString;
- (NSString *)applicationCacheDirectoryString;
- (NSURL *)applicationDocumentsDirectoryURL;

//Scale and Rotate according to Orientation
- (UIImage *)scaleAndRotateImage:(UIImage *)image;

//Check Validation
- (BOOL)isValidEmail:(NSString *)email;
- (BOOL)isValidPassword:(NSString *)password;

//Show Alert
- (void)showAlertOnViewController:(UIViewController *)viewController withTitle:(NSString *)title andMessage:(NSString *)message andButton:(NSString *)button;
- (void)showAlertOnViewController:(UIViewController *)viewController withTitle:(NSString *)title andMessage:(NSString *)message andMainButton:(NSString *)mainButton CompletionHandler:(void (^)(UIAlertAction *action))mainHandler andOtherButton:(NSString *)otherButton CompletionHandler:(void (^)(UIAlertAction *action))otherHandler;

//Datetime helper
- (NSDate *)stringToDate:(NSString *)dateString;
- (NSDate *)stringToDate:(NSString *)dateString withFormate:(NSString *)format;
- (NSString *)DateToString:(NSDate *)date;
- (NSString *)DateToString:(NSDate *)date withFormate:(NSString *)format;
- (NSString *)DateToStringForScanQueue:(NSDate *)date;
- (int)dateDiffrenceFromDateInString:(NSString *)date1 second:(NSString *)date2;
- (int)dateDiffrenceFromDate:(NSDate *)startDate second:(NSDate *)endDate;

@end
