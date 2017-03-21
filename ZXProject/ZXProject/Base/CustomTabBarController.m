//
//  CustomTabBarController.m
//  ZXProject
//
//  Created by Mr.X on 2016/11/17.
//  Copyright © 2016年 Mr.X. All rights reserved.
//

#import "CustomTabBarController.h"
#import "CustomNaviController.h"
#import "CustomTabBar.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "ZXLoginViewController.h" //登录
@interface CustomTabBarController ()<UITabBarControllerDelegate>

@end

@implementation CustomTabBarController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = nil;
    
    if (kiOS9Later) {
        tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    }else{
        tabBarItem = [UITabBarItem appearanceWhenContainedIn:self, nil];
    }

    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = MainWhiteColor;
    dictNormal[NSFontAttributeName] = Font(7);
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = MainGoldColor;
    dictSelected[NSFontAttributeName] = Font(7);
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance] setBarTintColor:MainBlackColor];
    [UITabBar appearance].translucent = NO;
    
    self.delegate = self;
    self.tabBarController.tabBar.delegate = self;
    
    [self setUpChildController];
    
    [ZXLoginModel setTabbar:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  设置子控制器
 */
- (void)setUpChildController {
    
    // 添加子控制器
    [self addChildVC:[[OneViewController alloc] init] titleName:@"首页" imageName:@"shouye-" selectedImageName:@"shouye" tag:0];
    [self addChildVC:[[TwoViewController alloc] init] titleName:@"消息" imageName:@"消息" selectedImageName:@"xiaoxigaoliang" tag:1];
    [self addChildVC:[[ThreeViewController alloc] init] titleName:@"喵圈" imageName:@"miaoquan" selectedImageName:@"喵圈点击状态" tag:2];
    [self addChildVC:[[FourViewController alloc] init] titleName:@"喵窝" imageName:@"miaowo" selectedImageName:@"喵窝点击状态" tag:3];
    
    CustomTabBar *customTabBar = [CustomTabBar new];
    customTabBar.backgroundColor = MainBlackColor;
    customTabBar.alpha = 1;
    
    [self setValue:customTabBar forKey:@"tabBar"];
}

/**
 *  添加一个子控制器
 *
 *  @param childVC       子控制器
 *  @param titleName         标题
 *  @param imageName         图片
 *  @param selectedImageName 选中的图片
 */
- (void)addChildVC:(UIViewController *)childVC titleName:(NSString *)titleName imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName tag:(NSInteger)tag{
    //设置标题
    NSString *title =titleName;
    //设置图标
    UIImage *image = [UIImage imageNamed:imageName];
    //设置选中图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    //声明这张图用原图
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    childVC.title = title;
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = image;
    childVC.tabBarItem.selectedImage = selectedImage;
    childVC.tabBarItem.tag =tag;
    
    //title向上偏移
    [childVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    // 为子控制器包装导航控制器
    CustomNaviController *navigationVC = [[CustomNaviController alloc] initWithRootViewController:childVC];
    // 添加子控制器
    [self addChildViewController:navigationVC];
}

//点击tab 判断

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSLog(@"--tabbaritem.tag--%ld",(long)viewController.tabBarItem.tag);
    
    if (viewController.tabBarItem.tag == 3) {
        
        ZXLoginModel *loginModel = [ZXLoginModel sharedZXLoginModel];
        
        if (!loginModel.loginUser.userId) {
            //登录
            ZXLoginViewController *loginVC = [[ZXLoginViewController alloc] init];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [self presentViewController:navi animated:YES completion:nil];
            return NO;
        }
        
    }
    return YES;

}


@end
