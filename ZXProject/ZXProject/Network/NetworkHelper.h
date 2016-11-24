//
//  NetworkHelper.h
//  InterfaceHelper
//
//  Created by Wu Hengmin on 16/3/23.
//  Copyright © 2016年 Wu Hengmin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommonHeader.h"


@interface NetworkHelper : NSObject


/**
 *  <#Description#>
 *
 *  @param progress   <#progress description#>
 *  @param completion <#completion description#>
 */
+ (void)dataWithDiscover:(BOOL)progress  completion:(void (^ _Nonnull)(BOOL finish, id  _Nullable responseObject))completion;







#pragma mark请求不成功后的处理
+(void)showServerMsg:(NSString *_Nonnull)msg;
@end
