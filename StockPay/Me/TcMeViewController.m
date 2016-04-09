//
//  TcMeViewController.m
//  StockPay
//
//  Created by tjc1991 on 16/3/31.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcMeViewController.h"
#import "TcLoginViewController.h"
#import "BaseNavigationViewController.h"

@interface TcMeViewController ()

@end

@implementation TcMeViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.title = @"我的";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)logOutAction:(id)sender {
    
    //清除NSUserDefault
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:NSUSERDEFAULT_USERID];
    //跳转到登陆界面
    TcLoginViewController *login = [[TcLoginViewController alloc]init];
    [self presentViewController:login animated:YES completion:nil];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
