//
//  XLAddPictureCell.m
//  Kaxi_Advisor
//
//  Created by mxl on 2017/2/6.
//  Copyright © 2017年 Meloinfo. All rights reserved.
//

#import "XLAddPictureCell.h"
#import <Masonry/Masonry.h>
#import "CommonHeader.h"
@interface XLAddPictureCell (){
    
    UILabel *_titleLabel;
}


@end

@implementation XLAddPictureCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withPictureCount:(NSInteger)count {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubViews:count];
    }
    return self;
}

- (void)configSubViews:(NSInteger)count{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(11*WIDTH_NIT, 0, 200*WIDTH_NIT, ADDPIC_TITLE_HEITH)];
    _titleLabel.font = Font(15);
    _titleLabel.textColor = NameColor;
    [self.contentView addSubview:_titleLabel];
    
    
    CGFloat initHeight = AddPictureCell_Height + 30*WIDTH_NIT;
    
    XLAddPictures *view = [[XLAddPictures alloc] initWithFrame:CGRectMake(0, ADDPIC_TITLE_HEITH, SCREEN_W, initHeight)];
    
    if ([self.reuseIdentifier isEqualToString:checkDelivedReuses]) {
        view.shouldAddPicture = NO;
    } else {
        view.shouldAddPicture = YES;
    }

    view.allowPickingGifSwitch = YES;
    view.allowPickingVideoSwitch = YES;
    view.allowPickingImageSwitch = YES;
    view.allowPickingOriginalPhotoSwitch = YES;
    
    view.allowCropSwitch = NO;
    view.needCircleCropSwitch = NO;
    
    view.showTakePhotoBtnSwitch = YES;
    view.showSheetSwitch = YES;
    view.sortAscendingSwitch = YES;
    view.maxCountTF = count;
    view.columnNumberTF = 4;
    view.isSelectOriginalPhoto = NO;
    [view configSubViews];

    self.addPictureView = view;
    
    [self.contentView addSubview:self.addPictureView];

    WEAK_SELF;
    view.updateLayoutHeight = ^(CGFloat contentHeight) {
        STRONG_SELF;

        [self updateConstraintsIfNeeded];
        if ([self.delegate respondsToSelector:@selector(shouldReloadWithCellHeight:)]) {
            [self.delegate shouldReloadWithCellHeight:contentHeight + ADDPIC_TITLE_HEITH + 30*WIDTH_NIT];
        }
        [self.expandTableView beginUpdates];
        [self.expandTableView endUpdates];
    };
}


-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    
    _titleLabel.text = titleStr;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.bgView.frame = CGRectMake(0, 0, SCREEN_W, self.contentView.height);
    self.addPictureView.frame = CGRectMake(0, ADDPIC_TITLE_HEITH, SCREEN_W, self.contentView.height-ADDPIC_TITLE_HEITH);
}

@end


@implementation UITableView (XLAddPictureCell)

- (XLAddPictureCell *)expandPictureCellWithReuseID:(NSString *)reuseID withPictureCount:(NSInteger)count {
    XLAddPictureCell *cell = [self dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[XLAddPictureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID withPictureCount:count];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.expandTableView = self;
    }
    return cell;
}

@end
