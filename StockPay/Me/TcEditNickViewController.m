//
//  TcEditNickViewController.m
//  StockPay
//
//  Created by tjc1991 on 16/4/10.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcEditNickViewController.h"
#import "TcUserApi.h"

@interface TcEditNickViewController ()

@end

@implementation TcEditNickViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.title = @"修改昵称";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.nickTf.text = [[NSUserDefaults standardUserDefaults]objectForKey:NSUSERDEFAULT_USER_NICK];
}


- (IBAction)editNickAction:(id)sender {
    
    NSString *phone = self.nickTf.text;
    if ([phone isEqualToString:@""]) {
        [self MakeToast:@"请输入昵称"];
        return;
    }
    
    //显示提示框
    [self showDialog:@"更新中..."];
    
    TcUserApi *userApi = [[TcUserApi alloc]init];
    [userApi ChangeNick:[[NSUserDefaults standardUserDefaults]objectForKey:NSUSERDEFAULT_USERID] andNick:phone success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            
            NSNumber *rsCode = [responseObject objectForKey:@"code"];
            
            //保存登陆信息
            if ([rsCode intValue] == 200) {
                [self MakeSuccessToast:@"设置昵称成功"];
                
                //保存用户昵称到本地
                [[NSUserDefaults standardUserDefaults]setObject:phone forKey:NSUSERDEFAULT_USER_NICK];
                
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self MakeToast:@"修改昵称失败"];
            }
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //提示错误
        [self MakeToast:@"修改昵称失败"];
        //NSLog(@"err-->%@",error);
        
    }];
    

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
