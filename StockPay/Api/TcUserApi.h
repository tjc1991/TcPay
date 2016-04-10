//
//  TcUserApi.h
//  StockPay
//
//  Created by tjc1991 on 16/4/7.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcBaseApi.h"

@interface TcUserApi : TcBaseApi

- (void) LoginName: (NSString *)name andPwd: (NSString *)pwd success:(successBlock)success
           failure:(failBlock)failure;

- (void) RegisterName: (NSString *)name andPwd: (NSString *)pwd success:(successBlock)success
              failure:(failBlock)failure;

- (void) ChangeNick: (NSString *)name andNick: (NSString *)pwd success:(successBlock)success
              failure:(failBlock)failure;

- (void) ChangePwd: (NSString *)name oldPwd: (NSString *)oldpwd orignPwd: (NSString *)pwd success:(successBlock)success
           failure:(failBlock)failure;

@end
