//
//  TcMeViewController.h
//  StockPay
//
//  Created by tjc1991 on 16/3/31.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcBaseViewController.h"

@interface TcMeViewController : TcBaseViewController<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UILabel *userPhoneLb;

@property (weak, nonatomic) IBOutlet UITableView *tablewview;

@property(nonatomic,strong) NSMutableArray *data;

@property (weak, nonatomic) IBOutlet UILabel *userNickLb;

@end
