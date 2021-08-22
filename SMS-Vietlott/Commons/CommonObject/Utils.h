//
//  Utils.h
//  NoiBaiAirPort
//
//  Created by HuCuBi on 5/23/18.
//  Copyright © 2018 NeoJSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import <UIImageView+WebCache.h>
#import <sys/utsname.h>
#import <SSKeychain/SSKeychain.h>
#import <NSHash/NSString+NSHash.h>
#import "Config.h"
#import "VariableStatic.h"
#import "Reachability.h"

@interface Utils : NSObject

+ (void)configKeyboard;

+ (void)alert:(NSString *)title content:(NSString *)content titleOK:(NSString *)titleOK titleCancel:(NSString *)titleCancel viewController : (UIViewController *)vc completion:(void(^)(void))completion;

+ (void)alertError:(NSString *)title content:(NSString *)content viewController : (UIViewController *)vc completion:(void(^)(void))completion;

+ (void)alertWithCancelProcess:(NSString *)title content:(NSString *)content titleOK:(NSString *)titleOK titleCancel:(NSString *)titleCancel viewController : (UIViewController *)vc completion:(void(^)(void))completion cancel:(void(^)(void))cancel;

+ (float)lenghtText : (NSString *)string;

+ (void)processNotification :(NSDictionary *)userInfo;

+ (NSString *)myDeviceModel;

+ (NSString *)getDateFromDate : (NSDate *)date;

+ (NSDate *)getDateFromStringDate : (NSString *)date;

+ (NSString *)getDayName : (NSDate *)date;

+ (NSDate *)_nextDay:(NSDate *)date;

+ (NSString *)convertStringUrl : (NSString *)stringUrl;

+ (UIImage *)scaleImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize;

+ (BOOL)checkFromDate : (NSString *)fromDate;

//format định dạng tiền tệ
+ (NSString *)strCurrency:(NSString *)price;

+ (NSString *)convertNumber:(NSString *)number;

+ (NSTimeInterval)getDurationFromDate : (NSString *)fromDate toDate : (NSString *)toDate;

+ (NSString *)changeVietNamese : (NSString *)string;

+ (NSMutableDictionary *)converDictRemoveNullValue : (NSDictionary *)dict;

+ (BOOL) NSStringIsValidEmail:(NSString *)checkString;

+ (void)alertPayBalanceForCTV : (NSDictionary *)dictCTV viewController : (UIViewController *)vc completeBlock:(void(^)(NSString *content))block;

+ (BOOL)checkFromDate : (NSString *)fromDate toDate : (NSString *)toDate view:(UIViewController *)vc;

+ (NSAttributedString *)htmlStringWithContent : (NSString *)content fontName : (NSString *)fontName fontSize : (float)fontSize color :(NSString *)color isCenter : (BOOL) isCenter;

+ (NSString *)convertHTML:(NSString *)html;

+ (void)updateAppInfo;

+ (void)checkAppVersion;

+ (NSData *)generatePostDataForData:(NSData *)uploadData filename:(NSString *)filename;

+ (void)uploadFile:(NSData *)fileData fileName:(NSString *)stringFileName completeBlock:(void(^)(NSString *urlImage))completion;

+ (void)uploadAvatar:(NSArray *)arrayUploadFile completeBlock:(void(^)(NSDictionary *dictData))completion;

+ (NSData *)generatePostDataFromArray:(NSArray *)arrayUploadData;

+ (void)uploadFiles:(NSArray *)arrayUploadFile completeBlock:(void(^)(NSDictionary *dictData))completion;

+ (NSString *)hexadecimalStringFromData:(NSData *)data;

+ (void)checkUpdate;

+ (NSDate *)getFirstDayOfThisMonth;

+ (NSDate *)getLastDayOfMonth : (int)number;

+ (void)callSupport : (NSString *)phone;

+ (UIColor *)colorWithHex: (NSString *)color;

+ (UIImage *)imageFromColor:(UIColor *)color;

+ (NSString *)makeCheckSum : (NSArray *)arrayCheckSum;

+ (BOOL)isLogin;

+ (BOOL)isValidPassword:(NSString *)passwordString;

+ (NSString *)fixUnicode : (NSString *) input;

+ (int)getRandomNumberBetween:(int)from and:(int)to;

+ (NSArray *)getAllDayOfMonth : (NSInteger )wantedWeekDay;

+ (NSArray *)createKyQuayWithIdGame : (NSString *)idGame;

+ (BOOL)isDisconnect;

+ (NSInteger)_numberOfDaysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate;

+ (BOOL)isContaintSpecialChar:(NSString *)string;

+ (NSString *)trimString : (NSString *)someString;

+ (NSString *)secondsToMMSS : (long)elapsedSeconds;

+ (void)showFB;

+ (void)showYoutube;

+ (void)showGroup;

+ (void)showAlertLogin;

+ (NSString *)getKyFromDict : (NSDictionary *)dict;

+ (int)placeInWeekForDate:(NSDate *)date;

@end
