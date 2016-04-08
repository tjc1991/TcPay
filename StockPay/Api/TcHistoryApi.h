//
//  TcHistoryApi.h
//  StockPay
//
//  Created by tjc1991 on 16/4/8.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcBaseApi.h"

@interface TcHistoryApi : TcBaseApi

-(void) createOneHistory: (NSString *)userid :(NSUInteger)rdid :(successBlock)success :(failBlock)fail;

-(void) fetchHistory: (NSString *)userid :(successBlock)success :(failBlock)fail;

@end
