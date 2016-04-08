//
//  TcRecordApi.h
//  StockPay
//
//  Created by tjc1991 on 16/4/8.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcBaseApi.h"

@interface TcRecordApi : TcBaseApi

- (void) fetchOneRecord: (NSUInteger)rdId :(successBlock)success :(failBlock)fail;


@end
