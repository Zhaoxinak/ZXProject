//
//  CommonHeader.h
//  ZXProject
//
//  Created by Mr.X on 2016/11/17.
//  Copyright © 2016年 Mr.X. All rights reserved.
//

#ifndef CommonHeader_h
#define CommonHeader_h

/********************系统工具引用*********************/
#import <Foundation/Foundation.h> //框架
#import <UIKit/UIKit.h> //UI
#import <MessageUI/MessageUI.h> //短信
/********************自己工具引用*********************/
#import "GlobalURL.h" //网络地址
#import "NSString+Common.h" //字符串处理
#import "NSDate+CH.h"   //日期
#import "UIButton+Response.h" //按钮点击间隔
#import "UIButton+Extension.h" //按钮扩展
#import "UIResponder+FirstResponder.h"  //第一响应
#import "UIView+Frame.h" 
#import "UIColor+expanded.h" //颜色
#import "UIView+Common.h" //坐标
#import "ZXTools.h"  //赵昕的工具
#import "NetworkHelper.h" //网络请求
#import "UILabel+Common.h" //输入框

#import "TZImagePickerController.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "TZPhotoPreviewController.h"
#import "TZGifPhotoPreviewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
/********************第三方引用*********************/
#import <AFNetworking.h> //网络请求
#import <JSONModel.h> //模型
#import <MBProgressHUD.h> //提示框
#import <MJRefresh.h> //刷新
#import <SDCycleScrollView.h> //轮播器
#import <UIImageView+WebCache.h>//sdWebImage
#import <TOWebViewController.h> // 跳转webView
#import <QBImagePickerController.h> //添加图片
#import <TPKeyboardAvoidingScrollView.h> //键盘弹出
#import <TPKeyboardAvoidingTableView.h> //键盘弹出
#import <UIScrollView+EmptyDataSet.h> //tableView为空时数据为空
#import <UMSocialCore/UMSocialCore.h> //友盟分享
#import <UMMobClick/MobClick.h> //友盟分析
#import <YYKit.h> //yykit
#import <Masonry.h> //自动布局
#import <AlipaySDK/AlipaySDK.h> //支付宝
/********************分享*********************/
#import <WXApi.h> //微信
#import "ZXShareHelper.h" //分享
#import "ZXShareViewCell.h" //分享cell
#import "ZXShareModel.h"  //分享model

/********************通用*********************/
#import "ZXLoginModel.h" //登录信息

/**
 *  图片
 */
#define AddPictureCell_Height (SCREEN_W - 2 * 15*WIDTH_NIT - 4) / 3 - 15*WIDTH_NIT
#define ADDPIC_TITLE_HEITH 46

/**
 *  屏幕宽高比例（以6为基准）
 */
#define WIDTH_NIT   [[UIScreen mainScreen] bounds].size.width / 375
#define HEIGHT_NIT  [[UIScreen mainScreen] bounds].size.height / 667

/**
 *	RGB颜色
 */
 
#define RGBColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

/**
 *	HexString颜色
 */
#define HexStringColor(hex, a) [UIColor colorWithHexString:(hex) andAlpha:(a)]

/**
 *  获取当前设备
 */

#define SCREEN_W    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_H    [[UIScreen mainScreen] bounds].size.height

#define kScreen_Height [UIScreen mainScreen].bounds.size.height

#define kScreen_Width [UIScreen mainScreen].bounds.size.width

#define kScreen_StatusBarHeight 20

#define kScreen_NavHeight 64

#define kScreen_tabBarHeight 49

#define kKeyWindow [UIApplication sharedApplication].keyWindow

#define kScreen_Bounds [UIScreen mainScreen].bounds

#define kDevice_Is_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPad ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPad3 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) : NO)


/**
 *  weak strong self for retain cycle
 */
#define WEAK_SELF __weak typeof(self) weakSelf = self
#define STRONG_SELF __strong typeof(weakSelf) self = weakSelf


/**
 *  单例
 */
#define ZXSingletonM(name) \
static id _instance = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}

/**
 *  运行时间
 */
#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

/**
 *  重要颜色
 */

#define MainGoldColor          HexStringColor(@"#cba162", 1)  //#cba162
#define MainBlackColor         HexStringColor(@"#000000", 1)  //#000000
#define MainWhiteColor         HexStringColor(@"#ffffff", 1)  //#ffffff

#define NameColor              HexStringColor(@"#1f2021", 1)  //#1f2021
#define SubNameColor           HexStringColor(@"#222222", 1)  //#222222
#define LessNameColor          HexStringColor(@"#585858", 1)  //#585858
#define LightNameColor         HexStringColor(@"#777777", 1)  //#777777
#define LittleNameColor        HexStringColor(@"#7e7e7e", 1)  //#7e7e7e

#define BGColor                RGBColor(241, 241, 241, 1)
#define KNavigationBGColor     RGBColor(0, 0, 0, 1)
#define KNavigationTitleColor  RGBColor(255, 255, 255, 1)



#define OneColor           RGBColor(40, 205, 251, 1)
#define TwoColor           RGBColor(40, 205, 251, 1)
#define ThreeColor         RGBColor(40, 205, 251, 1)


#define OneTextColor           HexStringColor(@"#000000", 1)  //#000000
#define TwoTextColor           HexStringColor(@"#222222", 1)  //#222222
#define ThreeTextColor         HexStringColor(@"#1f2021", 1)  //#1f2021
#define FourTextColor          HexStringColor(@"#cba162", 1)  //#cba162
#define FiveTextColor          HexStringColor(@"#777777", 1)  //#777777

#define BGButtonColor          RGBColor(241, 241, 241, 1)
/**
 *  nav字体大小
 */
#define KNavigationFont [UIFont systemFontOfSize:22*WIDTH_NIT]
/**
 *  nav字体大小
 */

#define Font(size)   [UIFont systemFontOfSize:(size+2)*WIDTH_NIT]


/**
 *  提示
 */
#define ALERTTK(__T__, __M__) UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:(__T__) message:(__M__) delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];[alertView show];
#define ALERTTM(__T__, __M__) UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:(__T__) message:(__M__) delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];[alertView show];



//用户登录数据
static NSString  *kUserLoginInfo            = @"kUserLoginInfo";
//评论通知
static NSString  *AddCommentSuccessNotification = @"AddCommentSuccessNotification";

#endif /* CommonHeader_h */
