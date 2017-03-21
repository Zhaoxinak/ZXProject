//
//  XLAddPictureCell.h
//  Kaxi_Advisor
//
//  Created by mxl on 2017/2/6.
//  Copyright © 2017年 Meloinfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLAddPictures.h"

static NSString *const checkDelivedReuses = @"checkDelivedImages";// 当标示等于这个的时候，不显示添加图片按钮

@protocol XLUpdateCellHeightDelegate <NSObject>

- (void)shouldReloadWithCellHeight:(CGFloat)cellHeight;

@end

@interface XLAddPictureCell : UITableViewCell

@property (nonatomic, weak) UITableView *expandTableView;

@property (nonatomic, assign) id<XLUpdateCellHeightDelegate> delegate;

@property (nonatomic, strong) XLAddPictures *addPictureView;

@property (nonatomic, copy) NSString *titleStr;

@end


@interface UITableView (XLAddPictureCell)

- (XLAddPictureCell *)expandPictureCellWithReuseID:(NSString *)reuseID withPictureCount:(NSInteger)count;

@end
