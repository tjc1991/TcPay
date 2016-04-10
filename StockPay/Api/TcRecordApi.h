//
//  TcRecordApi.h
//  StockPay
//
//  Created by tjc1991 on 16/4/8.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcBaseApi.h"

@interface TcRecordApi : TcBaseApi

//查询单条用户数据
- (void) fetchOneRecord: (NSUInteger)rdId :(successBlock)success :(failBlock)fail;

//查询所有推荐股票数据,分页
- (void) fetchAllRecord: (NSInteger)page :(successBlock)success :(failBlock)fail;

//查询所有推荐股票数据,分页
- (void) fetchAllRecord: (NSString *)username :(NSInteger)page :(successBlock)success :(failBlock)fail;



@end
