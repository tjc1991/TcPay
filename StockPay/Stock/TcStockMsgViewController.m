//
//  TcStockMsgViewController.m
//  StockPay
//
//  Created by tjc1991 on 16/4/10.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcStockMsgViewController.h"
#import "TcHistoryApi.h"

@interface TcStockMsgViewController ()

@end

@implementation TcStockMsgViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.title = @"股票详情";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    scroller.backgroundColor = [UIColor whiteColor];
    
    self.timetLb = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-200)/2, 10, 200, 25)];
    self.timetLb.textColor = UIColorFromRGB(0x13EAA4);
    self.timetLb.font = [UIFont systemFontOfSize:20.0f];

    [scroller addSubview:self.timetLb];
    
    UIView *sepView = [[UIView alloc]initWithFrame:CGRectMake(18, self.timetLb.bottom+5, ScreenWidth-36, 1)];
    sepView.backgroundColor = UIColorFromRGB(0x13EAA4);
    
    [scroller addSubview:sepView];
    
    self.contentLb = [[UILabel alloc]initWithFrame:CGRectMake(18, self.timetLb.bottom+10, ScreenWidth-36, 25)];
    [self.contentLb setNumberOfLines:0];
    self.contentLb.lineBreakMode = NSLineBreakByWordWrapping;//换行方式
    
    [scroller addSubview:self.contentLb];
    
    [self.view addSubview:scroller];
    
    [self loadData];
    
    
    
}

-(void)loadData{
    
    [self showDialog:@"一键查询中..."];
    TcHistoryApi *historyApi = [[TcHistoryApi alloc]init];
    [historyApi fetchUserBuyDetails:[[NSUserDefaults standardUserDefaults]objectForKey:NSUSERDEFAULT_USERID] :self.rdid :^(NSURLSessionDataTask *task, id responseObject) {
        //
        
        //NSLog(@"-->%@",responseObject);
        if (responseObject) {
            
            NSNumber *code = [responseObject objectForKey:@"code"];
            
            if ([code intValue] ==200) {
                [self closeDlg];
                
                //更新UILabel大小
                NSString *content = [[responseObject objectForKey:@"data"] objectForKey:@"content"];
                NSString *time = [[responseObject objectForKey:@"data"] objectForKey:@"createtime"];
                
                if (nil != time && nil != content) {
                    self.timetLb.text = time;
                    
                    self.contentLb.text = content;
                    
                    CGSize size = CGSizeMake(self.contentLb.width,2000);//LableWight标签宽度，固定的
                    //计算实际frame大小，并将label的frame变成实际大小
                    
                    CGSize labelsize = [self.contentLb.text sizeWithFont:self.contentLb.font constrainedToSize:size lineBreakMode:self.contentLb.lineBreakMode];
                    [self.contentLb setFrame:CGRectMake(18, self.timetLb.bottom+18, labelsize.width, labelsize.height)];
                }
                
            }else{
                //提示用户需要购买
                [self MakeToast:@"信息查询失败"];
            
            }
        }
    } :^(NSURLSessionDataTask *task, NSError *error) {
        //
        [self MakeToast:@"信息查询失败"];
        NSLog(@"-->%@",error);
    }];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
