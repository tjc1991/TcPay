//
//  TcHistoryModel.h
//  StockPay
//
//  Created by tjc1991 on 16/4/8.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TcHistoryModel : NSObject

//用户ID
@property(nonatomic,copy) NSString *userid;
//消息ID
@property(nonatomic,assign) NSUInteger rdid;
//时间
@property(nonatomic,copy) NSString *createtime;

@property(nonatomic,copy) NSString *content;



@end
