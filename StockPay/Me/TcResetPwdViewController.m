//
//  TcResetPwdViewController.m
//  StockPay
//
//  Created by tjc1991 on 16/4/10.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcResetPwdViewController.h"
#import "TcUserApi.h"
#import "TcLoginViewController.h"

@interface TcResetPwdViewController ()

@end

@implementation TcResetPwdViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.title = @"重置密码";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)resetPwd:(id)sender {

    NSString *oldPwd = self.oldPwdTf.text;
    if ([oldPwd isEqualToString:@""]) {
        [self MakeToast:@"请输入旧密码"];
        return;
    }
    
    NSString *newPwd = self.orignTf.text;
    if ([newPwd isEqualToString:@""]) {
        [self MakeToast:@"请输入新密码"];
        return;
    }
    
    //显示提示框
    [self showDialog:@"更新中..."];
    
    TcUserApi *userApi = [[TcUserApi alloc]init];
    [userApi ChangePwd:[[NSUserDefaults standardUserDefaults]objectForKey:NSUSERDEFAULT_USERID] oldPwd:oldPwd orignPwd:newPwd success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            
            NSNumber *rsCode = [responseObject objectForKey:@"code"];
            
            //保存登陆信息
            if ([rsCode intValue] == 200) {
                [self MakeSuccessToast:@"重置密码成功"];
                
                //清除NSUserDefault
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:NSUSERDEFAULT_USERID];

                //跳转到登陆界面
                TcLoginViewController *login = [[TcLoginViewController alloc]init];
                [self presentViewController:login animated:YES completion:nil];

            }else{
                [self MakeToast:@"修改密码失败"];
            }
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //提示错误
        [self MakeToast:@"修改密码失败"];
        NSLog(@"err-->%@",error);
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
