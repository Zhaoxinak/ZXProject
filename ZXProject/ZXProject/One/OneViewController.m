//
//  OneViewController.m
//  ZXProject
//
//  Created by Mr.X on 2016/11/17.
//  Copyright © 2016年 Mr.X. All rights reserved.
//

#import "OneViewController.h"
#import "TestModel.h"


@interface OneViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NetworkHelper dataWithDiscover:YES completion:^(BOOL finish, id  _Nullable responseObject) {
        if (finish) {
            TestModel *model = [[TestModel alloc] initWithData:responseObject error:nil];
            
            if ([model.code isEqualToString:@"1"]) {
                self.dataArray = [model.data.projects copy];
                NSLog(@"%@", self.dataArray);
            }else{
                NSString *msg = model.msg;
                [NetworkHelper showServerMsg:msg];
                
            }
          
            //完成
        }else{
            
            
        }
    }];
    
    //在需要使用的界面设置
    IQKeyboardReturnKeyHandler *retuenKeyHandler = [[IQKeyboardReturnKeyHandler alloc]initWithViewController:self];
    retuenKeyHandler.lastTextFieldReturnKeyType =UIReturnKeyDone; // 设置最后一个输入框
    
    
    UITextField *textField = [UITextField new];
    textField.delegate = self;
    textField.frame = CGRectMake(10, 400, kScreen_Width-20, 30);
    textField.backgroundColor = [UIColor whiteColor];
    textField.tag = 1;
    [self.view addSubview:textField];
    
    
    UITextField *textField1 = [UITextField new];
    textField1.delegate = self;
    textField1.frame = CGRectMake(10, 440, kScreen_Width-20, 30);
    textField1.backgroundColor = [UIColor whiteColor];
    textField1.tag = 2;
    [self.view addSubview:textField1];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
