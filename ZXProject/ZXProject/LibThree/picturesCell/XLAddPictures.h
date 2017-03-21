//
//  XLAddPictures.h
//  Kaxi_Advisor
//
//  Created by mxl on 2017/1/20.
//  Copyright © 2017年 Meloinfo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateContentLayoutHeight) (CGFloat contentHeight);
typedef void (^PresentBlock) (UIImagePickerController *pickerVC);

@interface XLAddPictures : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) BOOL isSelectOriginalPhoto;               ///< 允许选择原图
@property (nonatomic, assign) BOOL allowPickingVideoSwitch;             ///< 允许选择视频
@property (nonatomic, assign) BOOL allowPickingGifSwitch;               ///< 允许选择动图
@property (nonatomic, assign) BOOL allowPickingImageSwitch;             ///< 允许选择图片
@property (nonatomic, assign) BOOL allowPickingOriginalPhotoSwitch;     ///< 允许选择原图

@property (nonatomic, assign) BOOL allowCropSwitch;                     ///< 允许裁剪，裁剪不能选择原图
@property (nonatomic, assign) BOOL needCircleCropSwitch;                ///< 圆形裁剪

@property (nonatomic, assign) BOOL showTakePhotoBtnSwitch;              ///< 在内部显示拍照按钮
@property (nonatomic, assign) BOOL showSheetSwitch;                     ///< 显示一个sheet,把拍照按钮放在外面
@property (nonatomic, assign) BOOL sortAscendingSwitch;                 ///< 照片排列按修改时间升序


@property (nonatomic, assign) NSInteger maxCountTF;                     ///< 照片最大可选张数，设置为1即为单选模式
@property (nonatomic, assign) NSInteger columnNumberTF;                 ///< 每行展示的图片数量

@property (nonatomic, copy) PresentBlock presentBlock;
@property (nonatomic, copy) UpdateContentLayoutHeight updateLayoutHeight; ///< 更新约束高度回调

@property (nonatomic, assign) BOOL shouldAddPicture;// 是否显示添加图片按钮 默认YES

@property (nonatomic, strong) NSMutableArray *selectedPhotos; //选择的图片



- (void)configSubViews;

@end
