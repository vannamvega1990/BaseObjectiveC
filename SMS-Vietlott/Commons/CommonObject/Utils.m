//
//  Utils.m
//  NoiBaiAirPort
//
//  Created by HuCuBi on 5/23/18.
//  Copyright © 2018 NeoJSC. All rights reserved.
//

#import "Utils.h"
#import "IQKeyboardManager.h"
#import <sys/utsname.h>
#import "AppDelegate.h"
#import "CallAPI.h"

@implementation Utils

+ (void)configKeyboard {
    //ONE LINE OF CODE.
    //Enabling keyboard manager(Use this line to enable managing distance between keyboard & textField/textView).
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    //(Optional)Set Distance between keyboard & textField, Default is 10.
    //[[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:15];
    
    //(Optional)Enable autoToolbar behaviour. If It is set to NO. You have to manually create UIToolbar for keyboard. Default is NO.
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    //(Optional)Setting toolbar behaviour to IQAutoToolbarBySubviews to manage previous/next according to UITextField's hierarchy in it's SuperView. Set it to IQAutoToolbarByTag to manage previous/next according to UITextField's tag property in increasing order. Default is `IQAutoToolbarBySubviews`.
    //[[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarBySubviews];
    
    //(Optional)Resign textField if touched outside of UITextField/UITextView. Default is NO.
    //[[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    //(Optional)Giving permission to modify TextView's frame. Default is NO.
    //[[IQKeyboardManager sharedManager] setCanAdjustTextView:YES];
    
    //(Optional)Show TextField placeholder texts on autoToolbar. Default is NO.
    //    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:YES];
    [[IQKeyboardManager sharedManager] setShouldShowToolbarPlaceholder:YES];
}

+ (void)alertError:(NSString *)title content:(NSString *)content viewController : (UIViewController *)vc completion:(void(^)(void))completion {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:title
                                message:content
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *btnCancel = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
        completion();
    }];
    [alert addAction:btnCancel];
    
    if (vc) {
        [vc presentViewController:alert animated:YES completion:nil];
    }else{
        [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:alert animated:YES completion:nil];
    }
}

//Thông báo alert
+ (void)alert:(NSString *)title content:(NSString *)content titleOK:(NSString *)titleOK titleCancel:(NSString *)titleCancel viewController : (UIViewController *)vc completion:(void(^)(void))completion {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:title
                                message:content
                                preferredStyle:UIAlertControllerStyleAlert];
    
    if ([title isEqualToString:NSLocalizedString(@"Warning", nil)]) {
        NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:title];
        [hogan addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:25.0]
                      range:NSMakeRange(0, title.length)];
        [hogan addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, title.length)];
        [alert setValue:hogan forKey:@"attributedTitle"];
    }
    
    if (titleCancel) {
        UIAlertAction *btnCancel = [UIAlertAction
                                    actionWithTitle:titleCancel
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:btnCancel];
        [btnCancel setValue:[UIColor redColor] forKey:@"titleTextColor"];
    }
    
    if (titleOK) {
        UIAlertAction *btnOK = [UIAlertAction
                                actionWithTitle:titleOK
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
            completion();
        }];
        [alert addAction:btnOK];
    }
    
    if (vc) {
        [vc presentViewController:alert animated:YES completion:nil];
    }else{
        [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:alert animated:YES completion:nil];
    }
}

+ (void)alertWithCancelProcess:(NSString *)title content:(NSString *)content titleOK:(NSString *)titleOK titleCancel:(NSString *)titleCancel viewController : (UIViewController *)vc completion:(void(^)(void))completion cancel:(void(^)(void))cancel {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:title
                                message:content
                                preferredStyle:UIAlertControllerStyleAlert];
    
    if ([title isEqualToString:NSLocalizedString(@"Warning", nil)]) {
        NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:title];
        [hogan addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:25.0]
                      range:NSMakeRange(0, title.length)];
        [hogan addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, title.length)];
        [alert setValue:hogan forKey:@"attributedTitle"];
    }
    
    if (titleCancel) {
        UIAlertAction *btnCancel = [UIAlertAction
                                    actionWithTitle:titleCancel
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
            cancel();
        }];
        [alert addAction:btnCancel];
        [btnCancel setValue:[UIColor redColor] forKey:@"titleTextColor"];
    }
    
    if (titleOK) {
        UIAlertAction *btnOK = [UIAlertAction
                                actionWithTitle:titleOK
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
            completion();
        }];
        [alert addAction:btnOK];
    }
    
    if (vc) {
        [vc presentViewController:alert animated:YES completion:nil];
    }else{
        [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:alert animated:YES completion:nil];
    }
}

+ (void)alertPayBalanceForCTV : (NSDictionary *)dictCTV viewController : (UIViewController *)vc completeBlock:(void(^)(NSString *content))block {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Thanh toán hoa hồng"
                                                                              message: [NSString stringWithFormat:@"Nhập vào số tiền hoa hồng bạn đã thanh toán cho CTV %@",dictCTV[@"FULL_NAME"]]
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Số tiền đã thanh toán";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleNone;
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Nội dung thanh toán";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleNone;
        textField.keyboardType = UIKeyboardTypeDefault;
    }];
    
    UIAlertAction *btnOK = [UIAlertAction
                            actionWithTitle:@"Cập nhật"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
        NSLog(@"%@",namefield.text);
        block(namefield.text);
    }];
    [alertController addAction:btnOK];
    
    UIAlertAction *btnCancel = [UIAlertAction
                                actionWithTitle:@"Hủy bỏ"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:btnCancel];
    [btnCancel setValue:[UIColor redColor] forKey:@"titleTextColor"];
    
    if (vc) {
        [vc presentViewController:alertController animated:YES completion:nil];
    }else{
        [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:alertController animated:YES completion:nil];
    }
}

+ (float)lenghtText : (NSString *)string {
    if ([string isKindOfClass:[NSString class]]) {
        NSString *result = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string isEqualToString:@"null"]) {
            result = @"";
        }
        
        return result.length;
    }else{
        return 0;
    }
}

+ (void)processNotification :(NSDictionary *)userInfo {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    int type = [userInfo[@"type"] intValue] ;
    
    
}

+ (AppDelegate *) appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (NSString *)myDeviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *myDeviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ListIphone" ofType:@"plist"];
    NSArray *listIphone = [[NSArray arrayWithContentsOfFile:plistPath]copy];
    
    for (NSDictionary *dic in listIphone) {
        NSString *model = [dic valueForKey:@"model"];
        if ([myDeviceModel isEqualToString:model]) {
            myDeviceModel = [dic valueForKey:@"iPhone"];
        }
    }
    
    return myDeviceModel;
}

+ (NSString *)getDateFromDate : (NSDate *)date {
    NSDateFormatter *clientDateFormatter = [[NSDateFormatter alloc] init];
    [clientDateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    NSString *clientDate = [clientDateFormatter stringFromDate:date];
    
    return clientDate;
}

+ (NSDate *)getDateFromStringDate : (NSString *)date {
    if ([date isKindOfClass:[NSString class]]) {
        NSDateFormatter *clientDateFormatter = [[NSDateFormatter alloc] init];
        [clientDateFormatter setDateFormat:@"dd/MM/yyyy"];
        
        NSDate *clientDate = [clientDateFormatter dateFromString:date];
        
        if (clientDate == nil) {
            [clientDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'.000Z'"];
            clientDate = [clientDateFormatter dateFromString:date];
        }
        
        if (clientDate == nil) {
            [clientDateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
            clientDate = [clientDateFormatter dateFromString:date];
        }
        
        return clientDate;
    }else{
        return nil;
    }
}

+ (NSString *)getDayName : (NSDate *)date {
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    NSString *dayName = @"";
    
    switch ([component weekday]) {
        case 1:
            //Sunday
            dayName = @"CN";
            break;
        case 2:
            //Monday
            dayName = @"Thứ 2";
            break;
            
        case 3:
            //Tuesday
            dayName = @"Thứ 3";
            break;
            
        case 4:
            //Wen
            dayName = @"Thứ 4";
            break;
            
        case 5:
            //Thur
            dayName = @"Thứ 5";
            break;
            
        case 6:
            //Fri
            dayName = @"Thứ 6";
            break;
            
        case 7:
            //Saturday
            dayName = @"Thứ 7";
            break;
            
        default:
            break;
    }
    
    return dayName;
}

+ (NSDate *)_nextDay:(NSDate *)date {
    NSCalendar *calender = [NSCalendar autoupdatingCurrentCalendar];
    [calender setTimeZone:[NSTimeZone systemTimeZone]];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [calender dateByAddingComponents:comps toDate:date options:0];
}

//Sửa các link bị lỗi font
+ (NSString *)convertStringUrl : (NSString *)stringUrl {
    if (![stringUrl isKindOfClass:[NSNull class]] && stringUrl.length > 0) {
        NSString *linkImage = @"";
        if ([stringUrl hasPrefix:@"https://"]) {
            linkImage = @"https://";
        }else if ([stringUrl hasPrefix:@"http://"]) {
            linkImage = @"http://";
        }
        NSArray *arrayStr = [[stringUrl stringByReplacingOccurrencesOfString:linkImage withString:@""] componentsSeparatedByString:@"/"];
        NSString *escapedString = @"";
        
        for (NSString *str in arrayStr) {
            NSString *strCon = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
            escapedString = [[escapedString stringByAppendingString:@"/"] stringByAppendingString:strCon];
        }
        
        escapedString = [escapedString substringFromIndex:1];
        escapedString = [escapedString stringByReplacingOccurrencesOfString:@"%3F" withString:@"?"];
        escapedString = [escapedString stringByReplacingOccurrencesOfString:@"%3A" withString:@":"];
        return [linkImage stringByAppendingString:escapedString];
    }else{
        return @"";
    }
}

+ (UIImage *)scaleImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize {
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(newSize / image.size.width, newSize / image.size.width);
    CGPoint origin = CGPointMake(0, 0);
    
    float newHeight = image.size.height * newSize / image.size.width;
    
    CGSize size = CGSizeMake(newSize, newHeight);
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, scaleTransform);
    
    [image drawAtPoint:origin];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (BOOL)checkFromDate : (NSString *)fromDate  {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *dateFrom = [dateFormatter dateFromString:fromDate];
    
    if([[NSDate date] timeIntervalSinceDate:dateFrom] > 0.5*24*60*60) {
        return YES;
    }else{
        return NO;
    }
    
}

+ (NSTimeInterval)getDurationFromDate : (NSString *)fromDate toDate : (NSString *)toDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss'.0'"];
    NSDate *dateFrom = [dateFormatter dateFromString:fromDate];
    NSDate *dateTo = [dateFormatter dateFromString:toDate];
    
    if (!dateFrom && !dateTo) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'.000Z'"];
        dateFrom = [dateFormatter dateFromString:fromDate];
        dateTo = [dateFormatter dateFromString:toDate];
    }
    
    if (!dateFrom && !dateTo) {
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        dateFrom = [dateFormatter dateFromString:fromDate];
        dateTo = [dateFormatter dateFromString:toDate];
    }
    
    return [dateFrom timeIntervalSinceDate:dateTo];
}


//format định dạng tiền tệ
+ (NSString *)strCurrency:(NSString *)price{
    price = [NSString stringWithFormat:@"%@",price];
    
    if (price.length == 0) {
        return @"0";
    }else{
        NSString *price1 = [price stringByReplacingOccurrencesOfString:@"." withString:@""];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *numberPrice = [[NSNumber alloc]initWithLongLong:[price1 longLongValue]];
        NSString *strPrice = [NSString stringWithFormat:@"%@",[formatter stringFromNumber:numberPrice]];
        strPrice = [strPrice stringByReplacingOccurrencesOfString:@"," withString:@"."];
        return strPrice;
    }
}

+ (NSString *)convertNumber : (NSString *)number {
    long long quantity = [number longLongValue];
    
    if (quantity < 1000) {
        return [NSString stringWithFormat:@"%lld",quantity];
    }else if (quantity >= 1000 && quantity < 1000000) {
        return [NSString stringWithFormat:@"%.0fK",(float)quantity/1000];
    }else{
        return [NSString stringWithFormat:@"%.3fK",(float)quantity/1000000];
    }
}

+ (NSString *)changeVietNamese : (NSString *)string {
    NSString *standard = [string stringByReplacingOccurrencesOfString:@"đ" withString:@"d"];
    standard = [standard stringByReplacingOccurrencesOfString:@"Đ" withString:@"D"];
    NSData *decode = [standard dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *ansi = [[NSString alloc] initWithData:decode encoding:NSASCIIStringEncoding];
    //        NSLog(@"ANSI: %@", ansi);
    return ansi;
}

+ (NSMutableDictionary *)converDictRemoveNullValue : (NSDictionary *)dict {
    NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
    for (NSString * key in [dict allKeys]) {
        if (![[dict objectForKey:key] isKindOfClass:[NSNull class]]){
            [newDict setObject:[dict objectForKey:key] forKey:key];
        }else{
            [newDict setObject:@"" forKey:key];
        }
    }
    
    return newDict;
}

+ (BOOL) NSStringIsValidEmail:(NSString *)checkString {
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isEmail = [emailTest evaluateWithObject:checkString];
    return isEmail;
}

+ (BOOL)isValidPassword:(NSString *)passwordString {
    NSString *stricterFilterString = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [passwordTest evaluateWithObject:passwordString];
}

+ (BOOL)checkFromDate : (NSString *)fromDate toDate : (NSString *)toDate view:(UIViewController *)vc {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *dateFrom = [dateFormatter dateFromString:fromDate];
    NSDate *dateTo = [dateFormatter dateFromString:toDate];
    
    if (fromDate.length == 0) {
        [Utils alertError:@"Thông báo" content:@"Bạn chưa chọn ngày bắt đầu" viewController:vc completion:^{
            
        }];
        return NO;
    }else if (toDate.length == 0) {
        [Utils alertError:@"Thông báo" content:@"Bạn chưa chọn ngày kết thúc" viewController:vc completion:^{
            
        }];
        return NO;
    }else{
        if( [dateFrom timeIntervalSinceDate:dateTo] > 0 ) {
            [Utils alertError:@"Thời gian không hợp lệ" content:@"Ngày bắt đầu phải trước ngày kết thúc" viewController:vc completion:^{
                
            }];
            return NO;
        }else{
            return YES;
        }
    }
}

+ (NSAttributedString *)htmlStringWithContent : (NSString *)content fontName : (NSString *)fontName fontSize : (float)fontSize color :(NSString *)color isCenter : (BOOL) isCenter {
    if ([content isKindOfClass:[NSString class]]) {
        NSString *htmlStr = [content stringByReplacingOccurrencesOfString:@"&#34;" withString:@"\""];
        htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"&#92;" withString:@"\\"];
        
        UIFont *font = [UIFont fontWithName:fontName size:fontSize];
        if (!font) {
            font = [UIFont systemFontOfSize:fontSize];
            //        font = [UIFont boldSystemFontOfSize:fontSize];
        }
        
        htmlStr = [htmlStr stringByAppendingString:[NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx;color:#%@;}</style>",font.fontName,font.pointSize,color]];
        
        NSString * htmlString = [NSString stringWithFormat:@"<html><body> %@ </body></html>",htmlStr];
        if (isCenter) {
            htmlString = [NSString stringWithFormat:@"<center>%@</center>",htmlString];
        }
        
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        return attrStr;
    }else{
        return [[NSAttributedString alloc] initWithString:@""];
    }
}

+ (NSString *)convertHTML:(NSString *)html {
    if ([html isKindOfClass:[NSString class]]) {
        //
        //    NSScanner *myScanner;
        //    NSString *text = nil;
        //    myScanner = [NSScanner scannerWithString:html];
        //
        //    while ([myScanner isAtEnd] == NO) {
        //
        //        [myScanner scanUpToString:@"<" intoString:NULL] ;
        //
        //        [myScanner scanUpToString:@">" intoString:&text] ;
        //
        //        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
        //    }
        //    //
        //    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSAttributedString *test = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
        html = [test string];
        
        return html;
    }else{
        return @"";
    }
}

+ (void)checkAppVersion {
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    
    NSString *currentVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultCurrentAppVersion];
    
    if (![appVersion isEqualToString:currentVersion]) {
        [self updateAppInfo];
    }
}

+ (void)updateAppInfo {
    NSString *idInit = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultIdInit];
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultUserName];
    NSString *osVersion = [NSString stringWithFormat:@"%.2f",[[[UIDevice currentDevice] systemVersion] floatValue]];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultDeviceToken];
    NSString *deviceModel = [Utils myDeviceModel];
//    NSString *uuid = [Utils getUniqueDeviceIdentifierAsString];
    
    NSArray *check_sum = @[@"api0056_device_info",
                           idInit?idInit:@"",
                           userName?userName:@"",
                           appVersion,
                           deviceModel,
                           deviceToken?deviceToken:@"",
                           osVersion,
                           @"1"
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"api0056_device_info",
                                @"id":idInit?idInit:@"",
                                @"user_name":userName?userName:@"",
                                @"version_app":appVersion,
                                @"device_model":deviceModel,
                                @"device_token":deviceToken?deviceToken:@"",
                                @"os_version":osVersion,
                                @"device_type":@"1",
                                };

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:YES  viewController:nil completeBlock:^(NSDictionary *dictData) {
        if (dictData) {
            if ([dictData[@"error"]  isEqual:@"0000"]) {
                if (deviceToken) {
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kUserDefaultIsSendToken];
                }
                NSString *init = [NSString stringWithFormat:@"%@",dictData[@"id"]];
                
                [[NSUserDefaults standardUserDefaults] setObject:appVersion forKey:kUserDefaultCurrentAppVersion];
                [[NSUserDefaults standardUserDefaults] setObject:init forKey:kUserDefaultIdInit];
            }else{
                
            }
        }else{
            
        }
    }];
}

+ (NSString *)getUniqueDeviceIdentifierAsString {
    
    NSString *appID=[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleIdentifierKey];
    
    NSString *strApplicationUUID = [SSKeychain passwordForService:appID account:@"incoding"];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [SSKeychain setPassword:strApplicationUUID forService:appID account:@"incoding"];
    }
    
    return strApplicationUUID;
}

+ (NSData *)generatePostDataForData:(NSData *)uploadData filename:(NSString *)filename {
    // Generate the post header
    NSString *post = [NSString stringWithCString:"--AaB03x\r\nContent-Disposition: form-data; name=\"file\"; filename=\"myfilenamehere1234\"\r\nContent-Type: application/octet-stream\r\nContent-Transfer-Encoding: binary\r\n\r\n" encoding:NSASCIIStringEncoding];
    
    post=[post stringByReplacingOccurrencesOfString:@"myfilenamehere1234" withString:filename];
    // Get the post header int ASCII format:
    NSData *postHeaderData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    // Generate the mutable data variable:
    NSMutableData *postData = [[NSMutableData alloc] initWithLength:[postHeaderData length] ];
    [postData setData:postHeaderData];
    
    // Add the image:
    [postData appendData: uploadData];
    
    // Add the closing boundry:
    [postData appendData: [@"\r\n--AaB03x--" dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    // Return the post data:
    return postData;
}

+ (NSData *)generatePostDataFromArray:(NSArray *)arrayUploadData {
    NSMutableData *finalPostData = [[NSMutableData alloc] init];
    NSString *boundary = @"AaB03x";
    [finalPostData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    for(NSDictionary *dict in arrayUploadData) {
        if (dict[@"fileName"]) {
            NSString *strNameImage = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",dict[@"name"],dict[@"fileName"]];
            [finalPostData appendData:[[NSString stringWithFormat:@"\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [finalPostData appendData:[strNameImage dataUsingEncoding:NSUTF8StringEncoding]];
            [finalPostData appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSData *imageData = UIImagePNGRepresentation(dict[@"image"]);
            [finalPostData appendData:[NSData dataWithData:imageData]];
            [finalPostData appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }else {
            [finalPostData appendData:[[NSString stringWithFormat:@"Content-Disposition:form-data; name=\"%@\"\r\n\r\n", dict[@"name"]] dataUsingEncoding:NSUTF8StringEncoding]];
            [finalPostData appendData:[[NSString stringWithFormat:@"%@", dict[@"value"]] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    [finalPostData appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString* newStr2 = [[NSString alloc] initWithData:finalPostData encoding:NSASCIIStringEncoding];
    NSLog(@"%@",newStr2);
    return finalPostData;
}

+ (void)uploadFiles:(NSArray *)arrayUploadFile completeBlock:(void(^)(NSDictionary *dictData))completion {
    [SVProgressHUD show];
    NSData *postData = [Utils generatePostDataFromArray:arrayUploadFile];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSString *url = [[VariableStatic sharedInstance].kService stringByAppendingString:kServiceWithNoToken];
    
    NSMutableURLRequest *uploadRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [uploadRequest setHTTPMethod:@"POST"];
    [uploadRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [uploadRequest setValue:@"multipart/form-data; boundary=AaB03x" forHTTPHeaderField:@"Content-Type"];
    [uploadRequest setHTTPBody:postData];
    
    NSLog(@"\n%@\n%@",url,arrayUploadFile);
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:uploadRequest
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            [SVProgressHUD dismiss];
            NSLog(@"\n%@\n%@",url,error);
            [Utils alertError:@"Lỗi kết nối" content:@"Đề nghị kiểm tra wifi hoặc kết nối dữ liệu của thiết bị" viewController:nil completion:^{
                
            }];
        } else {
            [SVProgressHUD dismiss];
            
            NSDictionary *dictResult = [data mutableObjectFromJSONData];
            NSLog(@"\n%@\n%@",url,dictResult);
            
            completion(dictResult);
        }
    }];
    [dataTask resume];
}

+ (void)uploadAvatar:(NSArray *)arrayUploadFile completeBlock:(void(^)(NSDictionary *dictData))completion {
    [SVProgressHUD show];
    NSData *postData = [Utils generatePostDataFromArray:arrayUploadFile];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSString *url = [[VariableStatic sharedInstance].kService stringByAppendingString:kServiceWithToken];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[VariableStatic sharedInstance].accessToken];
    
    NSMutableURLRequest *uploadRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [uploadRequest setHTTPMethod:@"POST"];
    [uploadRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [uploadRequest setValue:@"multipart/form-data; boundary=AaB03x" forHTTPHeaderField:@"Content-Type"];
    [uploadRequest setValue:token forHTTPHeaderField:@"Authorization"];
    [uploadRequest setHTTPBody:postData];
    
    NSLog(@"\n%@\n%@",url,arrayUploadFile);
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:uploadRequest
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            [SVProgressHUD dismiss];
            NSLog(@"\n%@\n%@",url,error);
            [Utils alertError:@"Lỗi kết nối" content:@"Đề nghị kiểm tra wifi hoặc kết nối dữ liệu của thiết bị" viewController:nil completion:^{
                
            }];
        } else {
            [SVProgressHUD dismiss];
            
            NSDictionary *dictResult = [data mutableObjectFromJSONData];
            NSLog(@"\n%@\n%@",url,dictResult);
            
            completion(dictResult);
        }
    }];
    [dataTask resume];
}

+ (void)uploadFile:(NSData *)fileData fileName:(NSString *)stringFileName completeBlock:(void(^)(NSString *urlImage))completion {
    if (fileData && stringFileName) {
        [SVProgressHUD show];
        NSData *postData = [Utils generatePostDataForData:fileData filename:stringFileName];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSString *url = @"http://onmyhome.vn/UploadAvaResize";
        
        NSMutableURLRequest *uploadRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        [uploadRequest setHTTPMethod:@"POST"];
        [uploadRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [uploadRequest setValue:@"multipart/form-data; boundary=AaB03x" forHTTPHeaderField:@"Content-Type"];
        [uploadRequest setHTTPBody:postData];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:uploadRequest
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                [SVProgressHUD dismiss];
                NSLog(@"\n%@\n%@",url,error);
                [Utils alertError:@"Lỗi kết nối" content:@"Đề nghị kiểm tra wifi hoặc kết nối dữ liệu của thiết bị" viewController:nil completion:^{
                    
                }];
            } else {
                [SVProgressHUD dismiss];
                NSString* urlImage = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"\n%@\n%@",url,urlImage);
                urlImage = [urlImage stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                urlImage = [urlImage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                completion(urlImage);
            }
        }];
        [dataTask resume];
    }else{
        completion(@"");
    }
}

+ (NSString *)hexadecimalStringFromData:(NSData *)data {
    NSUInteger dataLength = data.length;
    if (dataLength == 0) {
        return nil;
    }
    
    const unsigned char *dataBuffer = (const unsigned char *)data.bytes;
    NSMutableString *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for (int i = 0; i < dataLength; ++i) {
        [hexString appendFormat:@"%02x", dataBuffer[i]];
    }
    return [hexString copy];
}

+ (void)checkUpdate {
    NSString *mVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    
    //    [CallAPI callApiService:@"get_version" dictParam:@{} isGetError:YES viewController:nil completeBlock:^(NSDictionary *dictData) {
    //        if (dictData) {
    //            if ([dictData[@"ERROR"] isEqualToString:@"0000"]) {
    //                NSArray *arrayVersion = dictData[@"INFO"];
    //                NSDictionary *iosVersion;
    //                for (NSDictionary *dict in arrayVersion) {
    //                    if ([dict[@"NAME"] isEqualToString:@"IOS"]) {
    //                        iosVersion = dict;
    //                        break;
    //                    }
    //                }
    //                NSString *version = iosVersion[@"VERSION"];
    //                if ([mVersion isEqualToString:version]) {
    //                    NSLog(@"Phien ban OK");
    //                }else{
    //                    [self alertUpdateVersion:iosVersion];
    //                }
    //            }else{
    //
    //            }
    //        }else{
    //
    //        }
    //    }];
}

+ (NSDate *)getFirstDayOfThisMonth {
    NSDate *curDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekday fromDate:curDate];
    [comp setDay:1];
    NSDate *firstDateMonth = [calendar dateFromComponents:comp];
    
    return firstDateMonth;
}

+ (NSDate *)getLastDayOfMonth : (int)number {
    NSDate *curDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekday fromDate:curDate];
    // set last of month
    [comps setMonth:[comps month]+number];
    [comps setDay:0];
    NSDate *lastDateMonth = [calendar dateFromComponents:comps];
    
    return lastDateMonth;
}

+ (void)callSupport : (NSString *)phone {
    NSString *tel = [NSString stringWithFormat:@"tel://%@",phone];
    NSURL *URL = [NSURL URLWithString:tel];
    [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:^(BOOL success) {
        
    }];
}

+ (BOOL)checkNumberOfVinaphone : (NSString *)phoneNumber {
    for (NSString *prefix in ARR_VINAVPHONE_NUMBER_PREFIX) {
        if ([phoneNumber hasPrefix:prefix]) { //Phone number is valid with Vinaphone Number
            NSString *realNo = [phoneNumber substringFromIndex:prefix.length];
            if (realNo.length == 7) {
                break;
            }
        }
    }
    
    return YES;
}

+  (UIColor *)colorWithHex:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
    
}

+  (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSString *)makeCheckSum : (NSArray *)arrayCheckSum {
    NSMutableArray *array = [NSMutableArray arrayWithArray:arrayCheckSum];
    [array addObject:kCheckSum];
    
    NSString *str = [array componentsJoinedByString:@""];
    NSLog(@"====== check-sum ======\n%@",str);
    return [str SHA256];
}

+ (BOOL)isLogin {
    return [VariableStatic sharedInstance].isLogin;
}

+ (NSString *)fixUnicode : (NSString *) input {
    NSMutableString *results = [NSMutableString string];
    NSScanner *scanner = [NSScanner scannerWithString:input];
    [scanner setCharactersToBeSkipped:nil];
    while (![scanner isAtEnd]) {
        NSString *temp;
        if ([scanner scanUpToString:@"&" intoString:&temp]) {
            [results appendString:temp];
        }
        if ([scanner scanString:@"&" intoString:NULL]) {
            BOOL valid = YES;
            unsigned c = 0;
            NSUInteger savedLocation = [scanner scanLocation];
            if ([scanner scanString:@"#" intoString:NULL]) {
                // it's a numeric entity
                if ([scanner scanString:@"x" intoString:NULL]) {
                    // hexadecimal
                    unsigned int value;
                    if ([scanner scanHexInt:&value]) {
                        c = value;
                    } else {
                        valid = NO;
                    }
                } else {
                    // decimal
                    int value;
                    if ([scanner scanInt:&value] && value >= 0) {
                        c = value;
                    } else {
                        valid = NO;
                    }
                }
                if (![scanner scanString:@";" intoString:NULL]) {
                    // not ;-terminated, bail out and emit the whole entity
                    valid = NO;
                }
            } else {
                if (![scanner scanUpToString:@";" intoString:&temp]) {
                    // &; is not a valid entity
                    valid = NO;
                } else if (![scanner scanString:@";" intoString:NULL]) {
                    // there was no trailing ;
                    valid = NO;
                } else if ([temp isEqualToString:@"amp"]) {
                    c = '&';
                } else if ([temp isEqualToString:@"quot"]) {
                    c = '"';
                } else if ([temp isEqualToString:@"lt"]) {
                    c = '<';
                } else if ([temp isEqualToString:@"gt"]) {
                    c = '>';
                } else {
                    // unknown entity
                    valid = NO;
                }
            }
            if (!valid) {
                // we errored, just emit the whole thing raw
                [results appendString:[input substringWithRange:NSMakeRange(savedLocation, [scanner scanLocation]-savedLocation)]];
            } else {
                [results appendFormat:@"%C", (unichar)c];
            }
        }
    }
    return results;
}

+ (int)getRandomNumberBetween:(int)from and:(int)to {
    return (int)from + arc4random() % (to-from+1);
}

+ (NSArray *) getAllDayOfMonth : (NSInteger )wantedWeekDay {
    //Set Wantedday here with sun=1 ..... sat=7;
    //    NSInteger wantedWeekDay = 2; //for monday
    
    //set current date here
    NSDate *currentDate = [NSDate date];
    
    //get calender
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    // Start out by getting just the year, month and day components of the current date.
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:currentDate];
    // Change the Day component to 1 (for the first day of the month), and zero out the time components.
    [components setDay:1];
    
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    //get first day of current month
    NSDate *firstDateOfCurMonth = [gregorianCalendar dateFromComponents:components];
    
    //create new component to get weekday of first date
    NSDateComponents *newcomponents = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:firstDateOfCurMonth];
    NSInteger firstDateWeekDay = newcomponents.weekday;
    NSLog(@"weekday : %li",(long)firstDateWeekDay);
    
    //get last month date
    NSInteger curMonth = newcomponents.month;
    [newcomponents setMonth:curMonth+1];
    
    NSDate * templastDateOfCurMonth = [[gregorianCalendar dateFromComponents:newcomponents] dateByAddingTimeInterval: -1]; // One second before the start of next month
    
    NSDateComponents *lastcomponents = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:templastDateOfCurMonth];
    
    [lastcomponents setHour:0];
    [lastcomponents setMinute:0];
    [lastcomponents setSecond:0];
    
    //    NSDate *lastDateOfCurMonth = [gregorianCalendar dateFromComponents:lastcomponents];
    
    NSDate *lastDateOfCurMonth =  [currentDate dateByAddingTimeInterval:60*60*24*14];
    NSLog(@"%@",lastDateOfCurMonth);
    
    NSMutableArray *mutArrDates = [NSMutableArray array];
    
    NSDateComponents *dayDifference = [NSDateComponents new];
    [dayDifference setCalendar:gregorianCalendar];
    
    //get wanted weekday date
    NSDate *firstWeekDateOfCurMonth = nil;
    if (wantedWeekDay == firstDateWeekDay) {
        firstWeekDateOfCurMonth = firstDateOfCurMonth;
    } else {
        NSInteger day = wantedWeekDay - firstDateWeekDay;
        if (day < 0)
            day += 7;
        ++day;
        [components setDay:day];
        
        firstWeekDateOfCurMonth = [gregorianCalendar dateFromComponents:components];
    }
    
    NSLog(@"%@",firstWeekDateOfCurMonth);
    
    NSUInteger weekOffset = 0;
    NSDate *nextDate = firstWeekDateOfCurMonth;
    
    do {
        [mutArrDates addObject:nextDate];
        [dayDifference setWeekOfYear:++weekOffset];
        NSDate *date = [gregorianCalendar dateByAddingComponents:dayDifference toDate:firstWeekDateOfCurMonth options:0];
        nextDate = date;
    } while([nextDate compare:lastDateOfCurMonth] == NSOrderedAscending || [nextDate compare:lastDateOfCurMonth] == NSOrderedSame);
    
    NSLog(@"%@",mutArrDates);
    
    return mutArrDates;
}

+ (NSArray *)createKyQuayWithIdGame : (NSString *)idGame {
    NSMutableArray *arrayDate = [NSMutableArray array];
    if ([idGame isEqualToString:idMega645]) {
        //Tạo mảng thứ 4,6,CN trong tháng
        [arrayDate addObjectsFromArray:[Utils getAllDayOfMonth:1]];
        [arrayDate addObjectsFromArray:[Utils getAllDayOfMonth:4]];
        [arrayDate addObjectsFromArray:[Utils getAllDayOfMonth:6]];
    }else if ([idGame isEqualToString:idPower655]) {
        //Tạo mảng thứ 4,6,CN trong tháng
        [arrayDate addObjectsFromArray:[Utils getAllDayOfMonth:3]];
        [arrayDate addObjectsFromArray:[Utils getAllDayOfMonth:5]];
        [arrayDate addObjectsFromArray:[Utils getAllDayOfMonth:7]];
    }else if ([idGame isEqualToString:idMax3D]){
        //Tạo mảng thứ 3,5,7 trong tháng
        [arrayDate addObjectsFromArray:[Utils getAllDayOfMonth:1]];
        [arrayDate addObjectsFromArray:[Utils getAllDayOfMonth:4]];
        [arrayDate addObjectsFromArray:[Utils getAllDayOfMonth:6]];
    }else if ([idGame isEqualToString:idMax4D]) {
        //Tạo mảng thứ 4,6,CN trong tháng
        [arrayDate addObjectsFromArray:[Utils getAllDayOfMonth:3]];
        [arrayDate addObjectsFromArray:[Utils getAllDayOfMonth:5]];
        [arrayDate addObjectsFromArray:[Utils getAllDayOfMonth:7]];
    }
    
    [arrayDate sortUsingComparator:^(id dict1, id dict2) {
        NSDate *date1 = dict1;// create NSDate from dict1's Date;
        NSDate *date2 = dict2;// create NSDate from dict2's Date;
        return [date1 compare:date2];
    }];
    
    
    //Tạo mảng các ngày sau hôm nay
    NSMutableArray *arrayStrDateOK = [NSMutableArray array];
    for (NSDate *dateFrom in arrayDate) {
        if([dateFrom timeIntervalSinceDate:[NSDate date]] > 0 && arrayStrDateOK.count < 8) {
            NSString *date = [Utils getDateFromDate:dateFrom];
            [arrayStrDateOK addObject:date];
        }
    }
    
    return arrayStrDateOK;
}

+ (BOOL)isDisconnect {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable){
        NSLog(@"There is NO Internet connection");
        return YES;
    }else{
        NSLog(@"There is Internet connection");
        return NO;
    }
}

+ (NSInteger)_numberOfDaysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
    return [endDate timeIntervalSinceDate:startDate];
}

//+ (NSInteger)_numberOfDaysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
//    NSCalendar *calender = [NSCalendar autoupdatingCurrentCalendar];
//    [calender setTimeZone:[NSTimeZone systemTimeZone]];
//    NSInteger startDay = [calender ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitEra forDate:startDate];
//    NSInteger endDay = [calender ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitEra forDate:endDate];
//    return endDay - startDay;
//}

+ (BOOL)isContaintSpecialChar:(NSString *)string {
    //    NSString *stricterFilterString = @"^(?=.*[$@$!%*#?&])";
    //    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    //    return [passwordTest evaluateWithObject:string];
    
    NSString *specialCharacterString = @"!~`@#$%^&*(){}[]<>\"\'";
    NSCharacterSet *specialCharacterSet = [NSCharacterSet
                                           characterSetWithCharactersInString:specialCharacterString];

    if ([string.lowercaseString rangeOfCharacterFromSet:specialCharacterSet].length) {
        NSLog(@"contains special characters");
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)trimString : (NSString *)someString {
    NSString *newString = [someString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return newString;
}

+ (NSString *)secondsToMMSS : (long)elapsedSeconds {    
    NSInteger seconds = elapsedSeconds % 60;
    NSInteger minutes = (elapsedSeconds / 60) % 60;
    NSInteger hours = elapsedSeconds / (60 * 60);
    NSInteger day = elapsedSeconds / (60 * 60 * 24);
    NSString *result= [NSString stringWithFormat:@"%02ld : %02ld : %02ld : %02ld",day, hours, minutes, seconds];
    return result;
}

+ (void)showFB {
    NSURL *url = [NSURL URLWithString:@"fb://profile/351876888274703"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            
        }];
    }else{
        url = [NSURL URLWithString:@"https://www.facebook.com/vietlott.vn"];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            
        }];
    }
}

+ (void)showYoutube {
    NSURL *url = [NSURL URLWithString: @"https://www.youtube.com/watch?v=wAUlWERDA2g"];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
        
    }];
}

+ (void)showGroup {
    NSURL *url = [NSURL URLWithString: @"fb://profile/2053079854714200"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            
        }];
    }else{
        url = [NSURL URLWithString:@"https://www.facebook.com/vietlott.vn"];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            
        }];
    }
}

+ (void)showAlertLogin {
    [Utils alert:@"Thông báo" content:@"Vui lòng đăng nhập để sử dụng chức năng này" titleOK:@"Đăng nhập" titleCancel:@"Để sau" viewController:nil completion:^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
        [[self appDelegate].window setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"]];
        [[self appDelegate].window makeKeyAndVisible];
    }];
}

+ (NSString *)getKyFromDict : (NSDictionary *)dict {
    NSDate *date = [Utils getDateFromStringDate:dict[@"end_date"]];
    if (date) {
        NSString *day = [Utils getDayName:date];
        day = [NSString stringWithFormat:@"%@, %@",day,dict[@"end_date"]];
        
        return [NSString stringWithFormat:@"%@ - Kỳ #%@",day,dict[@"cycle_code"]];
    }else{
        return [NSString stringWithFormat:@"Kỳ #%@",dict[@"cycle_code"]];
    }
}

+ (int)placeInWeekForDate:(NSDate *)date {
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    int start = 0;
    switch ([component weekday]) {
        case 1:
            //Sunday
            start = 0;
            break;
        case 2:
            //Monday
            start = 1;
            break;
            
        case 3:
            //Tuesday
            start = 2;
            break;
            
        case 4:
            //Wen
            start = 3;
            break;
            
        case 5:
            //Thur
            start = 4;
            break;
            
        case 6:
            //Thur
            start = 5;
            break;
            
        case 7:
            //Saturday
            start = 6;
            break;
            
        default:
            break;
    }
    return start;
}

@end




























