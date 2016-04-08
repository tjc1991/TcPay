//
//  TcBaseViewController.m
//  StockPay
//
//  Created by tjc1991 on 16/3/30.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcBaseViewController.h"
#import <SVProgressHUD.h>

@interface TcBaseViewController ()

@end

@implementation TcBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }

}

- (void)showDialog:(NSString*)msg{
    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
    [SVProgressHUD showWithStatus:msg];
}

- (void)closeDialog:(BOOL)isSuccess withHint:(NSString*)msg{
    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
    [SVProgressHUD dismiss];
}

- (void)MakeToast:(NSString*)hint{
    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
    [SVProgressHUD showErrorWithStatus:hint];
}

- (void)MakeSuccessToast:(NSString*)hint{
    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
    [SVProgressHUD showSuccessWithStatus:hint];
}

- (void)closeDlg{
    [SVProgressHUD dismiss];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
