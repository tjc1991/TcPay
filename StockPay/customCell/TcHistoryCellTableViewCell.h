//
//  TcHistoryCellTableViewCell.h
//  StockPay
//
//  Created by tjc1991 on 16/4/9.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TcHistoryModel.h"

@interface TcHistoryCellTableViewCell : UITableViewCell

@property(nonatomic,strong) TcHistoryModel *model;

@property(nonatomic,strong)UILabel *timeLb;
@property(nonatomic,strong)UILabel *contentLb;


+(float)getHistoryHeight:(TcHistoryModel*)historymodel;

@end
