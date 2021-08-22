//
//  GTCNViewController.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 3/24/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "RegisterGTCNViewController.h"
#import "InstructionTakePhotoSubViewController.h"
#import "AppDelegate.h"
#import "CommonTableViewController.h"
#import "CallAPI.h"

@interface RegisterGTCNViewController ()

@end

@implementation RegisterGTCNViewController {
    BOOL isSettup;
    float currentHeightViewInstruc;
    float currentHeightViewTTCN;
    BOOL isFrontPhoto;
    
    NSData *webDataFront;
    NSData *webDataBack;
    
    NSString *linkFrontImage;
    NSString *linkBackImage;
    
    NSString *gender;
    NSString *genderID;
    NSMutableArray *arrayParamUploadImage;
    
    int widthImage;
    NSDictionary *dictTP;
    NSString *typeGTCN;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reciveNotifi:) name:kNotificationNameSelectProvince object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    if (!isSettup) {
        isSettup = YES;
        [self settupView];
    }
}

- (void)settupView {
    gender = @"Nam";
    genderID = @"M";
    widthImage = 300;
    typeGTCN = @"1";
    
    currentHeightViewInstruc = self.heightViewInstructorTakePicture.constant;
    currentHeightViewTTCN = self.heightViewTTCN.constant;
    
    self.viewTTCN.hidden = YES;
    self.heightViewTTCN.constant = 0;
    
    UIDatePicker *dateOfBirthPicker = [[UIDatePicker alloc]init];
    [dateOfBirthPicker setDate:[NSDate date]];
    [dateOfBirthPicker setDatePickerMode:UIDatePickerModeDate];
    [dateOfBirthPicker addTarget:self action:@selector(choseDateDoB) forControlEvents:UIControlEventValueChanged];
    [self.textFieldDoB setInputView:dateOfBirthPicker];
    
    UIDatePicker *dateProvicePicker = [[UIDatePicker alloc]init];
    [dateProvicePicker setDate:[NSDate date]];
    [dateProvicePicker setDatePickerMode:UIDatePickerModeDate];
    [dateProvicePicker addTarget:self action:@selector(choseDateProvide) forControlEvents:UIControlEventValueChanged];
    [self.textFieldDateProvide setInputView:dateProvicePicker];
    
    [self createArrayParamUploadImage];
}

- (void)createArrayParamUploadImage {
    arrayParamUploadImage = [NSMutableArray array];
    NSString *check_sum = [Utils makeCheckSum:@[@"api0004_submit_id_image",self.phoneNumber]];
    NSString *value = [NSString stringWithFormat:@"{\n\"KEY\" = \"api0004_submit_id_image\",\n\"check_sum\" = \"%@\",\n\"mobile\" = \"%@\"\n}",check_sum,self.phoneNumber];
    
    NSDictionary *dictParam = @{ @"name": @"data",
                                 @"value": value };
    [arrayParamUploadImage addObject:dictParam];
    
    NSDictionary *dictImageFront = @{@"name": @"file_front_img",
                                     @"fileName":[self.phoneNumber stringByAppendingString:@"_front"],
                                     @"image":@""
    };
    [arrayParamUploadImage addObject:dictImageFront];
    
    NSDictionary *dictImageBack = @{@"name": @"file_back_img",
                                     @"fileName":[self.phoneNumber stringByAppendingString:@"_back"],
                                     @"image":@""
    };
    [arrayParamUploadImage addObject:dictImageBack];
}

- (void)choseDateDoB {
    UIDatePicker *picker = (UIDatePicker*)self.textFieldDoB.inputView;
    self.textFieldDoB.text = [self formatDate:picker.date];
}

- (IBAction)selectDob:(id)sender {
    [self choseDateDoB];
}

- (void)choseDateProvide {
    UIDatePicker *picker = (UIDatePicker*)self.textFieldDateProvide.inputView;
    self.textFieldDateProvide.text = [self formatDate:picker.date];
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

- (IBAction)showInstructionTakePhoto:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    InstructionTakePhotoSubViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"InstructionTakePhotoSubViewController"];

    [[[self appDelegate] window] addSubview:vc.view];
    [[[self appDelegate] window].rootViewController addChildViewController:vc];
}

- (IBAction)takeFrontPicture:(id)sender {
    isFrontPhoto = YES;
    [self selectTakePhoto];
}

- (IBAction)takeBackPicture:(id)sender {
    isFrontPhoto = NO;
    [self selectTakePhoto];
}

- (IBAction)selectCMND:(id)sender {
    self.imageRadioCMND.image = [UIImage imageNamed:@"btn_radio_selected"];
    self.imageRadioCCCD.image = [UIImage imageNamed:@"btn_radio_unselect"];
    typeGTCN = @"1";
}

- (IBAction)selectCCCD:(id)sender {
    self.imageRadioCMND.image = [UIImage imageNamed:@"btn_radio_unselect"];
    self.imageRadioCCCD.image = [UIImage imageNamed:@"btn_radio_selected"];
    typeGTCN = @"2";
}

- (IBAction)selectMale:(id)sender {
    self.imageRadioMale.image = [UIImage imageNamed:@"btn_radio_selected"];
    self.imageRadioFemale.image = [UIImage imageNamed:@"btn_radio_unselect"];
    gender = @"Nam";
    genderID = @"M";
}

- (IBAction)selectFemale:(id)sender {
    self.imageRadioMale.image = [UIImage imageNamed:@"btn_radio_unselect"];
    self.imageRadioFemale.image = [UIImage imageNamed:@"btn_radio_selected"];
    gender = @"Nữ";
    genderID = @"F";
}

- (IBAction)selectPlaceDKDT:(id)sender {
    [self getListProvince];
}

- (IBAction)continueRegister:(id)sender {
    if ([self checkEnoughInfo]) {
        NSDictionary *dictTTCN = @{@"imageF":self.imageGTCNFront.image,
                                   @"imageB":self.imageGTCNBack.image,
                                   @"number_gtcn":self.textFieldNumberGTCN.text,
                                   @"name":[Utils trimString:self.textFieldName.text],
                                   @"dob":self.textFieldDoB.text,
                                   @"provide_place":self.textFieldPlaceProvide.text,
                                   @"provide_date":self.textFieldDateProvide.text,
                                   @"place_tgdt":self.textFieldPlaceDKDT.text,
                                   @"place_tgdt_id":[NSString stringWithFormat:@"%@",dictTP[@"pr_code"]],
                                   @"gender":gender,
                                   @"gender_id":genderID,
                                   @"add":self.textFieldAddress.text,
                                   @"email":self.textFieldEmail.text,
                                   @"link_imageF":linkFrontImage != nil ? linkFrontImage : @"",
                                   @"link_imageB":linkBackImage != nil ? linkBackImage : @"",
                                   @"gtcn_type":typeGTCN
        };
        [self.delegate continueGTCN:dictTTCN];
    }
}

- (IBAction)sendImageGTCN:(id)sender {
    if (webDataFront == nil) {
        [Utils alertError:@"Thông báo" content:@"Vui lòng chụp ảnh mặt trước Giấy Tờ Cá Nhân" viewController:self completion:^{
            [self takeFrontPicture:nil];
        }];
    }else if (webDataBack == nil) {
        [Utils alertError:@"Thông báo" content:@"Vui lòng chụp ảnh mặt sau Giấy Tờ Cá Nhân" viewController:self completion:^{
            [self takeBackPicture:nil];
        }];
    }else{
        [self getInfoFromImages];
//        [self showViewInfo:@{}];
    }
}

- (AppDelegate *) appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)showViewInfo : (NSDictionary *)dict {
    self.viewInstructorTakePicture.hidden = YES;
    self.heightViewInstructorTakePicture.constant = 0;
    
    self.viewTTCN.hidden = NO;
    self.heightViewTTCN.constant = currentHeightViewTTCN;
    
    self.textFieldNumberGTCN.text = dict[@"id_number"];
    self.textFieldName.text = dict[@"name"];
    self.textFieldDoB.text = dict[@"dob"];
    self.textFieldPlaceProvide.text = dict[@"poi"];
    self.textFieldDateProvide.text = dict[@"doi"];
    self.textFieldAddress.text = dict[@"residence"];
    
    if ([dict[@"type"] isEqualToString:@"2"]) {
        [self selectCCCD:nil];
    }else{
        [self selectCMND:nil];
    }
    
    if ([dict[@"gender"] isEqualToString:@"Nam"]) {
        [self selectMale:nil];
    }else if ([dict[@"gender"] isEqualToString:@"Nữ"]) {
        [self selectFemale:nil];
    }else{
        self.imageRadioMale.image = [UIImage imageNamed:@"btn_radio_unselect"];
        self.imageRadioFemale.image = [UIImage imageNamed:@"btn_radio_unselect"];
        gender = @"";
        genderID = @"";
    }
    
    linkFrontImage = dict[@"front_img"];
    linkBackImage = dict[@"back_img"];
    
    if ([Utils lenghtText:dict[@"province_id"]] > 0) {
        dictTP = @{@"pr_code" : dict[@"province_id"],
                   @"pr_name" : dict[@"province_name"]};
        self.textFieldPlaceDKDT.text = dict[@"province_name"];
    }
}

- (void)hideViewInfo {
    self.viewInstructorTakePicture.hidden = NO;
    self.heightViewInstructorTakePicture.constant = currentHeightViewInstruc;
    
    self.viewTTCN.hidden = YES;
    self.heightViewTTCN.constant = 0;
}

- (BOOL)checkEnoughInfo {
    BOOL isOK = YES;
    if ([Utils lenghtText:self.textFieldNumberGTCN.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập Số Giấy Tờ Cá Nhân" viewController:self completion:^{
            [self.textFieldNumberGTCN becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldNumberGTCN.text] < 9) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Số Giấy Tờ Cá Nhân không chính xác" viewController:self completion:^{
            [self.textFieldNumberGTCN becomeFirstResponder];
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
    }else if ([Utils lenghtText:self.textFieldPlaceProvide.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập Nơi cấp giấy tờ cá nhân" viewController:self completion:^{
            [self.textFieldPlaceProvide becomeFirstResponder];
        }];
    }else if ([Utils isContaintSpecialChar:self.textFieldPlaceProvide.text]) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng không nhập ký tự đặc biệt cho Nơi cấp giấy tờ cá nhân" viewController:self completion:^{
            [self.textFieldPlaceProvide becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldDateProvide.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng nhập Ngày cấp giấy tờ cá nhân" viewController:self completion:^{
            [self.textFieldDateProvide becomeFirstResponder];
        }];
    }else if ([Utils _numberOfDaysFromDate:[Utils getDateFromStringDate:self.textFieldDateProvide.text] toDate:[NSDate date]] < 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Ngày cấp giấy tờ cá nhân không hợp lệ" viewController:self completion:^{
            [self.textFieldDateProvide becomeFirstResponder];
        }];
    }else if ([Utils _numberOfDaysFromDate:[Utils getDateFromStringDate:self.textFieldDoB.text] toDate:[Utils getDateFromStringDate:self.textFieldDateProvide.text]] < 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Ngày cấp giấy tờ cá nhân không hợp lệ" viewController:self completion:^{
            [self.textFieldDateProvide becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldPlaceDKDT.text] == 0) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng chọn Nơi đăng ký Tham Gia Dự Thưởng" viewController:self completion:^{
            [self selectPlaceDKDT:nil];
        }];
    }else if ([Utils lenghtText:self.textFieldEmail.text] > 0 && ![Utils NSStringIsValidEmail:self.textFieldEmail.text]) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Email không chính xác, vui lòng nhập lại" viewController:self completion:^{
            [self.textFieldEmail becomeFirstResponder];
        }];
    }else if ([Utils lenghtText:self.textFieldAddress.text] > 0 && [Utils isContaintSpecialChar:self.textFieldAddress.text]) {
        isOK = NO;
        [Utils alertError:@"Thông báo" content:@"Vui lòng không nhập ký tự đặc biệt cho Địa chỉ thường trú" viewController:self completion:^{
            [self.textFieldAddress becomeFirstResponder];
        }];
    }
    
    return isOK;
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
    if (isFrontPhoto) {
        self.imageGTCNFront.image = info[UIImagePickerControllerOriginalImage];
    }else{
        self.imageGTCNBack.image = info[UIImagePickerControllerOriginalImage];
    }


    [picker dismissViewControllerAnimated:YES completion:^{
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:@"public.image"]) {
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

            if (self->isFrontPhoto) {
                self->webDataFront =  UIImageJPEGRepresentation(image,0.2);
                UIImage *newImage = [Utils scaleImageFromImage:info[UIImagePickerControllerOriginalImage] scaledToSize:self->widthImage];
                NSDictionary *dictImageFront = @{@"name": @"file_front_img",
                                                 @"fileName":[self.phoneNumber stringByAppendingString:@"_front.png"],
                                                 @"image":newImage
                };
                [self->arrayParamUploadImage replaceObjectAtIndex:1 withObject:dictImageFront];
            }else{
                self->webDataBack =  UIImageJPEGRepresentation(image,0.2);
                UIImage *newImage = [Utils scaleImageFromImage:info[UIImagePickerControllerOriginalImage] scaledToSize:self->widthImage];
                NSDictionary *dictImageFront = @{@"name": @"file_back_img",
                                                 @"fileName":[self.phoneNumber stringByAppendingString:@"_back.png"],
                                                 @"image":newImage
                };
                [self->arrayParamUploadImage replaceObjectAtIndex:2 withObject:dictImageFront];
            }
        }
        [self hideViewInfo];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.textFieldNumberGTCN && (textField.text.length <= 20 || string.length == 0)) {
        return YES;
    }else if (textField == self.textFieldName && (textField.text.length <= 50 || string.length == 0)) {
        return YES;
    }else if (textField == self.textFieldPlaceProvide && (textField.text.length <= 50 || string.length == 0)) {
        return YES;
    }else if (textField == self.textFieldAddress && (textField.text.length <= 200 || string.length == 0)) {
        return YES;
    }else if (textField == self.textFieldEmail && (textField.text.length <= 50 || string.length == 0)) {
        return YES;
    }else{
        return NO;
    }
}

//- (void)removeData {
//    NSFileManager *fileManager = [[NSFileManager alloc] init];
//    NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:path];
//    NSString *file;
//
//    while (file = [enumerator nextObject]) {
//        NSError *error = nil;
//        BOOL result = [fileManager removeItemAtPath:[path stringByAppendingPathComponent:file] error:&error];
//
//        if (!result && error) {
//            NSLog(@"Error: %@", error);
//        }
//    }
//}

#pragma mark CallAPI

- (void)getInfoFromImages {
    [Utils uploadFiles:arrayParamUploadImage completeBlock:^(NSDictionary *dictData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([dictData[@"error"]  isEqual:@"0000"]) {
                NSDictionary *dictResult = [Utils converDictRemoveNullValue:dictData[@"info"]];
                [self showViewInfo:dictResult];
            }else if ([dictData[@"error"]  isEqual:@"0011"]) {
                NSDictionary *dictResult = [Utils converDictRemoveNullValue:dictData[@"info"]];
                NSString *mes = [NSString stringWithFormat:@"%@\nVui lòng thay ảnh khác?",dictData[@"mes"]];
                [Utils alert:@"Thông báo" content:mes titleOK:@"Nhập tay" titleCancel:@"Thay ảnh" viewController:self completion:^{
                    [self showViewInfo:dictResult];
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

#pragma mark Recive Notification

- (void) reciveNotifi : (NSNotification *)notif {
    if ([notif.name isEqualToString:kNotificationNameSelectProvince]) {
        dictTP = notif.object;
        if (dictTP) {
            self.textFieldPlaceDKDT.text = dictTP[@"pr_name"];
        }
    }
}

@end
