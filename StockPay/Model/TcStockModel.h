//
//  TcStockModel.h
//  StockPay
//
//  Created by tjc1991 on 16/4/8.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TcStockModel : NSObject
//名字
@property(nonatomic,copy) NSString *name;
//代码
@property(nonatomic,copy) NSString *code;
//时间
@property(nonatomic,copy) NSString *createtime;
//建议
@property(nonatomic,copy) NSString *opinion;

@end
