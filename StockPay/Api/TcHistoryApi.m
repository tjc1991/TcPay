//
//  TcHistoryApi.m
//  StockPay
//
//  Created by tjc1991 on 16/4/8.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcHistoryApi.h"
#import "TcHistoryModel.h"

@implementation TcHistoryApi

//创建用户一条购买历史

-(void) createOneHistory: (NSString *)userid :(NSUInteger)rdid :(successBlock)success :(failBlock)fail{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setObject:userid forKey:@"username"];
    [params setObject:[NSNumber numberWithUnsignedInteger:rdid] forKey:@"rdid"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:API_CREATE_HISTORY_URL parameters:params success:success failure:fail];
    
}

//获取用户购买历史

-(void) fetchHistory: (NSString *)userid :(NSInteger)page :(successBlock)success :(failBlock)fail{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setObject:userid forKey:@"username"];
    [params setObject:[NSNumber numberWithInteger:page] forKey:@"p"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:API_FETCH_HISTORY_URL parameters:params success:success failure:fail];

}

//查询单条用户购买数据
-(void) fetchUserBuy: (NSString *)userid :(NSUInteger)rdid :(successBlock)success :(failBlock)fail{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setObject:userid forKey:@"username"];
    [params setObject:[NSNumber numberWithUnsignedInteger:rdid] forKey:@"rid"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:API_FETCH_USERBUY_URL parameters:params success:success failure:fail];
}


@end
