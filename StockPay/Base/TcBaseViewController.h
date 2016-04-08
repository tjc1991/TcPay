//
//  TcBaseViewController.h
//  StockPay
//
//  Created by tjc1991 on 16/3/30.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TcBaseViewController : UIViewController

- (void)showDialog:(NSString*)msg;

- (void)closeDlg;

- (void)closeDialog:(BOOL)isSuccess withHint:(NSString*)msg;

- (void)MakeToast:(NSString*)hint;

- (void)MakeSuccessToast:(NSString*)hint;


@end
