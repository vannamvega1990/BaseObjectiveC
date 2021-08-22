//
//  CallAPI.m
//  NoiBaiAirPort
//
//  Created by HuCuBi on 6/1/18.
//  Copyright © 2018 NeoJSC. All rights reserved.
//

#import "CallAPI.h"
#import "VariableStatic.h"

@implementation CallAPI

+ (void)callApiService : (NSString *)service dictParam:(NSDictionary *)param arrayCheckSum: (NSArray *)arrayCheckSum isGetError:(BOOL)isGetError viewController : (UIViewController *)vc completeBlock:(void(^)(NSDictionary *dictData))block {
    
    [SVProgressHUD show];
    
    NSString *url = [[VariableStatic sharedInstance].kService stringByAppendingString:service];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager.requestSerializer setTimeoutInterval:60.0];
    [manager.requestSerializer setValue:@"no-cache" forHTTPHeaderField:@"cache-control"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if ([service isEqualToString:kServiceWithToken]) {
        NSString *token = [NSString stringWithFormat:@"Bearer %@",[VariableStatic sharedInstance].accessToken];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    }
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, id parameters, NSError * __autoreleasing * error) {
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:error];
        NSString *argString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return argString;
    }];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary *dictParam = [[NSMutableDictionary alloc] initWithDictionary:param];
    [dictParam setObject:[Utils makeCheckSum:arrayCheckSum] forKey:@"check_sum"];
    NSLog(@"\n%@\n%@",url,dictParam);
    
    [manager POST:url parameters:dictParam headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        NSDictionary *dictResult = [responseObject mutableObjectFromJSONData];
        dictResult = [Utils converDictRemoveNullValue:dictResult];
        NSLog(@"\n%@\n%@\n%@",url,param[@"KEY"],dictResult);
        
        if ([dictResult[@"error"]  isEqual:@"0000"]) {
            block(dictResult);
        }else if ([dictResult[@"error"]  isEqual:@"9994"]) {
            [Utils alertError:@"Thông báo" content:@"Phiên đăng nhập hết hạn, vui lòng đăng nhập lại" viewController:vc completion:^{
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
                [[self appDelegate].window setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"]];
                [[self appDelegate].window makeKeyAndVisible];
            }];
        }else{
            if (isGetError) {
                block(dictResult);
            }else{
                NSString *mes = [NSString stringWithFormat:@"%@",dictResult[@"mes"]];
                if (mes.length == 0) {
                    mes = @"Hệ thống đang bận vui lòng thử lại sau";
                }
                [Utils alertError:@"Thông báo" content:mes viewController:vc completion:^{
                    
                }];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        NSLog(@"\n%@\n%@",url,error);
        if (isGetError) {
            block(nil);
        }else{
            [Utils alertError:@"Lỗi kết nối" content:@"Đề nghị kiểm tra wifi hoặc kết nối dữ liệu của thiết bị" viewController:vc completion:^{
                
            }];
        }
    }];
}

+ (AppDelegate *) appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}



@end























