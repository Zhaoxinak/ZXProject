//
//  BaseTableViewController.m
//  ZXProject
//
//  Created by Mr.X on 2016/11/30.
//  Copyright © 2016年 Mr.X. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, getter=isLoading) BOOL loading;

@end

@implementation BaseTableViewController

#pragma mark -设置loading
- (void)setLoading:(BOOL)loading
{
    if (self.isLoading == loading) {
        return;
    }
    
    _loading = loading;
    
    [self.tableView reloadEmptyDataSet];
}


#pragma mark -设置tableView
- (ZXTableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[ZXTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.separatorStyle = NO;
        _tableView.backgroundColor = BGColor;
        _tableView.scrollEnabled =YES;
        
    }
    return _tableView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BGColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -空数据的时候tableView的显示
#pragma mark - DZNEmptyDataSetSource Methods
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.isLoading) {
        return [UIImage imageNamed:@"loading_imgBlue_78x78"];
    }
    else {
        
        return [UIImage imageNamed:@""];
    }
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"Please Allow Photo Access";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"This allows you to share photos from your library and save photos to your camera roll.";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
    
    return [[NSAttributedString alloc] initWithString:@"Continue" attributes:attributes];
}

//- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
//{
//    return [UIImage imageNamed:@"button_image"];
//}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -64.0;
}

#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return self.isLoading;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    self.loading = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.loading = NO;
    });
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    self.loading = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.loading = NO;
    });
}


@end
