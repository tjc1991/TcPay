//
//  TcStockViewController.m
//  StockPay
//
//  Created by tjc1991 on 16/3/30.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcStockViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "NSDate+TimeCategory.h"
#import "TcRecordApi.h"
#import "TcHistoryApi.h"
#import "TcPayViewController.h"

@interface TcStockViewController ()
{
    NSInteger page;
}


@end

@implementation TcStockViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.title = @"推荐";
        self.data = [NSMutableArray arrayWithCapacity:10];
        page = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    TcRecordApi *recordApi = [[TcRecordApi alloc]init];
    [recordApi fetchAllRecord:1 :^(NSURLSessionDataTask *task, id responseObject) {
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
                        [self.data addObjectsFromArray:tmpArray];
                        [self updateView];
                        
                    }else{
                        //添加最新数据
                        NSMutableArray *tmpArrays = [NSMutableArray arrayWithCapacity:10];
                        for (NSDictionary *dic in tmpArray) {
                            
                            NSInteger stamp = [NSDate cTimestampFromString:[dic objectForKey:@"createtime"] format:@"yyyy-MM-dd HH:mm:ss"];
                            
                            if (stamp > [NSDate cTimestampFromString:[self.data[0] objectForKey:@"createtime"] format:@"yyyy-MM-dd HH:mm:ss"]) {
                                [tmpArrays addObject:dic];
                            }else{
                                //退出循环
                                [self MakeSuccessToast:@"没有最新数据了"];
                                [self updateView];
                                break;
                            }
                        }
                        
                    }
                }
            }else{
                //提示用户未购买
                [self MakeToast:@"数据获取失败"];
            }
        }
        
        
    } :^(NSURLSessionDataTask *task, NSError *error) {
        //
        [self endRefresh];
        [self MakeToast:@"获取数据失败"];
    }];
    
}

//下拉,加载以前数据
- (void)pullDown{
    NSLog(@"page =%ld",page);
    
    TcRecordApi *recordApi = [[TcRecordApi alloc]init];
    [recordApi fetchAllRecord:page :^(NSURLSessionDataTask *task, id responseObject) {
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
                        
                        if ([tmpArray count] >= 10) {
                            //满一页数据
                            page++;
                        }
                        
                        [self.data addObjectsFromArray:tmpArray];
                        [self updateView];
                        
                    }else{
                        //添加最新数据
                        NSMutableArray *tmpArrays = [NSMutableArray arrayWithCapacity:1];
                        
                        if ([tmpArray count] >= 10) {
                            page++;
                        }
                        
                        for (NSDictionary *dic in tmpArray) {
                            
                            NSInteger stamp = [NSDate cTimestampFromString:[dic objectForKey:@"createtime"] format:@"yyyy-MM-dd HH:mm:ss"];
                            
                            if (stamp > [NSDate cTimestampFromString:[[self.data lastObject] objectForKey:@"createtime"] format:@"yyyy-MM-dd HH:mm:ss"]) {
                                [tmpArrays addObject:dic];
                            }else{
                                //退出循环
                                [self MakeSuccessToast:@"没有最新数据了"];
                                [self updateView];
                                break;
                            }
                        }
                        
                    }
                }
            }else{
                //提示用户未购买
                [self MakeToast:@"您还没有购买最新数据哟"];
            }
        }
        
        
    } :^(NSURLSessionDataTask *task, NSError *error) {
        //
        [self endRefresh];
        [self MakeToast:@"获取数据失败"];
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
    
    static NSString *cellIdenfy = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenfy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdenfy];
    }
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:[self getRandomNumber:1 to:10]]]];
    cell.textLabel.text  = @"股票测试数据";
    cell.detailTextLabel.text = [[self.data objectAtIndex:indexPath.row] objectForKey:@"createtime"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置UITableview 选中返回时为不选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self showDialog:@"一键查询中..."];
    TcHistoryApi *historyApi = [[TcHistoryApi alloc]init];
    [historyApi fetchUserBuy:[[NSUserDefaults standardUserDefaults]objectForKey:NSUSERDEFAULT_USERID] :[[self.data[indexPath.row] objectForKey:@"rdid"] intValue] :^(NSURLSessionDataTask *task, id responseObject) {
        //
        if (responseObject) {
            
            NSNumber *code = [responseObject objectForKey:@"code"];
            
            if ([code intValue] ==200) {
                [self closeDlg];
                //跳转到详情界面
                
                NSLog(@"ook");
                
            }else{
                NSLog(@"eer");
                //提示用户需要购买
                [self MakeSuccessToast:@"购买才能查看"];
                //跳转到支付页面
                [self.navigationController pushViewController:[[TcPayViewController alloc]init] animated:YES];
                
            }
        }
    } :^(NSURLSessionDataTask *task, NSError *error) {
        //
        [self MakeToast:@"查询失败"];
    }];

}

-(int)getRandomNumber:(int)from to:(int)to{
    
    return (int)(from + (arc4random() % (to-from + 1)));
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
