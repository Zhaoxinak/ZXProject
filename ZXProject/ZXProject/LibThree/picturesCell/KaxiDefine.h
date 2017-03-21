//
//  KaxiDefine.h
//  KaxiFinance
//
//  Created by mxl on 2016/12/19.
//  Copyright © 2016年 Meloinfo. All rights reserved.
//

#ifndef KaxiDefine_h
#define KaxiDefine_h


// 本地跳转
static NSString *const locUrl = @"Kaxi://www.meloinfo.com/";
// 远程跳转
static NSString *const netUrl = @"https://www.meloinfo.com/";

#define XL_COMMON_HANDLER       [XLCommonHandler new]
#define TO_LOGIN                [NSString stringWithFormat:@"%@%@", locUrl, @"login"]
#define TO_REGIS                [NSString stringWithFormat:@"%@%@", locUrl, @"regist"]
#define TO_SCAN_QCODE           [NSString stringWithFormat:@"%@%@", locUrl, @"scanQCode"]


#define THEM_COLOR  [UIColor colorWithHexString:@"#FE6000"]
// tabBarItem
#define KColor_BarSelTitle          [UIColor blackColor]
#define KColor_BarUnSelTitle        [UIColor colorWithHexString:@"0x76808E"]
#define KFont_BarSelTitle           [UIFont systemFontOfSize:10]
#define KFont_BarUnSelTitle         [UIFont systemFontOfSize:10]
#define  kBadgeTipStr @"badgeTip"

#define kLeftPadding 14.0

// loginPage
#define kLoginPaddingLeftWidth 14
#define kLeftPaddingWidth 12.5
#define kLinePadding 0.5

#define AddPictureCell_Height (SCREEN_W - 2 * 15*WIDTH_NIT - 4) / 3 - 15*WIDTH_NIT
#define ADDPIC_TITLE_HEITH 46

#define XLRouter ((AppDelegate *)[UIApplication sharedApplication].delegate).router

#define LIGHT_FONT(font) [UIFont systemFontOfSize:(font) weight:UIFontWeightLight]
/**
 *  常规字体
 */
//#define NORML_Calum_FONT(font) ({if(iOS9Later){ [UIFont fontWithName:@"PingFangSC-Regular" size:font];} [UIFont systemFontOfSize:(font)];})

#define NORML_FONT(font) [UIFont systemFontOfSize:(font) weight:UIFontWeightRegular]
/**
 *  加粗字体
 */
#define JIACU_FONT(font) [UIFont boldSystemFontOfSize:(font)]

#define MEDIUM_FONT(font) [UIFont systemFontOfSize:(font) weight:UIFontWeightMedium]

/**
 *  运行时间
 */
#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

// RGB颜色
#define RGBColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
// HexString颜色
#define HexStringColor(hex) [UIColor colorWithHexString:(hex)]

/**
 *  weak strong self for retain cycle
 */
#define WEAK_SELF __weak typeof(self) weakSelf = self
#define STRONG_SELF __strong typeof(weakSelf) self = weakSelf
/**
 *  屏幕宽高
 */
#define SCREEN_W    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_H    [[UIScreen mainScreen] bounds].size.height
#define WIDTH_NIT   [[UIScreen mainScreen] bounds].size.width / 375
#define HEIGHT_NIT  [[UIScreen mainScreen] bounds].size.height / 667

#define Control_Btn_Width 75
#define Control_Btn_Height 27

#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kScreen_Bounds [UIScreen mainScreen].bounds

#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)

//链接颜色
#define kLinkAttributes     @{(__bridge NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:YES],(NSString *)kCTForegroundColorAttributeName : (__bridge id)[UIColor colorWithHexString:@"#333333"].CGColor}
#define kLinkAttributesActive       @{(NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:YES],(NSString *)kCTForegroundColorAttributeName : (__bridge id)[[UIColor colorWithHexString:@"#333333"] CGColor]}

#define kDevice_Is_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPad ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPad3 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) : NO)

#define DebugLog(s, ...) NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])

/**
 *  单例
 */
#define XLSingletonM(name) \
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

#import "AppDelegate.h"
#endif /* KaxiDefine_h */
