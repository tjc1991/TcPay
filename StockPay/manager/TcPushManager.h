//
//  TcPushManager.h
//  StockPay
//
//  Created by tjc1991 on 16/3/30.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TcPushManager : NSObject

//获取单例
+ (TcPushManager *)TcPushManagerInstance;

//注册
- (void) registerTcPush:(NSDictionary *)launchOptions;

//启动push功能
- (void) startJPush:(NSData *)deviceToken;

//关闭Push功能
- (void) stopJpush;

//处理
- (void) handlePushMsg:(UIApplicationState)status didReceiveRemoteNotification:(NSDictionary *)userInfo;

//显示本地通知
- (void) showLocalNotify:(UILocalNotification *)notification;



@end
