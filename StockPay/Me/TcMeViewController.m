//
//  TcMeViewController.m
//  StockPay
//
//  Created by tjc1991 on 16/3/31.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcMeViewController.h"
#import "TcLoginViewController.h"
#import "BaseNavigationViewController.h"
#import "TcEditNickViewController.h"
#import "TcBuyRecordViewController.h"
#import "TcResetPwdViewController.h"
#import "TcAboutMeViewController.h"

@interface TcMeViewController ()

@end

@implementation TcMeViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.title = @"我的";
        self.data = [NSMutableArray arrayWithCapacity:2];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadData];
}

-(void)viewDidAppear:(BOOL)animated{
    
    NSString *nick = [[NSUserDefaults standardUserDefaults]objectForKey:NSUSERDEFAULT_USER_NICK];
    
    self.userNickLb.text = (nick == nil || [nick isEqual:@""])?@"小V1号":nick;
}

- (void)loadData{
    
    self.userPhoneLb.text = [[NSUserDefaults standardUserDefaults]objectForKey:NSUSERDEFAULT_USERID];
    
    //加载数据
    
    NSArray *appicos = @[@"editnick.png",@"dn.png",@"resetpwd.png",@"aboutme.png"];
    
    NSArray *descstrs = @[@"修改昵称",@"我的记录",@"重置密码",@"关于我们"];
    
    for (int i=0; i<appicos.count; i++) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:appicos[i],@"img",descstrs[i],@"desc", nil];
        
        [self.data addObject:dic];
    }
    
    [self.tablewview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    //刷新Tableview
    [self.tablewview reloadData];
    
}


- (IBAction)logOutAction:(id)sender {
    
    //清除NSUserDefault
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:NSUSERDEFAULT_USERID];
    [self MakeSuccessToast:@"注销成功"];
    //跳转到登陆界面
    TcLoginViewController *login = [[TcLoginViewController alloc]init];
    [self presentViewController:login animated:YES completion:nil];
    
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdenfy];
    }
    
    cell.imageView.image = [UIImage imageNamed:[self.data[indexPath.row] objectForKey:@"img"]];
    cell.textLabel.text  = [self.data[indexPath.row] objectForKey:@"desc"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置UITableview 选中返回时为不选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            TcEditNickViewController *editNickVcl = [[TcEditNickViewController alloc]init];
            [self.navigationController pushViewController:editNickVcl animated:YES];

        }
            break;
            
        case 1:
        {
            TcBuyRecordViewController *buyVcl = [[TcBuyRecordViewController alloc]init];
            [self.navigationController pushViewController:buyVcl animated:YES];
            
        }
            break;
            
        case 2:
        {
            TcResetPwdViewController *resetPwdVcl = [[TcResetPwdViewController alloc]init];
            [self.navigationController pushViewController:resetPwdVcl animated:YES];
            
        }
            break;
            
        case 3:
        {
            TcAboutMeViewController *aboutVcl = [[TcAboutMeViewController alloc]init];
            [self.navigationController pushViewController:aboutVcl animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
