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


//129fa3eea427093a9b1ba4de3dae2ad03606f4d6

//HTTP块定义
typedef void (^successBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^failBlock)(NSURLSessionDataTask *task, NSError *error);


//MOB api
static NSString* const MOB_APPKEY = @"1129adaf0802e";
static NSString* const MOB_APPSECURT = @"cad81341d0fb3293571a0bc7e2b4a577";

//BMob
static NSString* const BMOB_APPKEY = @"d62efd2e129b5f91aa3ac1e7fedfacf0";

//通知
static NSString* const NOTOFY_FRESH_LIST = @"refreshLst";

//服务器API地址
static NSString* const BASE_API_URL = @"http://115.28.64.78//jxjr/index.php/";

static NSString* const API_REGISTER_URL = @"http://115.28.64.78/jxjr/index.php/Admin/User/register";

static NSString* const API_LOGIN_URL = @"http://115.28.64.78/jxjr/index.php/Admin/User/login";

static NSString* const API_FETCHONE_RECORD_URL = @"http://115.28.64.78/jxjr/index.php/Admin/Record/getJxOneRecord";

//获取所有推荐股票
static NSString* const API_FETCH_ALL_RECORD_URL = @"http://115.28.64.78/jxjr/index.php/Admin/Record/getJxAllRecord";


static NSString* const API_CREATE_HISTORY_URL = @"http://115.28.64.78/jxjr/index.php/Admin/History/addJxHistory";

static NSString* const API_FETCH_HISTORY_URL = @"http://115.28.64.78/jxjr/index.php/Admin/History/fetchJxRealHistory";

//根据ID查询用户是否购买过
static NSString* const API_FETCH_USERBUY_URL = @"http://115.28.64.78/jxjr/index.php/Admin/History/fetchJxUserById";

//修改昵称
static NSString* const API_CHANGE_USER_NICK_URL = @"http://115.28.64.78/jxjr/index.php/Admin/User/editJxUserNick";

//修改密码
static NSString* const API_RESET_USER_PWD_URL = @"http://115.28.64.78/jxjr/index.php/Admin/User/resetJxUserPwd";

//获取用户所有推荐股票详细信息
static NSString* const API_FETCH_ALL_USER_RECORD_URL = @"http://115.28.64.78/jxjr/index.php/Admin/Record/getJxAllRecordMsg";

//获取用户单只推荐股票详细信息
static NSString* const API_FETCH_USER_DETAIL_RECORD_URL = @"http://115.28.64.78/jxjr/index.php/Admin/History/fetchDetailMsgJxUserById";



//模拟器设置
//static NSString* const API_REGISTER_URL = @"http://localhost/jxjr/index.php/Admin/User/register";
//
//static NSString* const API_LOGIN_URL = @"http://localhost/jxjr/index.php/Admin/User/login";
//
//static NSString* const API_FETCHONE_RECORD_URL = @"http://localhost/jxjr/index.php/Admin/Record/getJxOneRecord";
//
//static NSString* const API_CREATE_HISTORY_URL = @"http://localhost/jxjr/index.php/Admin/History/addJxHistory";
//
//static NSString* const API_FETCH_HISTORY_URL = @"http://localhost/jxjr/index.php/Admin/History/fetchJxRealHistory";
//
////根据ID查询用户是否购买过
//static NSString* const API_FETCH_USERBUY_URL = @"http://localhost/jxjr/index.php/Admin/History/fetchJxUserById";
//
////获取所有推荐股票
//static NSString* const API_FETCH_ALL_RECORD_URL = @"http://localhost/jxjr/index.php/Admin/Record/getJxAllRecord";
//
////修改昵称
//static NSString* const API_CHANGE_USER_NICK_URL = @"http://localhost/jxjr/index.php/Admin/User/editJxUserNick";
//
////修改密码
//static NSString* const API_RESET_USER_PWD_URL = @"http://localhost/jxjr/index.php/Admin/User/resetJxUserPwd";
//
////获取用户所有推荐股票详细信息
//static NSString* const API_FETCH_ALL_USER_RECORD_URL = @"http://localhost/jxjr/index.php/Admin/Record/getJxAllRecordMsg";




//NSUserDefault
static NSString* const NSUSERDEFAULT_USERID = @"userid";

static NSString* const NSUSERDEFAULT_USER_NICK = @"usernick";

//股票或行情
static NSInteger const PUSH_TYPE_STOCK = 0;

static NSInteger const PUSH_TYPE_GRAIL = 1;

//分页数据定义,与服务端保持一致
static NSInteger const PAGE_COUNT = 10;








#endif /* TcConfig_h */
