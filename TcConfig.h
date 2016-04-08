//
//  TcConfig.h
//  StockPay
//
//  Created by tjc1991 on 16/4/1.
//  Copyright © 2016年 cldxk. All rights reserved.
//

#ifndef TcConfig_h
#define TcConfig_h

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

//HTTP块定义
typedef void (^successBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^failBlock)(NSURLSessionDataTask *task, NSError *error);


//MOB api
static NSString* const MOB_APPKEY = @"1129adaf0802e";
static NSString* const MOB_APPSECURT = @"cad81341d0fb3293571a0bc7e2b4a577";

//BMob
static NSString* const BMOB_APPKEY = @"d62efd2e129b5f91aa3ac1e7fedfacf0";

//通知

//服务器API地址
static NSString* const BASE_API_URL = @"http://192.168.0.101/jxjr/index.php/";
static NSString* const API_REGISTER_URL = @"http://192.168.0.101/jxjr/index.php/Admin/User/register";
static NSString* const API_LOGIN_URL = @"http://192.168.0.101/jxjr/index.php/Admin/User/login";
static NSString* const API_FETCHONE_RECORD_URL = @"http://192.168.0.101/jxjr/index.php/Admin/Record/getJxOneRecord";
static NSString* const API_CREATE_HISTORY_URL = @"http://192.168.0.101/jxjr/index.php/Admin/History/addJxHistory";



//NSUserDefault
static NSString* const NSUSERDEFAULT_USERID = @"userid";


#endif /* TcConfig_h */
