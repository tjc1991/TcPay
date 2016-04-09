//
//  TcGrailDetailViewController.h
//  StockPay
//
//  Created by tjc1991 on 16/3/30.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcBaseViewController.h"

@interface TcGrailDetailViewController : TcBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property(nonatomic,strong) NSMutableArray *data;

@end
