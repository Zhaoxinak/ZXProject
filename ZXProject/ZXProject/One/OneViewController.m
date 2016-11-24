//
//  OneViewController.m
//  ZXProject
//
//  Created by Mr.X on 2016/11/17.
//  Copyright © 2016年 Mr.X. All rights reserved.
//

#import "OneViewController.h"
#import "AFNetworking.h"
#import "TestModel.h"

@interface OneViewController ()

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
