//
//  TcGrailDetailViewController.m
//  StockPay
//
//  Created by tjc1991 on 16/3/30.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcGrailDetailViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "TcHistoryApi.h"
#import "NSDate+TimeCategory.h"
#import "TcHistoryCellTableViewCell.h"
#import <MJExtension/MJExtension.h>

@interface TcGrailDetailViewController ()
{
    NSInteger page;
}

@end

@implementation TcGrailDetailViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.title = @"行情";
        self.data = [NSMutableArray arrayWithCapacity:10];
        page = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //注册刷新通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:NOTOFY_FRESH_LIST object:nil];
    
    [self.tableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self pullUp];
        
        
    }];
    
    self.tableview.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self pullDown];
        
    }];
    
    //第一次进入自动刷新一次
    [self.tableview.header beginRefreshing];
    
}

//上拉,获取最新数据
- (void)pullUp{
    
    TcHistoryApi *hisToryApi = [[TcHistoryApi alloc]init];
    [hisToryApi fetchHistory:[[NSUserDefaults standardUserDefaults]objectForKey:NSUSERDEFAULT_USERID] :1 :^(NSURLSessionDataTask *task, id responseObject) {
        //停止刷新
        [self endRefresh];
        
        if (responseObject) {
            if ([[responseObject objectForKey:@"code"] integerValue] == 200) {
                //显示数据
                NSArray *tmpArray = [responseObject objectForKey:@"data"];
                if (tmpArray && [tmpArray count]>0) {
                    
                   // NSLog(@"%@",responseObject);
                    
                    if ([self.data count] == 0) {
                        //第一次添加数据
                        [self.data addObjectsFromArray:tmpArray];
                        [self updateView];
                        
                    }else{
                        //NSLog(@"data0-->%@",self.data[0]);
                        //添加最新数据
                        NSMutableArray *tmpArrays = [NSMutableArray arrayWithCapacity:10];
                        
                        for (int i=0; i<[tmpArray count]; i++) {
                            NSDictionary *dic = tmpArray[i];
                            NSInteger stamp = [NSDate cTimestampFromString:[dic objectForKey:@"createtime"] format:@"yyyy-MM-dd HH:mm:ss"];
                            
                            if (stamp > [NSDate cTimestampFromString:[self.data[0] objectForKey:@"createtime"] format:@"yyyy-MM-dd HH:mm:ss"]) {
                                [tmpArrays addObject:dic];
                            }else{
                                
                            }
                        }
                        
                        //退出循环
                        if ([tmpArrays count]>0) {
                            [self.data insertObjects:tmpArrays atIndexes:[NSIndexSet indexSetWithIndex:0]];
                            [self updateView];
                        }else{
                            [self MakeSuccessToast:@"没有最新数据了"];
                        }
                        
                    }
                }
            }else{
                //提示用户未购买
                [self MakeToast:@"您还没有购买最新数据哟~~"];
            }
        }
        
        
    } :^(NSURLSessionDataTask *task, NSError *error) {
        //
        [self endRefresh];
        [self MakeToast:@"获取数据失败!"];
    }];
}

//下拉,加载以前数据
- (void)pullDown{
    
    //避免第一次加载数据后下拉无法加载数据
    if (page == 1 && [self.data count] == PAGE_COUNT) {
        page++;
    }
    //NSLog(@"page =%ld",page);
    
    TcHistoryApi *hisToryApi = [[TcHistoryApi alloc]init];
    [hisToryApi fetchHistory:[[NSUserDefaults standardUserDefaults]objectForKey:NSUSERDEFAULT_USERID] :page :^(NSURLSessionDataTask *task, id responseObject) {
        //停止刷新
        [self endRefresh];
        
        if (responseObject) {
            if ([[responseObject objectForKey:@"code"] integerValue] == 200) {
                //显示数据
                NSArray *tmpArray = [responseObject objectForKey:@"data"];
                if (tmpArray && [tmpArray count]>0) {
                    
                    //NSLog(@"%@",responseObject);
                    
                    if ([self.data count] == 0) {
                        //第一次添加数据
                        
                        if ([tmpArray count] >= PAGE_COUNT) {
                            //满一页数据
                            page++;
                        }
                        
                        [self.data addObjectsFromArray:tmpArray];
                        [self updateView];
                        
                    }else{
                        //添加最新数据
                        NSMutableArray *tmpArrays = [NSMutableArray arrayWithCapacity:1];
                        
                        if ([tmpArray count] >= PAGE_COUNT) {
                            page++;
                        }
                        
                        for (int i=0; i<[tmpArray count]; i++) {
                            NSDictionary *dic = tmpArray[i];
                            NSInteger stamp = [NSDate cTimestampFromString:[dic objectForKey:@"createtime"] format:@"yyyy-MM-dd HH:mm:ss"];
                            
                            if (stamp < [NSDate cTimestampFromString:[self.data[[self.data count]-1] objectForKey:@"createtime"] format:@"yyyy-MM-dd HH:mm:ss"]) {
                                [tmpArrays addObject:dic];
                            }else{
                                
                            }
                        }
                        
                        //退出循环
                        if ([tmpArrays count]>0) {
                            [self.data addObjectsFromArray:tmpArrays];
                            [self updateView];
                        }else{
                            [self MakeSuccessToast:@"没有最新数据了"];
                        }
                        
                    }
                }
            }else{
                //提示用户未购买
                [self MakeToast:@"您还没有购买最新数据哟~~"];
            }
        }
        
        
    } :^(NSURLSessionDataTask *task, NSError *error) {
        //
        [self endRefresh];
        [self MakeToast:@"获取数据失败!"];
    }];
}

//更新视图.
- (void) updateView
{
    [self.tableview reloadData];
}

//停止刷新
-(void)endRefresh{
    [self.tableview.header endRefreshing];
    [self.tableview.footer endRefreshing];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdenfy = @"TcHistoryCellTableViewCell";
    
    TcHistoryCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenfy];
    if (cell == nil) {
        cell = [[TcHistoryCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenfy];
    }
    
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UIImage *bubble = [UIImage imageNamed:@"tbg"];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:floorf(bubble.size.width/2) topCapHeight:floorf(bubble.size.height/2)]];
    
    TcHistoryModel *historymodel = [TcHistoryModel mj_objectWithKeyValues:[self.data objectAtIndex:indexPath.row]];
    
    cell.model = historymodel;
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TcHistoryModel *historymodel = [TcHistoryModel mj_objectWithKeyValues:[self.data objectAtIndex:indexPath.row]];
        
    float height = [TcHistoryCellTableViewCell getHistoryHeight:historymodel];
    height += 55;
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置UITableview 选中返回时为不选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
            
        default:
            break;
    }
}

#pragma mark Notify

- (void)refreshData{
    
    [self.tableview.header beginRefreshing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTOFY_FRESH_LIST object:nil];
}


@end
