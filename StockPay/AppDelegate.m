//
//  AppDelegate.m
//  StockPay
//
//  Created by tjc1991 on 16/3/29.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import <BmobPay/BmobPay.h>
#import "TcPushManager.h"
#import "MainViewController.h"
#import "TcLoginViewController.h"
#import <SMS_SDK/SMSSDK.h>

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //注册ShareSDK
    //初始化应用，appKey和appSecret从后台申请得
    [SMSSDK registerApp:MOB_APPKEY withSecret:MOB_APPSECURT];
    
    //注册极光推送
    [[TcPushManager TcPushManagerInstance] registerTcPush:launchOptions];
    
    [application setApplicationIconBadgeNumber:0];
        
    //设置Bmob支付
    [BmobPaySDK registerWithAppKey:BMOB_APPKEY];
    
    //判断用户是否登陆
    if ([[NSUserDefaults standardUserDefaults]objectForKey:NSUSERDEFAULT_USERID]) {
        //跳转到主控制器
        MainViewController *mainVcl = [[MainViewController alloc]init];
        
        self.window.rootViewController = mainVcl;
        
    }else{
        TcLoginViewController *loginVcl = [[TcLoginViewController alloc]init];
        self.window.rootViewController = loginVcl;
    }
    
    
    return YES;

}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [[TcPushManager TcPushManagerInstance] startJPush:deviceToken];
    
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Application did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}

// 此方法是 用户点击了通知，应用在前台 或者开启后台并且应用在后台 时调起
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    
    //处理通知
    [[TcPushManager TcPushManagerInstance] handlePushMsg:application.applicationState didReceiveRemoteNotification:userInfo];
    
    //NSLog(@"-->收到通知:%@", userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"-->-->reveive notify");
    [[TcPushManager TcPushManagerInstance] showLocalNotify:notification];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}

@end
