//
//  BaseNavigationViewController.m
//  tclife
//
//  Created by tjc1991 on 15/11/24.
//  Copyright © 2015年 cldxk. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"tittleNavigation@2x.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0X00a57f),UITextAttributeTextColor,[UIFont systemFontOfSize:20.0f],NSFontAttributeName,nil]];
    
    //设定返回按钮
    self.navigationBar.tintColor = UIColorFromRGB(0x00bb9c);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

@end
