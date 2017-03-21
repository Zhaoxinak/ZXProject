//
//  ZXRegisterViewController.m
//  ZXProject
//
//  Created by Mr.X on 2017/1/4.
//  Copyright © 2017年 Mr.X. All rights reserved.
//



/************C************/
#import "ZXRegisterViewController.h"
/************V************/
#import "ZXLoginTextField.h"
/************M************/
#import "ZXRegisterModel.h"

@interface ZXRegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) ZXRegisterModel *registerModel;

@end

@implementation ZXRegisterViewController
{
    ZXLoginTextField *phoneView;
    ZXLoginTextField *verifyView;
    ZXLoginTextField *setPwView;
    ZXLoginTextField *confirmPwView;
    ZXLoginTextField *nicknameView;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [phoneView.inputTextField resignFirstResponder];
    [verifyView.inputTextField resignFirstResponder];
    [setPwView.inputTextField resignFirstResponder];
//    [confirmPwView.inputTextField resignFirstResponder];
    [nicknameView.inputTextField resignFirstResponder];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _registerType == Register ? @"注册" : @"忘记密码";
    self.view.backgroundColor = MainWhiteColor;
    [self setupView];
    
    _registerModel = [[ZXRegisterModel alloc] init];
}

- (void)setupView {

    //返回按钮
    UIButton* backActBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backActBtn.frame = CGRectMake(0, 0, 28, 42);
    [backActBtn setImage:@"返回"];
    [backActBtn addTarget:self action:@selector(backAct)];
    UIBarButtonItem* leftButton = [[UIBarButtonItem alloc] initWithCustomView:backActBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    phoneView = [[ZXLoginTextField alloc] initWithType:NormalType];
    phoneView.frame = CGRectMake(15*WIDTH_NIT, 20*WIDTH_NIT, kScreenWidth-30*WIDTH_NIT, 46*WIDTH_NIT);
    phoneView.leftLabel.text = @"  手机号码";
    phoneView.inputTextField.delegate = self;
    phoneView.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneView];
 
    verifyView = [[ZXLoginTextField alloc] initWithType:SmsType];
    verifyView.frame = CGRectMake(15*WIDTH_NIT, phoneView.bottom, kScreenWidth-30*WIDTH_NIT, 46*WIDTH_NIT);
    verifyView.leftLabel.text = @"  验证码";
    verifyView.inputTextField.delegate = self;
    [verifyView.smsCodeBtn addTarget:self action:@selector(verifyAction)];
    verifyView.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:verifyView];
  
    
    setPwView = [[ZXLoginTextField alloc] initWithType:PwdType];
    setPwView.frame = CGRectMake(15*WIDTH_NIT, verifyView.bottom, kScreenWidth-30*WIDTH_NIT, 46*WIDTH_NIT);
    setPwView.leftLabel.text = @"  密码";
    setPwView.inputTextField.secureTextEntry = YES;
    setPwView.inputTextField.delegate = self;
    [self.view addSubview:setPwView];
  
    
    confirmPwView = [[ZXLoginTextField alloc] initWithType:PwdType];
    NSInteger confirmPwViewHeight = _registerType == Register ?  0 : 46*WIDTH_NIT;
    confirmPwView.hidden = _registerType == Register;
    confirmPwView.frame = CGRectMake(15*WIDTH_NIT, setPwView.bottom, kScreenWidth-30*WIDTH_NIT, confirmPwViewHeight);
    confirmPwView.leftLabel.text = @"  确认密码：";
    confirmPwView.inputTextField.secureTextEntry = YES;
    confirmPwView.inputTextField.delegate = self;
    [self.view addSubview:confirmPwView];
  
    
    nicknameView = [[ZXLoginTextField alloc] initWithType:NormalType];
    NSInteger inviteViewHeight = _registerType == Register ? 46*WIDTH_NIT : 0;
    nicknameView.hidden = _registerType == ForgetPassWord;
    nicknameView.frame = CGRectMake(15*WIDTH_NIT, setPwView.bottom, kScreenWidth-30*WIDTH_NIT, inviteViewHeight);
    nicknameView.leftLabel.text = @"  昵称";
    nicknameView.inputTextField.delegate = self;
    [self.view addSubview:nicknameView];
    
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSInteger sureBtnY = _registerType == Register ? nicknameView.bottom+35*WIDTH_NIT : confirmPwView.bottom+35*WIDTH_NIT;
    
    sureBtn.frame = CGRectMake(15*WIDTH_NIT, sureBtnY, kScreenWidth-30*WIDTH_NIT, 44*WIDTH_NIT);
    
    NSString *sureTitle = _registerType == Register ? @"完成注册" : @"确认";
    [sureBtn setTitle:sureTitle forState:UIControlStateNormal];
    [sureBtn setTitleColor:MainWhiteColor];
    [sureBtn setBackgroundColor:MainGoldColor];
    sureBtn.titleLabel.font = Font(18);
    sureBtn.layer.cornerRadius = 4.0;
    sureBtn.layer.masksToBounds = YES;
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
 

    if (_registerType == Register) {
        
        NSString *titleName = @"点击【完成注册】代表我已阅读并同意《五爪猫用户协议》";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleName];
        [str addAttribute:NSForegroundColorAttributeName value:NameColor range:NSMakeRange(0,titleName.length)];
        
        
        //协议
        UIButton* protocolBtn = [[UIButton alloc]init];
        protocolBtn.frame = CGRectMake(15*WIDTH_NIT, sureBtn.bottom, kScreenWidth-30*WIDTH_NIT, 46*WIDTH_NIT);
        protocolBtn.titleLabel.numberOfLines = 1;
        protocolBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        protocolBtn.titleLabel.font = Font(11);
        [protocolBtn setAttributedTitle:str forState:UIControlStateNormal];
        [protocolBtn setTitleColor:NameColor forState:UIControlStateNormal];
        [protocolBtn setBackgroundColor:[UIColor clearColor]];
        [protocolBtn addTarget:self action:@selector(protocolAct)];
        [self.view addSubview:protocolBtn];
    
        
        //已有账户，立即登录
        UIButton* havedUserBtn = [[UIButton alloc]init];
        havedUserBtn.frame = CGRectMake(15*WIDTH_NIT, protocolBtn.bottom + 210*WIDTH_NIT, kScreenWidth-30*WIDTH_NIT, 46*WIDTH_NIT);
        havedUserBtn.titleLabel.numberOfLines = 1;
        havedUserBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        havedUserBtn.titleLabel.font = Font(11);
        [havedUserBtn setTitle:@"已有账户？立即登录" forState:UIControlStateNormal];
        [havedUserBtn setTitleColor:NameColor forState:UIControlStateNormal];
        [havedUserBtn setBackgroundColor:[UIColor clearColor]];
        [havedUserBtn addTarget:self action:@selector(havedUserAct)];
        [self.view addSubview:havedUserBtn];
        
    }
}


#pragma  mark --- 用户协议
-(void)protocolAct{
    
    NSLog(@"用户协议");
//    //用户协议
//    PLXieYiViewController *webView1 = [PLXieYiViewController new];
//    webView1.title = @"用户协议";
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"用户协议-纯真生活网1.0" ofType:@"doc"];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    webView1.requestUrl = url;
//    [self.navigationController pushViewController:webView1 animated:YES];
    
}

#pragma  mark --- 已有账户，立即登录
-(void)havedUserAct{
    
    NSLog(@"已有账户，立即登录");
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == phoneView.inputTextField) {
        _registerModel.userMobile = textField.text;
    } else if (textField == verifyView.inputTextField) {
        _registerModel.verifyCode = textField.text;
    } else if (textField == setPwView.inputTextField) {
        _registerModel.userPwd = textField.text;
    } else if (textField == nicknameView.inputTextField) {
        _registerModel.nickname = textField.text;
    }
}

- (void)sureAction {
    [phoneView.inputTextField resignFirstResponder];
    [verifyView.inputTextField resignFirstResponder];
    [setPwView.inputTextField resignFirstResponder];
    [confirmPwView.inputTextField resignFirstResponder];
    [nicknameView.inputTextField resignFirstResponder];
    //    [self verifyInputText];
    
    //post字典
    NSDictionary *dic = [NSDictionary dictionary];
    
    //判断手机
    if (![NSString valiMobile:_registerModel.userMobile]) {
        [ZXTools makeTask:@"手机号不正确"];
        return;
    }
    //判断验证码
    if ([NSString isEmpty:_registerModel.verifyCode]) {
        [ZXTools makeTask:@"验证码不能为空"];
        return;
    }
    
    //判断密码
    if ([NSString isEmpty:_registerModel.userPwd]) {
        [ZXTools makeTask:@"密码不能为空"];
        return;
    }
    
    //注册的时候
    if (_registerType == Register) {
    
        if ([NSString isEmpty:_registerModel.nickname]) {
            
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
            NSString* phoneModel = [NSString deviceModelName];
            NSDictionary *deviceInfo = @{@"model" : phoneModel,
                                         @"system" : phoneVersion,
                                         @"app" : app_Version};
            NSString *deviceInfoJson = [deviceInfo modelToJSONString];
            
            
            dic = @{@"userMobile" : _registerModel.userMobile,
                    @"verifyCode" : _registerModel.verifyCode,
                    @"userPwd" : _registerModel.userPwd,
                    @"deviceInfo" : deviceInfoJson};
            
            [self sendRequestId:ZXInterfaceRegister rMethod:POSTMethod params:dic];
            
            
        } else {
            dic = @{@"userMobile" : _registerModel.userMobile, @"verifyCode" : _registerModel.verifyCode, @"userPwd" : _registerModel.userPwd, @"nickname" : _registerModel.nickname};
            [self sendRequestId:ZXInterfaceRegister rMethod:POSTMethod params:dic];
            
        }


    }else
    
    if (_registerType == ForgetPassWord) {
       
        if ([NSString isEmpty:confirmPwView.inputTextField.text] || ![_registerModel.userPwd isEqualToString:confirmPwView.inputTextField.text]) {
            [ZXTools makeTask:@"两次密码不一致"];
            setPwView.inputTextField.text = @"";
            confirmPwView.inputTextField.text = @"";
            _registerModel.userPwd = @"";
            return;
        }
        
        
        
        dic = @{@"userMobile" : _registerModel.userMobile, @"verifyCode" : _registerModel.verifyCode, @"newLoginPwd" : _registerModel.userPwd};
        [self sendRequestId:ZXInterfaceUserFindPassword rMethod:POSTMethod params:dic];
        
    }
    
    
    
    
    
    
    
}

- (void)verifyAction {
    if (![NSString valiMobile:phoneView.inputTextField.text]) {
        [ZXTools makeTask:@"手机号不正确"];
        return;
    
    } else {
 
        if (_registerType ==Register) {
            [self sendRequestId:ZXInterfaceSmsCode rMethod:GETMethod params:@{@"userMobile" : phoneView.inputTextField.text, @"sceneType" : @"1"}];
        } else {
            [self sendRequestId:ZXInterfaceSmsCode rMethod:GETMethod params:@{@"userMobile" : phoneView.inputTextField.text, @"sceneType" : @"2"}];
        }
        
    }
}



- (void)handleData:(id)data byRequestId:(NSInteger)requestId {

    if (requestId == ZXInterfaceSmsCode) {
        
        [ZXTools makeTask:@"验证码发送成功！"];
        [verifyView.smsCodeBtn timeFailBeginFrom:60];
     
    } else if (requestId == ZXInterfaceRegister){
    
        [ZXTools makeTask:@"注册成功！"];
        [self.navigationController popViewControllerAnimated:YES];
        
    } else if (ZXInterfaceUserFindPassword == requestId) {
        
        [ZXTools makeTask:@"密码重置成功！"];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}



- (void)handleError:(id)error byRequestId:(NSInteger)requestId {
  

}

- (void)backAct {
    [self.navigationController popViewControllerAnimated:YES];
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
