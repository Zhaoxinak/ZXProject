//
//  NSString+Common.m
//  CardByYou
//
//  Created by qianfeng on 15/12/14.
//  Copyright © 2015年 XuLiangMa. All rights reserved.
//

#import "NSString+Common.h"
#import <CommonCrypto/CommonCrypto.h>
#import <sys/utsname.h>

#define WIDTH_NIT   [[UIScreen mainScreen] bounds].size.width / 375
#define HEIGHT_NIT  [[UIScreen mainScreen] bounds].size.height / 667
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

@implementation NSString (Common)

+ (NSString *)TimeStamp:(NSString *)strTime {
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //用[NSDate date]可以获取系统当前时间
    
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    //输出格式为：2010-10-27 10:22:13
    
    NSLog(@"%@",currentDateStr);
    
    
    return currentDateStr;
}


+ (NSString *)changeJsonStringToTrueJsonString:(NSString *)json
{
    // 将没有双引号的替换成有双引号的
    NSString *validString = [json stringByReplacingOccurrencesOfString:@"(\\w+)\\s*:([^A-Za-z0-9_])"
                                                            withString:@"\"$1\":$2"
                                                               options:NSRegularExpressionSearch
                                                                 range:NSMakeRange(0, [json length])];
    
    
    //把'单引号改为双引号"
    validString = [validString stringByReplacingOccurrencesOfString:@"([:\\[,\\{])'"
                                                         withString:@"$1\""
                                                            options:NSRegularExpressionSearch
                                                              range:NSMakeRange(0, [validString length])];
    validString = [validString stringByReplacingOccurrencesOfString:@"'([:\\],\\}])"
                                                         withString:@"\"$1"
                                                            options:NSRegularExpressionSearch
                                                              range:NSMakeRange(0, [validString length])];
    
    //再重复一次 将没有双引号的替换成有双引号的
    validString = [validString stringByReplacingOccurrencesOfString:@"([:\\[,\\{])(\\w+)\\s*:"
                                                         withString:@"$1\"$2\":"
                                                            options:NSRegularExpressionSearch
                                                              range:NSMakeRange(0, [validString length])];
    return validString;
}

NSString * URLEncodedString(NSString *str) {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[str UTF8String];
    int sourceLen = (int)strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}
// 统一使用这个方法
+ (NSString *)md5HexDigest:(NSString*)input {
    if (input == nil) {
        NSLog(@"----------MD5加密字符串为空----------");
        return @"";
    }
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}
NSString * MD5Hash(NSString *aString) {
    if (aString.length == 0) {
        return nil;
    }
    const char *cStr = [aString UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

- (NSString *)intervalSinceNow: (NSString *) theDate {
    
    
    NSString *copyDate = theDate;
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    
    [date setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1.0;
    
    NSDate* dat = [NSDate date];
    
    NSString *currentDateStr = [date stringFromDate:[NSDate date]];
    
    NSTimeInterval now=[dat timeIntervalSince1970]*1.0;
    
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    /************************判断是否是昨天*************************/
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    currentDateStr = [[currentDateStr componentsSeparatedByString:@" "] objectAtIndex:0];
    theDate = [[theDate componentsSeparatedByString:@" "] objectAtIndex:0];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:currentDateStr];
    dt2 = [df dateFromString:theDate];
    [NSDate  timeIntervalSinceReferenceDate];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {
            //today比otherDay大
        case NSOrderedDescending: {
            NSTimeInterval dayTime = 24*60*60;
            // 将today往前减少一天的时间，判断是否和昨天的时间是否相等，如果相等则表示
            // otherDay为昨天
            NSDate * newDate = [dt1 dateByAddingTimeInterval:-dayTime];
            result = [dt2 compare:newDate];
            if (result == NSOrderedSame) {
                // 表示日期为昨天
                ci = -1;
                timeString = @"昨天";
            } else {
                // 表示日期为昨天以前的时间
                ci = 1;
                timeString = [copyDate substringWithRange:NSMakeRange(5, 5)];
            }
        }
            break;
            //date02=date01,代表日期是今天
        case NSOrderedSame: {
            ci=0;
            timeString = [copyDate substringWithRange:NSMakeRange(11, 5)];
        };
            break;
        default:
            // 默认显示所有的具体的日期时间
            ci = 1;
            timeString = copyDate;
            break;
    }
    
    
    //    if (cha/3600<1) {
    //
    //        if (cha < 0) {
    //            timeString=@"刚刚";
    //        } else {
    //            timeString = [NSString stringWithFormat:@"%f", cha/60];
    //
    //            timeString = [timeString substringToIndex:timeString.length-7];
    //
    //            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    //        }
    //    }
    //    if (cha/3600>1&&cha/86400<1) {
    //
    //        timeString = [NSString stringWithFormat:@"%f", cha/3600];
    //
    //        timeString = [timeString substringToIndex:timeString.length-7];
    //
    //        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    //
    //    }
    //    if (cha/86400>1) {
    //
    //        timeString = [NSString stringWithFormat:@"%f", cha/86400];
    //
    //        timeString = [timeString substringToIndex:timeString.length-7];
    //
    //        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    //    }
    
    return timeString;
}

//- (NSString *) MD5Hash {
//    const char *cStr = [self UTF8String];
//    unsigned char result[16];
//    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
//    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//            result[0], result[1], result[2], result[3],
//            result[4], result[5], result[6], result[7],
//            result[8], result[9], result[10], result[11],
//            result[12], result[13], result[14], result[15]];
//}
- (CGSize)getWidth:(NSString *)str andFont:(UIFont *)font {
    CGSize sz = [str sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
    return sz;
}

/*  计算文本的高
 @param str   需要计算的文本
 @param font  文本显示的字体
 @param maxSize 文本显示的范围，可以理解为limit
 
 @return 文本占用的真实宽高
 */
-(CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}


+ (BOOL)isEmpty:(id)object {
    if(object) {
        if([object isKindOfClass:[NSString class]]) { // 只用于判断NSString
            NSString *temp = [(NSString *)object trim];
            if(![temp isBlank] && ![temp isEqual:[NSNull null]]) { // 字符串不为空
                return NO;
            } else { // 字符串为空
                return YES;
            }
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}

- (BOOL) isBlank
{
    //去掉空白符
    NSString *noBlankChar = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    noBlankChar = [noBlankChar stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    noBlankChar = [noBlankChar stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    noBlankChar = [noBlankChar stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return [noBlankChar isEmpty];
}

- (BOOL) isEmpty
{
    return self.length < 1;
}

- (NSString*) trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length == 11)
    {
        
        /**
         * 手机号码:
         * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
         * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
         * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
         * 电信号段: 133,149,153,170,173,177,180,181,189
         */
        NSString *MOBILE = @"^1(3[0-9]|4[3457]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
        /**
         * 中国移动：China Mobile
         * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
         */
        NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
        /**
         * 中国联通：China Unicom
         * 130,131,132,145,155,156,170,171,175,176,185,186
         */
        NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
        /**
         * 中国电信：China Telecom
         * 133,149,153,170,173,177,180,181,189
         */
        NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
        /**
         * 大陆地区固话及小灵通
         * 区号：010,020,021,022,023,024,025,027,028,029
         * 号码：七位或八位
         */
        NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
        
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
        
        
        if (([regextestmobile evaluateWithObject:mobile] == YES)
            || ([regextestcm evaluateWithObject:mobile] == YES)
            || ([regextestct evaluateWithObject:mobile] == YES)
            || ([regextestcu evaluateWithObject:mobile] == YES)
            || ([regextestphs evaluateWithObject:mobile] == YES))
        {
            return YES;
        }
        else
        {
            return NO;
        }
        
        
    }else
        
        if (mobile.length == 12){
            /**
             * 大陆地区固话及小灵通
             * 区号：010,020,021,022,023,024,025,027,028,029
             * 号码：七位或八位
             */
            NSString * PHS = @"^0(10|2[0-5789]|\\d{3,4})\\d{7,8}$";
            
            NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
            
            if ([regextestphs evaluateWithObject:mobile] == YES) {
                return YES;
            }else{
                return NO;
            }
        }
        else
            
            if (mobile.length == 10) {
                
                /**
                 * 400
                 */
                NSString * SPL = @"^400[0-9]{7}";
                NSPredicate *regextestspl = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", SPL];
                
                if ([regextestspl evaluateWithObject:mobile] == YES) {
                    return YES;
                }else{
                    return NO;
                }
                
            }
    
        else{
            
            return NO;
        }
}


+ (NSAttributedString *)strToAttriWithStr:(NSString *)htmlStr{
    
    //对图片大小进行处理，适应屏幕宽度
    htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"<img" withString:[NSString stringWithFormat:@"<img width=\"%f\"", kScreen_Width-20*WIDTH_NIT]];
    
    
    NSString *newString = [NSString stringWithFormat:
                           @"<html>"
                           "<body>"
                           "<table width=\"%f\">"
                           "<tr>"
                           "<td>"
                           "<font size=\"%f\">"
                           "%@"
                           "</font>"
                           "</td>"
                           "</tr>"
                           "</table>"
                           "</body>"
                           "</html>", kScreen_Width-20*WIDTH_NIT, 5*WIDTH_NIT, htmlStr];
    
    
    

    return [[NSAttributedString alloc] initWithData:[newString dataUsingEncoding:NSUnicodeStringEncoding]
                                            options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                 documentAttributes:nil
                                              error:nil];
}

#pragma mark --- 转化成html
+ (NSString *)htmlStringByHtmlAttributeString:(NSAttributedString *)htmlAttributeString{
    NSString *htmlString;
    NSDictionary *exportParams = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]
                                   };
    
    NSData *htmlData = [htmlAttributeString dataFromRange:NSMakeRange(0, htmlAttributeString.length) documentAttributes:exportParams error:nil];
    
    htmlString = [[NSString alloc] initWithData:htmlData encoding: NSUTF8StringEncoding];
    return htmlString;
}

// 自适应尺寸大小
+ (NSString *)autoWebAutoImageSize:(NSString *)html{
    
    NSString * regExpStr = @"<img\\s+.*?\\s+(style\\s*=\\s*.+?\")";
    NSRegularExpression *regex=[NSRegularExpression regularExpressionWithPattern:regExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *matches=[regex matchesInString:html
                                    options:0
                                      range:NSMakeRange(0, [html length])];
    
    
    NSMutableArray * mutArray = [NSMutableArray array];
    for (NSTextCheckingResult *match in matches) {
        NSString* group1 = [html substringWithRange:[match rangeAtIndex:1]];
        [mutArray addObject: group1];
    }
    
    NSUInteger len = [mutArray count];
    for (int i = 0; i < len; ++ i) {
        html = [html stringByReplacingOccurrencesOfString:mutArray[i] withString: @"style=\"width:90%; height:auto;\""];
    }
    
    return html;
}

+ (NSMutableString *)webImageFitToDeviceSize:(NSMutableString *)strContent
{
    [strContent appendString:@"<html>"];
    [strContent appendString:@"<head>"];
    [strContent appendString:@"<meta charset=\"utf-8\">"];
    [strContent appendString:@"<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width*0.9,initial-scale=1.0,maximum-scale=1.0,user-scalable=false\" />"];
    [strContent appendString:@"<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />"];
    [strContent appendString:@"<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />"];
    [strContent appendString:@"<meta name=\"black\" name=\"apple-mobile-web-app-status-bar-style\" />"];
    [strContent appendString:@"<style>img{width:100%;}</style>"];
    [strContent appendString:@"<style>table{width:100%;}</style>"];
    [strContent appendString:@"<title>webview</title>"];
    return strContent;
}

+ (NSArray *) getImageurlFromHtml:(NSString *) webString
{
    
    NSMutableArray * imageurlArray = [NSMutableArray arrayWithCapacity:1];
    
    if ([NSString isEmpty:webString]) {
        return imageurlArray;
    }
    
    //标签匹配
    NSString *parten = @"<img(.*?)>";
    NSError* error = NULL;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:0 error:&error];
    
    NSArray* match = [reg matchesInString:webString options:0 range:NSMakeRange(0, [webString length] - 1)];
    
    for (NSTextCheckingResult * result in match) {
        
        //过去数组中的标签
        NSRange range = [result range];
        NSString * subString = [webString substringWithRange:range];
        
        
        //从图片中的标签中提取ImageURL
        NSRegularExpression *subReg = [NSRegularExpression regularExpressionWithPattern:@"http://(.*?)'" options:0 error:NULL];
        NSArray* match = [subReg matchesInString:subString options:0 range:NSMakeRange(0, [subString length] - 1)];
        NSTextCheckingResult * subRes = match[0];
        NSRange subRange = [subRes range];
        subRange.length = subRange.length -1;
        NSString * imagekUrl = [subString substringWithRange:subRange];
        
        //将提取出的图片URL添加到图片数组中
        [imageurlArray addObject:imagekUrl];
    }
    
    return imageurlArray;
}

+ (NSString*)deviceModelName

{
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    
    
    //iPhone 系列
    
    if ([deviceModel isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    
    if ([deviceModel isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    
    if ([deviceModel isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    if ([deviceModel isEqualToString:@"iPhone8,3"])    return @"iPhone SE";
    
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7 (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7 (GSM)";
    
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus (GSM)";
    
    
    
    //iPod 系列
    
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    
    
    //iPad 系列
    
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    
    
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    
    
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air";
    
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air";
    
    if ([deviceModel isEqualToString:@"iPad4,3"])      return @"iPad Air";
    
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    
    
    if ([deviceModel isEqualToString:@"iPad4,4"]
        
        ||[deviceModel isEqualToString:@"iPad4,5"]
        
        ||[deviceModel isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    
    
    if ([deviceModel isEqualToString:@"iPad4,7"]
        
        ||[deviceModel isEqualToString:@"iPad4,8"]
        
        ||[deviceModel isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    
    
    return deviceModel;
    
}





@end
