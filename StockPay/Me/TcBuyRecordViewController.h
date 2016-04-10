//
//  TcBuyRecordViewController.h
//  StockPay
//
//  Created by tjc1991 on 16/4/10.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcBaseViewController.h"

@interface TcBuyRecordViewController : TcBaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property(nonatomic,strong) NSMutableArray *data;

@end
