//
//  OneViewController.m
//  ZXProject
//
//  Created by Mr.X on 2016/11/17.
//  Copyright © 2016年 Mr.X. All rights reserved.
//
#import "TestModel.h" //测试model



/************C************/
#import "OneViewController.h"
/************V************/

/************M************/


@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据
    [self setupDatas];
    //初始试图
    [self setupViews];
}

#pragma mark -执行数据
#pragma mark --初始化数据
-(void)setupDatas{
    
    
    
}

#pragma mark -执行视图
#pragma mark --初始化数据视图
-(void)setupViews{
    
    self.view.backgroundColor = MainGoldColor;
    
}


@end
