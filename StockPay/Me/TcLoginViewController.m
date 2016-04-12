//
//  TcLoginViewController.m
//  StockPay
//
//  Created by tjc1991 on 16/3/31.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcLoginViewController.h"
#import "TcRegisterViewController.h"
#import "MainViewController.h"
#import "TcUserApi.h"


@interface TcLoginViewController ()

@end

@implementation TcLoginViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.title = @"登陆";
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark BtnAction

- (IBAction)forgetPwdAction:(id)sender {

}

- (IBAction)loginAction:(id)sender {
    
    NSString *phone = [self.userPhoneTf text];
    NSString *pwd = [self.userPwdTf text];
    
    if ([phone isEqualToString:@""]) {
        [self MakeToast:@"请输入手机号!"];
        return;
    }
    if ([pwd isEqualToString:@""]) {
        [self MakeToast:@"请输入密码!"];
        return;
    }
    
    //显示提示框
    [self showDialog:@"登陆中..."];
    TcUserApi *userApi = [[TcUserApi alloc]init];
    [userApi LoginName:phone andPwd:pwd success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSNumber *code = [responseObject objectForKey:@"code"];
        
        if ([code intValue] ==200) {
            [self MakeSuccessToast:@"登陆成功"];
            
            //保存用户Id
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            //NSLog(@"-->%@",[responseObject objectForKey:@"data"]);
            
            [defaults setObject:[[responseObject objectForKey:@"data"] objectForKey:@"userid"] forKey:NSUSERDEFAULT_USERID];
            
            //保存用户昵称到本地
            [defaults setObject:[[responseObject objectForKey:@"data"] objectForKey:@"nick"] forKey:NSUSERDEFAULT_USER_NICK];
            [defaults synchronize];
            
            self.view.window.rootViewController = [[MainViewController alloc]init];
            
            //销毁当前控制器
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else{
            
            [self MakeToast:@"用户名或密码错误!"];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"err-->%@",error);
        [self MakeToast:@"登录失败!"];
    }];

    
    }

- (IBAction)registerAction:(id)sender {
    
    TcRegisterViewController *regVcl = [[TcRegisterViewController alloc]init];
    [self presentViewController:regVcl animated:YES completion:nil];

}

-(void)dealloc{
    NSLog(@"TcLoginViewController--->dealloc");
}





@end
