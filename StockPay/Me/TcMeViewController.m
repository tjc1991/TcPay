//
//  TcMeViewController.m
//  StockPay
//
//  Created by tjc1991 on 16/3/31.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcMeViewController.h"
#import "TcLoginViewController.h"

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
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
