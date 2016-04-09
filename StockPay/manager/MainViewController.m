//
//  ViewController.m
//  wemall
//
//  Created by tjc1991 on 15-3-10.
//  Copyright (c) 2015年 ukmterm. All rights reserved.
//

#import "MainViewController.h"
#import "TcMeViewController.h"
#import "TcGrailDetailViewController.h"
#import "TcStockViewController.h"
#import "BaseNavigationViewController.h"
#import "TcPayViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initViewController];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivePushMsg:) name:@"tongzhi" object:nil];
    
}

-(void) _initViewController{
    TcStockViewController *shopVC = [[TcStockViewController alloc] init];
    TcGrailDetailViewController *orderVC = [[TcGrailDetailViewController alloc] init];
    TcMeViewController *aboutmeVC = [[TcMeViewController alloc] init];
    
    //选择指示器效果
    //self.tabBar.selectionIndicatorImage=[UIImage imageNamed:@"pink_btn"];
    //需要设置背景色,不然选择时会出错
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    if (IS_OS_7_OR_LATER) {
        //字体设置
        [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor grayColor]}forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : UIColorFromRGB(0X00a57f)}forState:UIControlStateSelected];
    }else
    {
        [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],nil] forState:UIControlStateNormal];
        
        [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0X00a57f),nil] forState:UIControlStateSelected];
    }
    
    if (IS_OS_7_OR_LATER) {
        //股票
        UIImage *shopImgs = [UIImage imageNamed:@"icon_home_pre"];
        UIImage *shopImg = [UIImage imageNamed:@"icon_home_nor"];
        shopVC.tabBarItem.selectedImage = [shopImgs imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        shopVC.tabBarItem.image = [shopImg imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        
        //大盘
        UIImage *orderImgs = [UIImage imageNamed:@"icon_message_pre"];
        UIImage *orderImg = [UIImage imageNamed:@"icon_message_nor"];
        orderVC.tabBarItem.selectedImage = [orderImgs imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        orderVC.tabBarItem.image = [orderImg imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];

        //个人中心
        UIImage *aboutImgs = [UIImage imageNamed:@"icon_setting_pre"];
        UIImage *aboutImg = [UIImage imageNamed:@"icon_setting_nor"];
        aboutmeVC.tabBarItem.selectedImage = [aboutImgs imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        aboutmeVC.tabBarItem.image = [aboutImg imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];

    }else{
        //股票
        [shopVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"icon_home_pre"]
                        withFinishedUnselectedImage:[UIImage imageNamed:@"icon_home_nor"]];
        //大盘
        [orderVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"icon_message_pre"]
              withFinishedUnselectedImage:[UIImage imageNamed:@"icon_message_nor"]];
        //个人中心
        [aboutmeVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"icon_setting_pre"]
                           withFinishedUnselectedImage:[UIImage imageNamed:@"icon_setting_nor"]];
    }
       
    NSMutableArray *views = [NSMutableArray arrayWithCapacity:3];
    [views addObject:shopVC];
    [views addObject:orderVC];
    [views addObject:aboutmeVC];
    
    self.viewcontrollers = [NSMutableArray arrayWithCapacity:3];
    for (UIViewController *viewcontroller in views) {
    
            BaseNavigationViewController *basenvctl = [[BaseNavigationViewController alloc]initWithRootViewController:viewcontroller];
            [self.viewcontrollers addObject:basenvctl];
    }

    self.viewControllers = self.viewcontrollers;
    self.selectedIndex  = 0;

}

//接收到推送通知
- (void)receivePushMsg:(NSNotification *)notice{
    
    // 应用在前台，不跳转页面，让用户选择。
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
        NSLog(@"acitve ");
        
        NSDictionary *userInfo = notice.userInfo[@"aps"];
        if (userInfo) {
            
            NSString *msg = [userInfo objectForKey:@"alert"];
            if (msg) {
                NSArray *contentArray = [msg componentsSeparatedByString:@";"];
                
                //保存临时推送信息
                self.stockMsgArray = contentArray;
                
                if ([contentArray count] == 3) {
                    
                    if ([contentArray[0] isEqualToString:@"0"]) {
                        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"股票来了" message:contentArray[2] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
                        [alertView show];
                    }else{
                        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"最新大盘分析" message:contentArray[2] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
                        [alertView show];
                    }
                    
                }
            }
        }
    }
    
    //杀死状态下，直接跳转到跳转页面。
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateInactive)
    {
        NSLog(@"background is Inactive !");
        //在后台模式,进入这里
        
        NSDictionary *userInfo = notice.userInfo[@"aps"];
        if (userInfo) {
            
            NSString *msg = [userInfo objectForKey:@"alert"];
            if (msg) {
                NSArray *contentArray = [msg componentsSeparatedByString:@";"];
                
                //保存临时推送信息
                self.stockMsgArray = contentArray;
                
                if ([contentArray count] == 3) {
                    if ([contentArray[0] isEqualToString:@"0"]) {
                        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"股票来了" message:contentArray[2] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
                        [alertView show];
                    }else{
                        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"最新大盘分析" message:contentArray[2] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
                        [alertView show];
                    }
                }
            }
        }
        
    }
    // 应用在后台。当后台设置aps字段里的 content-available 值为 1 并开启远程通知激活应用的选项
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground) {
        NSLog(@"background is Activated Application ");
        //此处有可能进不来
    }
    
}

#pragma mark AlertView

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;{
    
    NSLog(@"btn click!");
    
    // the user clicked OK
    if (buttonIndex == 0)
    {
        //do something here...
    }else if (buttonIndex == 1)
    {
        //do something here...
        if (!self.payVcl) {
            self.payVcl = [[TcPayViewController alloc]init];
            
        }
        
        [self.payVcl setPushMsgArray:self.stockMsgArray];
        
        //获取TabbarController对应的NavigationController
        BaseNavigationViewController *tmpBaseNavVcl = [self.viewcontrollers objectAtIndex:self.selectedIndex];
        
        [tmpBaseNavVcl pushViewController:self.payVcl animated:YES];
        
    }
}

-(void)dealloc{
    NSLog(@"MainViewController-->dealloc");
}


@end
