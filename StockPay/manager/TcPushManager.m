//
//  TcPushManager.m
//  StockPay
//
//  Created by tjc1991 on 16/3/30.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcPushManager.h"
#import "JPUSHService.h"

static NSString *appKey = @"25d9efdb2aba8fd3583f2f70";
static NSString *channel = @"stockpay";
static BOOL isProduction = FALSE;
static BOOL isBackGroundActivateApplication = FALSE;

@implementation TcPushManager

//获取单例
+ (TcPushManager *)TcPushManagerInstance{

    static TcPushManager *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] init];
    });
    return _sharedClient;
    
}

//注册
- (void) registerTcPush:(NSDictionary *)launchOptions{
    
    // iOS8 下需要使用新的 API
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey channel:channel apsForProduction:isProduction];
    
    //清空BadgeView
    [JPUSHService resetBadge];
    
    
}

//启动push功能
- (void) startJPush:(NSData *)deviceToken{
    
    [JPUSHService registerDeviceToken:deviceToken];
}

//关闭Push功能
- (void) stopJpush{
    
}

//处理推送
- (void) handlePushMsg:(UIApplicationState)status didReceiveRemoteNotification:(NSDictionary *)userInfo{

    [JPUSHService handleRemoteNotification:userInfo];
    
    //清空bADGEvIEW
    //[JPUSHService resetBadge];
        
    //发送通知
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:userInfo];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

- (void) showLocalNotify:(UILocalNotification *)notification{
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];

}

@end
