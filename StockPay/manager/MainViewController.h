//
//  ViewController.h
//  wemall
//
//  Created by tjc1991 on 15-3-10.
//  Copyright (c) 2015年 ukmterm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TcStockViewController;
@class TcPayViewController;
@class TcGrailDetailViewController;

@interface MainViewController : UITabBarController<UIAlertViewDelegate>

@property(nonatomic,strong) TcPayViewController *payVcl;

//推送信息
@property(nonatomic,strong) NSArray *stockMsgArray;

//存放导航栏控制器
@property(nonatomic,strong) NSMutableArray *viewcontrollers;

@end

