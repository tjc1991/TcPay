//
//  TcPayViewController.h
//  StockPay
//
//  Created by tjc1991 on 16/3/30.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcBaseViewController.h"
#import <BmobPay/BmobPay.h>

@interface TcPayViewController : TcBaseViewController<BmobPayDelegate>

@property(nonatomic,strong) UILabel *shuoMingLb;
@property(nonatomic,strong) UILabel *noticeLb;
@property(nonatomic,strong) UIButton *payBtn;

//推送消息数据
@property(nonatomic,strong) NSArray *pushMsgArray;

@property(nonatomic,assign) NSUInteger rdid;

@end
