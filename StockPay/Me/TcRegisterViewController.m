//
//  TcRegisterViewController.m
//  StockPay
//
//  Created by tjc1991 on 16/3/31.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcRegisterViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "TcUserApi.h"


@interface TcRegisterViewController ()
{
    NSTimer *countDownTimer;
    NSInteger secondsCountDown;
}

@end

@implementation TcRegisterViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.title = @"注册";
        //设置定时器时间
        secondsCountDown = 45;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.userPhoneTf resignFirstResponder];
    [self.userPwdTf resignFirstResponder];
    [self.codeTf resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeViewControllerAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)getCodeAction:(id)sender {
    
    NSString *phone = self.userPhoneTf.text;
    NSLog(@"-----%@",phone);
    if ([phone isEqualToString:@""]) {
        [self MakeToast:@"请输入手机号!"];
        return;
    }
    
    //展示获取验证码界面，SMSGetCodeMethodSMS:表示通过文本短信方式获取验证码
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phone zone:@"86" customIdentifier:nil result:^(NSError *error){
        if (!error) {
            //显示倒计时
            [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%dS",secondsCountDown] forState:UIControlStateNormal];
            [self.getCodeBtn setUserInteractionEnabled:FALSE];
            self.getCodeBtn.alpha=0.4;
            
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
            
            NSLog(@"获取验证码成功");
        } else {
            NSLog(@"错误信息：%@",error);
        }
    }];
    
}

-(void)timeFireMethod{
    secondsCountDown--;
    if(secondsCountDown<=0){
        [countDownTimer invalidate];
        [self.getCodeBtn setUserInteractionEnabled:TRUE];
        self.getCodeBtn.alpha=1.0;
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        
    }else{
        //更新UI
        [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%dS",secondsCountDown] forState:UIControlStateNormal];
    }
}


- (IBAction)registerAction:(id)sender {
    
    NSString *phone = self.userPhoneTf.text;
    if ([phone isEqualToString:@""]) {
        [self MakeToast:@"请输入手机号!"];
        return;
    }
    NSString *code = self.codeTf.text;
    if ([code isEqualToString:@""]) {
        [self MakeToast:@"请输入验证码!"];
        return;
    }
    
    //显示提示框
    [self showDialog:@"注册中..."];
    //验证验证码
    [SMSSDK commitVerificationCode:self.codeTf.text phoneNumber:self.userPhoneTf.text zone:@"86" result:^(NSError *error){
        if (!error) {
            //注册
            TcUserApi *userApi = [[TcUserApi alloc]init];
            [userApi RegisterName:self.userPhoneTf.text andPwd:self.userPwdTf.text success:^(NSURLSessionDataTask *task, id responseObject) {
                if (responseObject) {
                    
                    NSNumber *rsCode = [responseObject objectForKey:@"code"];
                    
                    //保存登陆信息
                    if ([rsCode intValue] == 201) {
                        [self MakeToast:@"用户已注册!"];
                    }else{
                        [self MakeToast:@"用户注册成功!"];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                    
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                //提示错误
                [self MakeToast:@"用户注册错误!"];
                NSLog(@"err-->%@",error);

            }];
            
        } else {
            //提示错误
            [self MakeToast:@"验证码错误!"];
        }
    }];
    
    
}

-(void)dealloc{
    NSLog(@"TcRegisterViewController--->dealloc");
}

@end
