//
//  AppDelegate.m
//  ZXProject
//
//  Created by Mr.X on 2016/11/17.
//  Copyright © 2016年 Mr.X. All rights reserved.
//

#import "AppDelegate.h"
#import "CommonHeader.h"
#import "CustomTabBarController.h"
//微信
static NSString *const WXAppKey = @"";
static NSString *const WXAppSecret = @"";


@interface AppDelegate ()<UIAlertViewDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    /********************************/
    //读取缓存
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kUserLoginInfo];
    ZXLoginModel *loginModel = [ZXLoginModel sharedZXLoginModel];
    loginModel.loginUser = [[LoginUserModel alloc] initWithDictionary:userInfo error:nil];
    /********************************/

    //第一次启动判定
    [self setFirstLaunch];
    
    

    /********************************/
    //友盟配置
    [self setupUMConfig];
    [WXApi registerApp:WXAppKey withDescription:@"wzm_ios"];
    /********************************/
    
    
    
    /********************************/
    // 设置键盘监听管理
//    [self setKeyboardManager];
    /********************************/
    
  
    
    /********************************/
    
    // 设置tabBar
    CustomTabBarController *customTabBar = [CustomTabBarController new];
    self.window.rootViewController = customTabBar;
    /********************************/
   
    
    return YES;
}

#pragma mark -初始化友盟配置
- (void)setupUMConfig {
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@""];
    
    //设置微信的appKey和appSecret      需要管理员微信获取app信息码
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:@""
                                       appSecret:@""
                                     redirectURL:@""];
    //设置分享到QQ互联的appKey和appSecret    还未创建应用
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:@""
                                       appSecret:nil
                                     redirectURL:@""];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina
                                          appKey:@""
                                       appSecret:@""
                                     redirectURL:@""];
    
    
    //友盟统计
    UMConfigInstance.appKey = @"";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    ZXLoginModel *loginModel = [ZXLoginModel sharedZXLoginModel];
    NSString *userId = loginModel.loginUser.userId;
    if (![NSString isEmpty:userId]) {
        NSString *userID = [NSString stringWithFormat:@"userId:%@", userId];
        [MobClick profileSignInWithPUID:userID];
    }
    
   
    
}

#pragma mark -第一次启动
-(void)setFirstLaunch{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //当前版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    if ([defaults objectForKey:@"app_Version"]) {
        if ([defaults objectForKey:@"app_Version"] < app_Version) {
            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"secondLaunch"];
            
            
            [[ZXLoginModel sharedZXLoginModel] logOutAction];
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kUserLoginInfo];
            [defaults setObject:app_Version forKey:@"app_Version"];
        }
    } else {
        [defaults setObject:app_Version forKey:@"app_Version"];
    }

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"open");
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        return result;
    }
#pragma mark --- 微信
    if ([WXApi handleOpenURL:url delegate:self]) {
        return YES;
    }
    
    return YES;
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"open");
    if ([[UMSocialManager defaultManager] handleOpenURL:url]) {
        return YES;
    }
   
#pragma mark --- 微信
    if ([WXApi handleOpenURL:url delegate:self]) {
        return YES;
    }
    
#pragma mark --- 支付宝
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }

    
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
            if (resultDic) {
                
                NSString *resultStatus = [NSString stringWithFormat:@"%@", [resultDic valueForKey:@"resultStatus"]];;
                NSString *message =@"";
                switch ([resultStatus integerValue]) {
                    case 6001:
                        message = @"用户中途取消";
                        break;
                    case 9000:
                        message = @"订单支付成功";
                        [topVC dismissViewControllerAnimated:YES completion:nil];
                        break;
                    case 8000:
                        message = @"正在处理中";
                        break;
                    case 4000:
                        message = @"订单支付失败";
                        break;
                    case 6002:
                        message = @"网络连接出错";
                        break;
                    case 6004:
                        message = @"支付结果未知";
                        break;
                    default:
                        break;
                }
                
                
                [ZXTools alert:topVC message:message];
                
            }

            
            
            
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");

            
            
        }];
 
        return YES;
    }
    

    return NO;
}




// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
    
    
#pragma mark --- 支付宝
    
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    

    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
            if (resultDic) {
                
                NSString *resultStatus = [NSString stringWithFormat:@"%@", [resultDic valueForKey:@"resultStatus"]];;
                NSString *message =@"";
                switch ([resultStatus integerValue]) {
                    case 6001:
                        message = @"用户中途取消";
                        break;
                    case 9000:
                        message = @"订单支付成功";
                        [topVC dismissViewControllerAnimated:YES completion:nil];
                        break;
                    case 8000:
                        message = @"正在处理中";
                        break;
                    case 4000:
                        message = @"订单支付失败";
                        break;
                    case 6002:
                        message = @"网络连接出错";
                        break;
                    case 6004:
                        message = @"支付结果未知";
                        break;
                    default:
                        break;
                }
                
                
                [ZXTools alert:topVC message:message];
                
            }

            
            
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    
#pragma mark --- 微信
    if ([WXApi handleOpenURL:url delegate:self]) {
        return YES;
    }
    
    return YES;
}

#pragma mark --- 微信回调
- (void)onResp:(BaseResp *)resp
{
    NSString * strMsg = [NSString stringWithFormat:@"errorCode: %d",resp.errCode];
    NSLog(@"strMsg: %@",strMsg);
    
    NSString * errStr       = [NSString stringWithFormat:@"errStr: %@",resp.errStr];
    NSLog(@"errStr: %@",errStr);
    
    
    NSString * strTitle;
    //判断是微信消息的回调 --> 是支付回调回来的还是消息回调回来的.
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息的结果"];
    }
    
    NSString * wxPayResult;
    //判断是否是微信支付回调 (注意是PayResp 而不是PayReq)
    
    if ([resp isKindOfClass:[PayResp class]])
    {
        //支付返回的结果, 实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode)
        {
            case WXSuccess:
            {
                strMsg = @"支付结果:";
                NSLog(@"支付成功: %d",resp.errCode);
                wxPayResult = @"success";
                break;
            }
            case WXErrCodeUserCancel:
            {
                strMsg = @"用户取消了支付";
                NSLog(@"用户取消支付: %d",resp.errCode);
                wxPayResult = @"cancel";
                break;
            }
            default:
            {
                strMsg = [NSString stringWithFormat:@"支付失败! code: %d  errorStr: %@",resp.errCode,resp.errStr];
                NSLog(@":支付失败: code: %d str: %@",resp.errCode,resp.errStr);
                wxPayResult = @"faile";
                break;
            }
        }
        //发出通知 从微信回调回来之后,发一个通知,让请求支付的页面接收消息,并且展示出来,或者进行一些自定义的展示或者跳转
        NSNotification * notification = [NSNotification notificationWithName:@"WXPay" object:wxPayResult];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}

@end
