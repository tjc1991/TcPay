//
//  TcUserApi.m
//  StockPay
//
//  Created by tjc1991 on 16/4/7.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcUserApi.h"

@implementation TcUserApi

- (void) LoginName: (NSString *)name andPwd: (NSString *)pwd success:(successBlock)success
           failure:(failBlock)failure{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setObject:name forKey:@"username"];
    [params setObject:pwd forKey:@"userpwd"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:API_LOGIN_URL parameters:params success:success failure:failure];
}

- (void) RegisterName: (NSString *)name andPwd: (NSString *)pwd success:(successBlock)success
              failure:(failBlock)failure{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setObject:name forKey:@"username"];
    [params setObject:pwd forKey:@"userpwd"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:API_REGISTER_URL parameters:params success:success failure:failure];
}

- (void) ChangeNick: (NSString *)name andNick: (NSString *)pwd success:(successBlock)success
            failure:(failBlock)failure{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setObject:name forKey:@"username"];
    [params setObject:pwd forKey:@"nick"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:API_CHANGE_USER_NICK_URL parameters:params success:success failure:failure];
}

- (void) ChangePwd: (NSString *)name oldPwd: (NSString *)oldpwd orignPwd: (NSString *)pwd success:(successBlock)success
            failure:(failBlock)failure{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setObject:name forKey:@"username"];
    [params setObject:oldpwd forKey:@"oldpwd"];
    [params setObject:pwd forKey:@"pwd"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:API_RESET_USER_PWD_URL parameters:params success:success failure:failure];
}



@end
