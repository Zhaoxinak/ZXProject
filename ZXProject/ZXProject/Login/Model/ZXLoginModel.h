//
//  ZXLoginModel.h
//  ZXProject
//
//  Created by Mr.X on 2017/1/7.
//  Copyright © 2017年 Mr.X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h> //模型



@interface HobbyCategorysModel : JSONModel

@property (nonatomic, copy) NSString *category_id;
@property (nonatomic, copy) NSString *category_name;

@end


@interface HobbyCarsModel : JSONModel

@property (nonatomic, copy) NSString *car_system_id;
@property (nonatomic, copy) NSString *car_system_name;

@end


@interface UserInfoModel : JSONModel

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *wxId;
@property (nonatomic, copy) NSString *unionid;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userMobile;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, copy) NSString *userTypeString;
@property (nonatomic, copy) NSString *balanceRmb;
@property (nonatomic, copy) NSString *balanceMiao;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *bornDate;
@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *userDesc;
@property (nonatomic, copy) NSString *userSex;
@property (nonatomic, copy) NSString *userSexString;
@property (nonatomic, copy) NSString *isBaseInformation;
@property (nonatomic, copy) NSString *userLevel;
@property (nonatomic, copy) NSString *auditStatus; //认证状态

@property (nonatomic, strong) NSArray<HobbyCategorysModel *>* hobbyCategorys;
@property (nonatomic, strong) NSArray<HobbyCarsModel *>* hobbyCars;

@property (nonatomic, copy) NSString *modifyHobbyIds;
@property (nonatomic, copy) NSString *carSystemIds;
@property (nonatomic, copy) NSString *modifyHobbyNames;
@property (nonatomic, copy) NSString *carSystemNames;
@property (nonatomic, strong) NSMutableArray *hobbyCategorysArr;
@property (nonatomic, strong) NSMutableArray *hobbyCarsArr;


@end


@interface LoginUserModel : JSONModel

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userMobile;
//后来再获取的部分信息
@property (nonatomic, copy) NSString *unionid;
@property (nonatomic, copy) NSString *headimg;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *userSexString;
@property (nonatomic, copy) NSString *userLevel;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, copy) NSString *isBaseInformation;
@property (nonatomic, copy) NSString *auditStatus; //认证状态

@end


#import "CustomTabBarController.h"

@interface ZXLoginModel : JSONModel

@property (copy, nonatomic) NSString *apiStatus;
@property (copy, nonatomic) NSString *apiType;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *messageCode;
@property (copy, nonatomic) NSString *message;
@property (strong, nonatomic) LoginUserModel *loginUser;


- (void)logOutAction;
+ (instancetype)sharedZXLoginModel;

+(void) setTabbar:(CustomTabBarController*) tabbar;

+(CustomTabBarController*) getTabbar;


@end




@interface ZXLogin : NSObject

+(BOOL)loginAlert;

@end




