//
//  PersonalInfoViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 4/3/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "CommonTableViewController.h"

@interface PersonalInfoViewController ()

@end

@implementation PersonalInfoViewController {
    NSDictionary *dictPersonal;
    NSDictionary *dictDDDT;
    int typeSelectPhoto;//0:avatar, 1:ImageFront, 2:ImageBack
    
    UIImage *newImageAvatar;
    NSMutableArray *arrayParamUploadImage;
    
    int widthImage;
    
    NSData *webDataFront;
    NSData *webDataBack;
    
    NSString *linkFrontImage;
    NSString *linkBackImage;
    
    NSString *typeGTCN;
    
    UIImage *imageFront;
    UIImage *imageBack;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getProfile];
    
    [self createArrayParamUploadImage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectProvince object:nil];
}

- (IBAction)changeAvatar:(id)sender {
    typeSelectPhoto = 0;
    [self selectTakePhoto];
}

- (IBAction)changeImage1:(id)sender {
    typeSelectPhoto = 1;
    [self selectTakePhoto];
}

- (IBAction)changeImage2:(id)sender {
    typeSelectPhoto = 2;
    [self selectTakePhoto];
}

- (IBAction)cancel:(id)sender {
    webDataFront = nil;
    webDataBack = nil;
    newImageAvatar = nil;
    
    self.textFieldSoGTCN.enabled = NO;
    self.textFieldName.enabled = NO;
    self.textFieldDoB.enabled = NO;
    self.textFieldNoiCap.enabled = NO;
    self.textFieldNgayCap.enabled = NO;
    
    [self fillInfo];
}

- (IBAction)update:(id)sender {
    if ([Utils lenghtText:self.textFieldDDDT.text] == 0) {
        [Utils alertError:@"Thông báo" content:@"Vui lòng chọn Địa điểm dự thưởng" viewController:self completion:^{
            [self selectDDDT:nil];
        }];
    }else if ([Utils lenghtText:self.textFieldEmail.text] > 0 && ![Utils NSStringIsValidEmail:self.textFieldEmail.text]) {
        [Utils alertError:@"Thông báo" content:@"Email không chính xác, vui lòng nhập lại" viewController:self completion:^{
            [self.textFieldEmail becomeFirstResponder];
        }];
    }else{
        if (newImageAvatar != nil) {
            [self uploadAvatar:newImageAvatar];
        }
        
        if (webDataFront != nil && webDataBack != nil) {
            [self updateGTCN];
        }if (webDataFront != nil && webDataBack == nil) {
            [Utils alertError:@"Thông báo" content:@"Vui lòng thêm ảnh giấy tờ cá nhân mặt sau" viewController:self completion:^{
                [self changeImage1:nil];
            }];
        }if (webDataFront == nil && webDataBack != nil) {
            [Utils alertError:@"Thông báo" content:@"Vui lòng thêm ảnh giấy tờ cá nhân mặt trước" viewController:self completion:^{
                [self changeImage2:nil];
            }];
        }else{
            [self updatePersonalInfo];
        }
    }
}

- (void)choseDateDoB {
    UIDatePicker *picker = (UIDatePicker*)self.textFieldDoB.inputView;
    self.textFieldDoB.text = [self formatDate:picker.date];
}

- (IBAction)selectDob:(id)sender {
    [self choseDateDoB];
}

- (void)choseDateProvide {
    UIDatePicker *picker = (UIDatePicker*)self.textFieldNgayCap.inputView;
    self.textFieldNgayCap.text = [self formatDate:picker.date];
}

- (IBAction)selectDateProvice:(id)sender {
    [self choseDateProvide];
}

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

- (BOOL)checkEnoughInfo {
    BOOL isOK = YES;
    if ([Utils lenghtText:self.textFieldSoGTCN.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập Số Giấy Tờ Cá Nhân" viewController:self completion:^{
            [self.textFieldSoGTCN becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldSoGTCN.text] < 9) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Số Giấy Tờ Cá Nhân không chính xác" viewController:self completion:^{
            [self.textFieldSoGTCN becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldName.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập Họ tên" viewController:self completion:^{
            [self.textFieldName becomeFirstResponder];
        }];
    }else if ([Utils isContaintSpecialChar:self.textFieldName.text]) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng không nhập ký tự đặc biệt cho Họ tên" viewController:self completion:^{
            [self.textFieldName becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldDoB.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập Ngày sinh" viewController:self completion:^{
            [self.textFieldDoB becomeFirstResponder];
        }];
    }else if ([Utils _numberOfDaysFromDate:[Utils getDateFromStringDate:self.textFieldDoB.text] toDate:[NSDate date]] < 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Ngày sinh không hợp lệ" viewController:self completion:^{
            [self.textFieldDoB becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldNoiCap.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập Nơi cấp giấy tờ cá nhân" viewController:self completion:^{
            [self.textFieldNoiCap becomeFirstResponder];
        }];
    }else if ([Utils isContaintSpecialChar:self.textFieldNoiCap.text]) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng không nhập ký tự đặc biệt cho Nơi cấp giấy tờ cá nhân" viewController:self completion:^{
            [self.textFieldNoiCap becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldNgayCap.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập Ngày cấp giấy tờ cá nhân" viewController:self completion:^{
            [self.textFieldNgayCap becomeFirstResponder];
        }];
    }else if ([Utils _numberOfDaysFromDate:[Utils getDateFromStringDate:self.textFieldNgayCap.text] toDate:[NSDate date]] < 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Ngày cấp giấy tờ cá nhân không hợp lệ" viewController:self completion:^{
            [self.textFieldNgayCap becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldDDDT.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng chọn Nơi đăng ký Tham Gia Dự Thưởng" viewController:self completion:^{
            [self selectDDDT:nil];
        }];
    }else if ([Utils lenghtText:self.textFieldEmail.text] > 0 && ![Utils NSStringIsValidEmail:self.textFieldEmail.text]) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Email không chính xác, vui lòng nhập lại" viewController:self completion:^{
            [self.textFieldEmail becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldAdd.text] > 0 && [Utils isContaintSpecialChar:self.textFieldAdd.text]) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng không nhập ký tự đặc biệt cho Địa chỉ thường trú" viewController:self completion:^{
            [self.textFieldAdd becomeFirstResponder];
        }];
    }
    
    return isOK;
}

- (IBAction)selectDDDT:(id)sender {
    [self getListProvince];
}

- (void)fillInfo {
    NSArray *arrayGTCN = dictPersonal[@"list_gtcn"];
    NSDictionary *dictGTCN;
    for (NSDictionary *dict in arrayGTCN) {
        if ([dict[@"status"] intValue] == 1) {
            dictGTCN = [Utils converDictRemoveNullValue:dict];
            break;
        }
    }
    
    typeGTCN = [NSString stringWithFormat:@"%@",dictGTCN[@"type"]];
    if ([typeGTCN isEqualToString:@"1"]) {
        self.imageRadioCMND.image = [UIImage imageNamed:@"btn_radio_selected"];
        self.imageRadioCCCD.image = [UIImage imageNamed:@"btn_radio_unselect"];
    }else{
        self.imageRadioCMND.image = [UIImage imageNamed:@"btn_radio_unselect"];
        self.imageRadioCCCD.image = [UIImage imageNamed:@"btn_radio_selected"];
    }
    
    NSString *avatar = [NSString stringWithFormat:@"%@",dictPersonal[@"avatar"]];
    [self.imageAvatar sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    NSString *img1 = [NSString stringWithFormat:@"%@",dictGTCN[@"front_img"]];
    [self.imageGTCN1 sd_setImageWithURL:[NSURL URLWithString:img1] placeholderImage:[UIImage imageNamed:@"rectangle"]];
    
    NSString *img2 = [NSString stringWithFormat:@"%@",dictGTCN[@"back_img"]];
    [self.imageGTCN2 sd_setImageWithURL:[NSURL URLWithString:img2] placeholderImage:[UIImage imageNamed:@"rectangle"]];
    
    self.textFieldSoGTCN.text = [NSString stringWithFormat:@"%@",dictGTCN[@"id_number"]];
    self.textFieldName.text = [NSString stringWithFormat:@"%@",dictGTCN[@"name"]];
    self.textFieldDoB.text = [NSString stringWithFormat:@"%@",dictGTCN[@"dob"]];
    self.textFieldNoiCap.text = [NSString stringWithFormat:@"%@",dictGTCN[@"poi"]];
    self.textFieldNgayCap.text = [NSString stringWithFormat:@"%@",dictGTCN[@"doi"]];
    self.textFieldAdd.text = [NSString stringWithFormat:@"%@",dictPersonal[@"dia_chi_thuong_tru"]];
    self.textFieldEmail.text = [NSString stringWithFormat:@"%@",dictPersonal[@"email"]];
    self.textFieldDDDT.text = [NSString stringWithFormat:@"%@",dictPersonal[@"dia_diem_du_thuong"]];
    
    dictDDDT = @{@"pr_code":dictPersonal[@"id_dia_diem_du_thuong"],
                 @"pr_name":dictPersonal[@"dia_diem_du_thuong"]
    };
    
    imageFront = [UIImage imageNamed:@"rectangle"];
    imageBack = [UIImage imageNamed:@"rectangle"];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.textFieldSoGTCN && (textField.text.length <= 20 || string.length == 0)) {
        return YES;
    }else if (textField == self.textFieldName && (textField.text.length <= 50 || string.length == 0)) {
        return YES;
    }else if (textField == self.textFieldNoiCap && (textField.text.length <= 50 || string.length == 0)) {
        return YES;
    }else if (textField == self.textFieldAdd && (textField.text.length <= 200 || string.length == 0)) {
        return YES;
    }else if (textField == self.textFieldEmail && (textField.text.length <= 50 || string.length == 0)) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark CallAPI

- (void)getProfile {
    NSArray *check_sum = @[@"api0010_get_profile",
                           [VariableStatic sharedInstance].phoneNumber
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"api0010_get_profile",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber
                                };

    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        self->dictPersonal = [Utils converDictRemoveNullValue:dictData[@"info"]];
        [self fillInfo];
    }];
}

- (void)getListProvince {
    NSArray *check_sum = @[@"api0040_get_list_provinces"];
    
    NSDictionary *dictParam = @{@"KEY":@"api0040_get_list_provinces"};

    [CallAPI callApiService:kServiceWithNoToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        NSArray *arrayPorvince = dictData[@"info"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
        CommonTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CommonTableViewController"];
        vc.arrayItem = arrayPorvince;
        vc.typeView = kProvince;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    }];
}

- (void)updatePersonalInfo {
    NSArray *check_sum = @[@"api0011_update_profile",
                           [VariableStatic sharedInstance].phoneNumber,
                           self.textFieldAdd.text,
                           self.textFieldEmail.text,
                           dictDDDT[@"pr_code"]
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"api0011_update_profile",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"dia_chi_thuong_tru":self.textFieldAdd.text,
                                @"email":self.textFieldEmail.text,
                                @"dia_diem_du_thuong":dictDDDT[@"pr_code"]
                                };

    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameUpdatePersonalInfoSuccess object:nil];
        [Utils alertError:@"Thông báo" content:@"Cập nhật thông tin cá nhân thành công" viewController:self completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

- (void)uploadAvatar : (UIImage *)image {
    NSMutableArray *arrayParamUploadImage = [NSMutableArray array];
    NSString *check_sum = [Utils makeCheckSum:@[@"api0045_update_avatar",[VariableStatic sharedInstance].phoneNumber]];
    NSString *value = [NSString stringWithFormat:@"{\n\"KEY\" = \"api0045_update_avatar\",\n\"check_sum\" = \"%@\",\n\"user_name\" = \"%@\"\n}",check_sum,[VariableStatic sharedInstance].phoneNumber];
    
    NSDictionary *dictParam = @{ @"name": @"data",
                                 @"value": value };
    [arrayParamUploadImage addObject:dictParam];
    
    NSDictionary *dictImageFront = @{@"name": @"avatar",
                                     @"fileName":[[VariableStatic sharedInstance].phoneNumber stringByAppendingString:@"_avatar.png"],
                                     @"image":image
    };
    [arrayParamUploadImage addObject:dictImageFront];
    
    [Utils uploadAvatar:arrayParamUploadImage completeBlock:^(NSDictionary *dictData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([dictData[@"error"]  isEqual:@"0000"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameUpdatePersonalInfoSuccess object:nil];
                [Utils alertError:@"Thông báo" content:@"Cập nhật thông tin cá nhân thành công" viewController:self completion:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }else{
                NSString *mes = [NSString stringWithFormat:@"%@",dictData[@"mes"]];
                if (mes.length == 0) {
                    mes = @"Hệ thống đang bận vui lòng thử lại sau";
                }
                [Utils alertError:@"Thông báo" content:mes viewController:self completion:^{
                    
                }];
            }
        });
    }];
}

- (void)updateGTCN {
    NSArray *check_sum = @[@"api0014_add_id_card",
                           [VariableStatic sharedInstance].phoneNumber,
                           self.textFieldName.text,
                           self.textFieldDoB.text,
                           self.textFieldSoGTCN.text,
                           self.textFieldNoiCap.text,
                           self.textFieldNgayCap.text,
                           typeGTCN,
                           linkFrontImage != nil ? linkFrontImage : @"",
                           linkBackImage != nil ? linkBackImage : @""
                           ];
    
    NSDictionary *dictParam = @{@"KEY":@"api0014_add_id_card",
                                @"user_name":[VariableStatic sharedInstance].phoneNumber,
                                @"name":self.textFieldName.text,
                                @"dob":self.textFieldDoB.text,
                                @"id_number":self.textFieldSoGTCN.text,
                                @"poi":self.textFieldNoiCap.text,
                                @"doi":self.textFieldNgayCap.text,
                                @"type":typeGTCN,
                                @"front_img":linkFrontImage != nil ? linkFrontImage : @"",
                                @"back_img":linkBackImage != nil ? linkBackImage : @""
                                };

    [CallAPI callApiService:kServiceWithToken dictParam:dictParam arrayCheckSum:check_sum isGetError:NO  viewController:self completeBlock:^(NSDictionary *dictData) {
        [self updatePersonalInfo];
    }];
}

#pragma mark TakePhoto

- (void)selectTakePhoto {
    UIAlertController *actionSheet = [UIAlertController
                                      alertControllerWithTitle:@"Thêm ảnh"
                                      message:@"Mời bạn chọn ảnh từ trong bộ sưu tập hoặc chụp ảnh mới"
                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *btnTakePhoto = [UIAlertAction
                                   actionWithTitle:@"Máy ảnh"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action) {
                                       [actionSheet dismissViewControllerAnimated:YES completion:nil];
                                       [self takePhoto];
                                   }];
    [actionSheet addAction:btnTakePhoto];
    
    UIAlertAction *btnSelectPhoto = [UIAlertAction
                                     actionWithTitle:@"Bộ sưu tập"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction *action) {
                                         [actionSheet dismissViewControllerAnimated:YES completion:nil];
                                         [self selectPhoto];
                                     }];
    [actionSheet addAction:btnSelectPhoto];
    
    UIAlertAction *btnCancel = [UIAlertAction
                                actionWithTitle:@"Huỷ bỏ"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action) {
                                    [actionSheet dismissViewControllerAnimated:YES completion:nil];
                                }];
    [btnCancel setValue:[UIColor redColor] forKey:@"titleTextColor"];
    [actionSheet addAction:btnCancel];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [actionSheet.popoverPresentationController setPermittedArrowDirections:0];

        //For set action sheet to middle of view.
        CGRect rect = self.view.frame;
        actionSheet.popoverPresentationController.sourceView = self.view;
        actionSheet.popoverPresentationController.sourceRect = rect;
    }
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    __block BOOL isAccess = NO;
    
    if(authStatus == AVAuthorizationStatusAuthorized) {
        isAccess = YES;
    }else if(authStatus == AVAuthorizationStatusNotDetermined){
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted){
            if(granted){
                isAccess = YES;
            }else{
                isAccess = NO;
            }
        }];
    }else if (authStatus == AVAuthorizationStatusRestricted){
        isAccess = YES;
    }else{
        isAccess = NO;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            if (!isAccess) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, [UIScreen mainScreen].bounds.size.width-60, [UIScreen mainScreen].bounds.size.height)];
                label.text = @"Để cấp cho SMS-Vietlott quyền truy cập vào camera của bạn, hãy chuyển đến Cài đặt > Quyền riêng tư > Camera trên thiết bị của bạn";
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor whiteColor];
                label.numberOfLines = 0;
                [picker.view addSubview:label];
            }
            
            [self presentViewController:picker animated:YES completion:nil];
        }
    });
}

- (void)selectPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:@"public.image"]) {
            switch (self->typeSelectPhoto) {
                case 0:
                {
                    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
                    self.imageAvatar.image = image;
                    self->newImageAvatar = [Utils scaleImageFromImage:image scaledToSize:300];
                }
                    break;
                    
                case 1:
                {
                    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
                    self.imageGTCN1.image = image;
                    self->webDataFront =  UIImageJPEGRepresentation(image,0.2);
                    UIImage *newImage = [Utils scaleImageFromImage:info[UIImagePickerControllerOriginalImage] scaledToSize:self->widthImage];
                    NSDictionary *dictImageFront = @{@"name": @"file_front_img",
                                                     @"fileName":[[VariableStatic sharedInstance].phoneNumber stringByAppendingString:@"_front.png"],
                                                     @"image":newImage
                    };
                    [self->arrayParamUploadImage replaceObjectAtIndex:1 withObject:dictImageFront];
                    self->imageFront = image;
                    [self getInfoFromImages];
                }
                    break;
                    
                case 2:
                {
                    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
                    self.imageGTCN2.image = image;
                    self->webDataBack =  UIImageJPEGRepresentation(image,0.2);
                    UIImage *newImage = [Utils scaleImageFromImage:info[UIImagePickerControllerOriginalImage] scaledToSize:self->widthImage];
                    NSDictionary *dictImageBack = @{@"name": @"file_back_img",
                                                     @"fileName":[[VariableStatic sharedInstance].phoneNumber stringByAppendingString:@"_back.png"],
                                                     @"image":newImage
                    };
                    [self->arrayParamUploadImage replaceObjectAtIndex:2 withObject:dictImageBack];
                    self->imageBack = image;
                    [self getInfoFromImages];
                }
                    break;
                    
                default:
                    break;
            }
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)createArrayParamUploadImage {
    widthImage = 400;
    
    arrayParamUploadImage = [NSMutableArray array];
    NSString *check_sum = [Utils makeCheckSum:@[@"api0004_submit_id_image",[VariableStatic sharedInstance].phoneNumber]];
    NSString *value = [NSString stringWithFormat:@"{\n\"KEY\" = \"api0004_submit_id_image\",\n\"check_sum\" = \"%@\",\n\"mobile\" = \"%@\"\n}",check_sum,[VariableStatic sharedInstance].phoneNumber];
    
    NSDictionary *dictParam = @{ @"name": @"data",
                                 @"value": value };
    [arrayParamUploadImage addObject:dictParam];
    
    NSDictionary *dictImageFront = @{@"name": @"file_front_img",
                                     @"fileName":[[VariableStatic sharedInstance].phoneNumber stringByAppendingString:@"_front"],
                                     @"image":@""
    };
    [arrayParamUploadImage addObject:dictImageFront];
    
    NSDictionary *dictImageBack = @{@"name": @"file_back_img",
                                     @"fileName":[[VariableStatic sharedInstance].phoneNumber stringByAppendingString:@"_back"],
                                     @"image":@""
    };
    [arrayParamUploadImage addObject:dictImageBack];
}

- (void)getInfoFromImages {
    if (webDataFront != nil && webDataBack != nil) {
        [Utils uploadFiles:arrayParamUploadImage completeBlock:^(NSDictionary *dictData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([dictData[@"error"]  isEqual:@"0000"]) {
                    NSDictionary *dictResult = [Utils converDictRemoveNullValue:dictData[@"info"]];
                    [self fillNewInfo:dictResult];
                }else if ([dictData[@"error"]  isEqual:@"0011"]) {
                    NSString *mes = [NSString stringWithFormat:@"%@\nVui lòng thay ảnh khác?",dictData[@"mes"]];
                    [Utils alert:@"Thông báo" content:mes titleOK:@"Nhập tay" titleCancel:@"Thay ảnh" viewController:self completion:^{
                        [self fillNewInfo:@{}];
                    }];
                }else{
                    NSString *mes = [NSString stringWithFormat:@"%@",dictData[@"mes"]];
                    if (mes.length == 0) {
                        mes = @"Hệ thống đang bận vui lòng thử lại sau";
                    }
                    [Utils alertError:@"Thông báo" content:mes viewController:self completion:^{
                        self->webDataFront = nil;
                        self->webDataBack = nil;
                        [self fillInfo];
                    }];
                }
            });
        }];
    }else{
        [self fillNewInfo:@{}];
    }
}

- (void)fillNewInfo : (NSDictionary *)dict {
    UIDatePicker *dateOfBirthPicker = [[UIDatePicker alloc]init];
    [dateOfBirthPicker setDate:[NSDate date]];
    [dateOfBirthPicker setDatePickerMode:UIDatePickerModeDate];
    [dateOfBirthPicker addTarget:self action:@selector(choseDateDoB) forControlEvents:UIControlEventValueChanged];
    [self.textFieldDoB setInputView:dateOfBirthPicker];
    
    UIDatePicker *dateProvicePicker = [[UIDatePicker alloc]init];
    [dateProvicePicker setDate:[NSDate date]];
    [dateProvicePicker setDatePickerMode:UIDatePickerModeDate];
    [dateProvicePicker addTarget:self action:@selector(choseDateProvide) forControlEvents:UIControlEventValueChanged];
    [self.textFieldNgayCap setInputView:dateProvicePicker];
    
    self.textFieldSoGTCN.enabled = YES;
    self.textFieldName.enabled = YES;
    self.textFieldDoB.enabled = YES;
    self.textFieldNoiCap.enabled = YES;
    self.textFieldNgayCap.enabled = YES;
    
    self.textFieldSoGTCN.text = dict[@"id_number"];
    self.textFieldName.text = dict[@"name"];
    self.textFieldDoB.text = dict[@"dob"];
    self.textFieldNoiCap.text = dict[@"poi"];
    self.textFieldNgayCap.text = dict[@"doi"];
    
    typeGTCN = [NSString stringWithFormat:@"%@",dict[@"type"]];
    if ([typeGTCN isEqualToString:@"1"]) {
        self.imageRadioCMND.image = [UIImage imageNamed:@"btn_radio_selected"];
        self.imageRadioCCCD.image = [UIImage imageNamed:@"btn_radio_unselect"];
    }else{
        self.imageRadioCMND.image = [UIImage imageNamed:@"btn_radio_unselect"];
        self.imageRadioCCCD.image = [UIImage imageNamed:@"btn_radio_selected"];
    }
    
    linkFrontImage = dict[@"front_img"];
    linkBackImage = dict[@"back_img"];
    
    self.imageGTCN1.image = imageFront;
    self.imageGTCN2.image = imageBack;
}

#pragma mark Recive Notification

- (void) reciveNotifi : (NSNotification *)notif {
    if ([notif.name isEqualToString:kNotificationNameSelectProvince]) {
        dictDDDT = notif.object;
        if (dictDDDT) {
            self.textFieldDDDT.text = dictDDDT[@"pr_name"];
        }
    }
}

@end
