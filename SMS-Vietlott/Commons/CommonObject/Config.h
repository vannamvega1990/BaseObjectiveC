//
//  Config.h
//  TelcoPlus
//
//  Created by Dang Nguyen on 5/17/15.
//  Copyright (c) 2015 Dang Nguyen. All rights reserved.
//

#ifndef TelcoPlus_Config_h
#define TelcoPlus_Config_h

//Vinaphone Number Prefix
#define ARR_VINAVPHONE_NUMBER_PREFIX    @[@"091",@"094",@"0123",@"0124",@"0125",@"0127",@"0129",@"088",@"8491",@"8494",@"84123",@"84124",@"84125",@"84127",@"84129",@"8488",@"+8491",@"+8494",@"+84123",@"+84124",@"+84125",@"+84127",@"+84129",@"+8488"]

#define RGB_COLOR(r, g, b)                [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define kPubkey @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI2bvVLVYrb4B0raZgFP60VXY\ncvRmk9q56QiTmEm9HXlSPq1zyhyPQHGti5FokYJMzNcKm0bwL1q6ioJuD4EFI56D\na+70XdRz1CjQPQE3yXrXXVvOsmq9LsdxTFWsVBTehdCmrapKZVVx6PKl7myh0cfX\nQmyveT/eqyZK1gYjvQIDAQAB\n-----END PUBLIC KEY-----"

#define kServiceVDI @"http://172.16.9.130:11000/" //noi bo VDI
#define kServicePublic @"http://113.20.109.148:3009/" //public

//#define kServiceImage @"http://172.16.9.130"
#define kServiceImage @"http://113.20.109.148"

#define kServiceWithToken @"appwithtoken/service/api"
#define kServiceWithNoToken @"appnotoken/service/api" 
#define kCheckSum @"vlt@123"
#define kAES @"HungNM@1983"
#define kMaDaiLy @"VTL"

#define kNotificationNameSelectBank @"kNotificationNameSelectBank"
#define kNotificationNameSelectEWallet @"kNotificationNameSelectEWallet"
#define kNotificationNameSelectTKTT @"kNotificationNameSelectTKTT"
#define kNotificationNameChoseTKTT @"kNotificationNameChoseTKTT"
#define kNotificationNameSelectEditTKTT @"kNotificationNameSelectEditTKTT"
#define kNotificationNameSelectProvince @"kNotificationNameSelectProvince"
#define kNotificationNameCreateTKTTSuccess @"kNotificationNameCreateTKTTSuccess"
#define kNotificationNameCreateTKNTSuccess @"kNotificationNameCreateTKNTSuccess"
#define kNotificationNameUpdateCart @"kNotificationNameUpdateCart"
#define kNotificationLoginSuccess @"kNotificationLoginSuccess"
#define kNotificationLoginFail @"kNotificationLoginFail"
#define kNotificationNameEditPhoneNumberSuccess @"kNotificationNameEditPhoneNumberSuccess"
#define kNotificationReadNotification @"kNotificationReadNotification"
#define kNotificationNameSelectDateNews @"kNotificationNameSelectDateNews"
#define kNotificationNameSelectTabbarHome @"kNotificationNameSelectTabbarHome"
#define kNotificationNameSelectTabbarNewNews @"kNotificationNameSelectTabbarNewNews"
#define kNotificationNameSelectTabbarActionNews @"kNotificationNameSelectTabbarActionNews"
#define kNotificationNameUpdatePersonalInfoSuccess @"kNotificationNameUpdatePersonalInfoSuccess"

#define kNotificationNameSelectAllFavoriteMega @"kNotificationNameSelectAllFavoriteMega"
#define kNotificationNameSelectAllFavoritePower @"kNotificationNameSelectAllFavoritePower"
#define kNotificationNameSelectAllFavoriteMax3D @"kNotificationNameSelectAllFavoriteMax3D"
#define kNotificationNameSelectAllFavoriteMax4D @"kNotificationNameSelectAllFavoriteMax4D"

#define kNotificationNameSelectDateThongKeMega @"kNotificationNameSelectDateThongKeMega"
#define kNotificationNameSelectDateThongKePower @"kNotificationNameSelectDateThongKePower"
#define kNotificationNameSelectDateThongKeMax3D @"kNotificationNameSelectDateThongKeMax3D"
#define kNotificationNameSelectDateThongKeMax4D @"kNotificationNameSelectDateThongKeMax4D"

#define kNotificationNameAddFavoriteMegaSuccess @"kNotificationNameAddFavoriteMegaSuccess"
#define kNotificationNameAddFavoritePowerSuccess @"kNotificationNameAddFavoritePowerSuccess"
#define kNotificationNameAddFavoriteMax3DSuccess @"kNotificationNameAddFavoriteMax3DSuccess"
#define kNotificationNameAddFavoriteMax4DSuccess @"kNotificationNameAddFavoriteMax4DSuccess"

#define kUserDefaultUserName @"kUserName"
#define kUserDefaultToken @"kToken"
#define kUserDefaultUserInfo @"kUserInfo"
#define kUserDefaultPassword @"kPassword"
#define kUserDefaultIsLogin @"kIsLogin"
#define kUserDefaultCodeActive @"kCodeActive"
#define kUserDefaultDeviceToken @"kDeviceTokenNew"
#define kUserDefaultIsSendToken @"kIsSendToken"
#define kUserDefaultCurrentAppVersion @"CurrentAppVersion"
#define kUserDefaultAccessToken @"kUserDefaultAccessToken"
#define kUserDefaultIdInit @"kUserDefaultIdInit"


#define INF0011 @"QK đã  hoàn thành việc khai báo thông tin đăng ký Tài khoản Tham gia dự thưởng. Hồ sơ đang được Vietlott kiểm duyệt, chúng tôi sẽ thông báo kết quả đăng ký qua tin nhắn SMS"

#define ERR0002 @"Số điện thoại này đã được sử dụng\nđể đăng ký tài khoản"

#define idMegaCoBan @"1"
#define idMegaBao5 @"2"
#define idMegaBao7 @"3"
#define idMegaBao8 @"4"
#define idMegaBao9 @"5"
#define idMegaBao10 @"6"
#define idMegaBao11 @"7"
#define idMegaBao12 @"8"
#define idMegaBao13 @"9"
#define idMegaBao14 @"10"
#define idMegaBao15 @"11"
#define idMegaBao18 @"12"

#define idPowerCoBan @"13"
#define idPowerBao5 @"14"
#define idPowerBao7 @"15"
#define idPowerBao8 @"16"
#define idPowerBao9 @"17"
#define idPowerBao10 @"18"
#define idPowerBao11 @"19"
#define idPowerBao12 @"20"
#define idPowerBao13 @"21"
#define idPowerBao14 @"22"
#define idPowerBao15 @"23"
#define idPowerBao18 @"24"

#define idMax3DCoBan @"25"
#define idMax3DDao @"26"
#define idMax3DOm @"27"

#define idMax4DCoBan @"35"
#define idMax4DToHop @"36"
#define idMax4DBao @"37"
#define idMax4DCuon1 @"38"
#define idMax4DCuon4 @"39"

#define idMega645 @"372"
#define idPower655 @"445"
#define idMax3D @"373"
#define idMax4D @"374"
#define idKeno @"446"

#define smsCodeMega @"645"
#define smsCodePower @"655"
#define smsCodeMax3D @"3D"
#define smsCodeMax4D @"4D"
#define smsCodeKeno @"Keno"

#endif
