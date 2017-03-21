//
//  ZXLoginModel.m
//  ZXProject
//
//  Created by Mr.X on 2017/1/7.
//  Copyright © 2017年 Mr.X. All rights reserved.
//

#import "ZXLoginModel.h"
#import "CommonHeader.h"
#import "ZXLoginViewController.h"

@implementation HobbyCategorysModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end


@implementation HobbyCarsModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end


@implementation UserInfoModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}


- (NSString *) modifyHobbyNames {
    
//    _userHobbyCategorys = [UserHobbyCategorysModel arrayOfDictionariesFromModels:_userHobbyCategorys];
    
    NSArray *tempArr = [HobbyCategorysModel arrayOfModelsFromDictionaries:_hobbyCategorys error:nil];
    
    NSMutableArray *hobbyArr = [NSMutableArray array];
    
    
    
    for (int i = 0; i < tempArr.count; i++) {
        HobbyCategorysModel *tempModel = tempArr[i] ;
        [hobbyArr addObject:tempModel.category_name];
    }
    
    NSString *hobbyString;
    if (hobbyArr.count >0) {
        hobbyString = [hobbyArr componentsJoinedByString:@","];
    }
 
    return hobbyString;
}

-(NSString *)carSystemNames{
    
    NSArray *tempArr = [HobbyCarsModel arrayOfModelsFromDictionaries:_hobbyCars error:nil];
    
    NSMutableArray *carSystemArr = [NSMutableArray array];
    
    for (int i = 0; i < tempArr.count; i++) {
        HobbyCarsModel *tempModel = tempArr[i];
        [carSystemArr addObject:tempModel.car_system_name];
    }
    
    NSString *carSystemString;
    if (carSystemArr.count >0) {
        carSystemString = [carSystemArr componentsJoinedByString:@","];
    }
    
    return carSystemString;
    
}


@end



@implementation LoginUserModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

static CustomTabBarController* tabBar=nil;

@implementation ZXLoginModel

+(void) setTabbar:(CustomTabBarController *)tabbar{
    tabBar=tabbar;
}

+(CustomTabBarController*) getTabbar{
    return tabBar;
}


+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

ZXSingletonM(ZXLoginModel)


- (void)logOutAction {
    _apiStatus = nil;
    _apiType = nil;
    _time = nil;
    _messageCode = nil;
    _message = nil;
    _loginUser = nil;
    
}


@end

@implementation ZXLogin

+(BOOL)loginAlert{
    
    if ([ZXLoginModel sharedZXLoginModel].loginUser.userId) {
        return NO;
    }
    
    
    NSString *title = NSLocalizedString(@"您没有登录", nil);
    NSString *message = NSLocalizedString(@"", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"继续浏览", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"去登录", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"返回");
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
        
        //跳到登录页面
        //登录
        ZXLoginViewController *loginVC = [[ZXLoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[ZXTools getCurrentVC] presentViewController:nav animated:YES completion:nil];
        });
    
        
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ZXTools getCurrentVC] presentViewController:alertController animated:YES completion:nil];
    });

    return YES;
}
@end
