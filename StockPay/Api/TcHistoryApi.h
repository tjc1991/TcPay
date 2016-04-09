//
//  TcHistoryApi.h
//  StockPay
//
//  Created by tjc1991 on 16/4/8.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcBaseApi.h"

@interface TcHistoryApi : TcBaseApi

//创建购买记录
-(void) createOneHistory: (NSString *)userid :(NSUInteger)rdid :(successBlock)success :(failBlock)fail;

//查询用户购买记录
-(void) fetchHistory: (NSString *)userid :(NSInteger)page :(successBlock)success :(failBlock)fail;

//查询单条用户购买数据
-(void) fetchUserBuy: (NSString *)userid :(NSUInteger)rdid :(successBlock)success :(failBlock)fail;


@end
