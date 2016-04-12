//
//  TcPayViewController.m
//  StockPay
//
//  Created by tjc1991 on 16/3/30.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcPayViewController.h"
#import "TcHistoryApi.h"

@interface TcPayViewController ()

@end

@implementation TcPayViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.title = @"支付";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *zfbImView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zfbsmall.png"]];
    zfbImView.frame = CGRectMake((ScreenWidth-128)/2, 30, 128, 64);
    [self.view addSubview:zfbImView];
    
    self.shuoMingLb = [[UILabel alloc] initWithFrame:CGRectMake(0, zfbImView.bottom+20, ScreenWidth, 30)];
    self.shuoMingLb.textAlignment = NSTextAlignmentCenter;
    self.shuoMingLb.text = @"说明";
    self.shuoMingLb.font = [UIFont fontWithName:@"" size:22];
    self.shuoMingLb.textColor = [UIColor redColor];
    [self.view addSubview:self.shuoMingLb];
    
    //详细
    self.noticeLb = [[UILabel alloc] initWithFrame:CGRectMake(0, self.shuoMingLb.bottom+10, ScreenWidth, 30)];
    self.noticeLb.textAlignment = NSTextAlignmentCenter;
    self.noticeLb.text = @"注意获取最新推荐股票请支付1元人民币";
    self.noticeLb.textColor = [UIColor redColor];
    [self.view addSubview:self.noticeLb];
    
    //支付安钮
    self.payBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, self.noticeLb.bottom+30, ScreenWidth-60, 50)];
    [self.payBtn setTitle:@"一键支付" forState:UIControlStateNormal];
    [self.payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [self.payBtn setBackgroundImage:[UIImage imageNamed:@"btn_login_normal@2x.png"] forState:UIControlStateNormal];
    [self.payBtn setBackgroundImage:[UIImage imageNamed:@"btn_login_pressed@2x.png"] forState:UIControlStateHighlighted];
    [self.payBtn addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.payBtn];
    
}

- (void)pay{
    
    //[self showDialog:@"支付中..."];

    BmobPay* bPay = [[BmobPay alloc] init];
    //设置代理
    bPay.delegate = self;
    //设置商品价格、商品名、商品描述
    [bPay setPrice:[NSNumber numberWithDouble:0.01]];
    [bPay setProductName:@"股票投资费"];
    [bPay setBody:@"投资费用"];
    //appScheme为创建项目第4步中在URL Schemes中添加的标识
    [bPay setAppScheme:@"stockPay"];
    //调用支付宝支付
    [bPay payInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
        
        } else{
            [self MakeToast:@"订单生成失败"];
        }
    }];

}

#pragma mark BmobPayDelegate

-(void)paySuccess{
    [self MakeSuccessToast:@"支付成功"];
    
    //创建用户购买记录
    [self showDialog:@"订单生成中..."];
    
    TcHistoryApi *historyApi = [[TcHistoryApi alloc]init];
    
    //注意这里可能会出现问题
    
    [historyApi createOneHistory:[[NSUserDefaults standardUserDefaults]objectForKey:NSUSERDEFAULT_USERID] :[self.pushMsgArray[1] integerValue] :^(NSURLSessionDataTask *task, id responseObject) {
        //
        [self closeDlg];
        
        if ([self.pushMsgArray[0] integerValue] == 0) {
            
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTOFY_FRESH_LIST object:self];
            
            //跳转到推荐股票页
            self.tabBarController.selectedIndex = 0;
        }else{
            
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTOFY_FRESH_LIST object:self];
            
            //跳转到大盘行情页
            self.tabBarController.selectedIndex = 1;
        }
        
        //退出支付控制器
        [self.navigationController popViewControllerAnimated:NO];
        
        
    } :^(NSURLSessionDataTask *task, NSError *error) {
        //
        [self MakeToast:@"订单生成失败"];
    }];
    
}


-(void)payFailWithErrorCode:(int) errorCode{
    
    [self MakeToast:@"支付失败"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
