//
//  TcRecordApi.m
//  StockPay
//
//  Created by tjc1991 on 16/4/8.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#import "TcRecordApi.h"

@implementation TcRecordApi

- (void) fetchOneRecord: (NSUInteger)rdId :(successBlock)success :(failBlock)fail{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setObject:[NSNumber numberWithInteger:rdId] forKey:@"rdid"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:API_FETCHONE_RECORD_URL parameters:params success:success failure:fail];
    
}

- (void) fetchAllRecord: (NSInteger)page :(successBlock)success :(failBlock)fail{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    [params setObject:[NSNumber numberWithInteger:page] forKey:@"p"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:API_FETCH_ALL_RECORD_URL parameters:params success:success failure:fail];
}



@end
