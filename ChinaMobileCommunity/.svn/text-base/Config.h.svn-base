//
//  Config.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-16.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#ifndef ChinaMobileCommunity_Config_h
#define ChinaMobileCommunity_Config_h
#endif

#define k_tagTwo 2000
//#define kAPI_Main @"http://192.168.1.11:8301" //新的测试接口
//#define kAPI_Main @"http://119.254.103.90:8301"//线上测试接口
#define kAPI_Main @"http://uc.api.cnsqk.com:8401"//最新线上测试接口
//#define kAPI_Main @"http://uc.api.hubei114.cn:8101"//最新线上测试接口

//#define kAPI_Main @"http://119.254.103.90:8301"
#define k_secretkey @"d3e378f164f10d97e9ee609feec3aa8d"

#define k_coordx [NSString stringWithFormat:@"%f",[CMCUserManager shareManager].longitude]
#define k_coordy [NSString stringWithFormat:@"%f",[CMCUserManager shareManager].latitude]
//#define kAPI_Main @"http://58.53.199.98:8101" //电信
//#define kAPI_Main @"http://192.168.1.11:8221"//内网
#define k_font(font) [UIFont systemFontOfSize:font]  //字体字号
#define k_color(color) [UIColor colorWithHexString:color]//字体颜色
//获取app版本号
#define APPVersion   [[[NSBundle mainBundle ] infoDictionary] objectForKey:@"CFBundleVersion"]
//取出的服务项目
#define kAPI_Service  [[NSUserDefaults standardUserDefaults] objectForKey:@"service"]
//取出缓存到本地的所有物业地址的数组
#define kAPI_Property [[NSUserDefaults standardUserDefaults] objectForKey:@"property"]

//取出十大行业的id和名称
#define kAPI_Trade [[NSUserDefaults standardUserDefaults] objectForKey:@"trade"]

//取出切换的物业地址的字典(下一次登陆切换到物业首页的话,还是这个地址)
#define k_propertyAddress [[NSUserDefaults standardUserDefaults] objectForKey:@"propertyAddress"]

//获取缓存的city_id
#define k_city_id [[NSUserDefaults standardUserDefaults] objectForKey:@"city_id"]

//获取缓存的zid
#define k_zid [[NSUserDefaults standardUserDefaults] objectForKey:@"zid"]

//获取缓存的password
#define k_password [[NSUserDefaults standardUserDefaults] objectForKey:@"password"]

//获取缓存的phone

#define k_phone [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"]

//获取订单状态
#define k_order [[NSUserDefaults standardUserDefaults] objectForKey:@"order"]


#define kAPI_channel @"f3243a756a6d37ea6fdb0a8687cd1634"
#define KAPI_NewChannel  @"4804e98460974d5cbd477ff72420ac0e"
#define kAPI_timestamp [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]]
//#define kAPI_NotifyURL @"http://121.42.10.81:8104/notify/1/" //支付宝的回调url
#define kAPI_NotifyURL [CMCUserManager shareManager].alipay
//#define kAPI_WingPayNotifyURL @"http://121.42.10.81:8104/notify/3/"//翼支付的回调url
#define kAPI_WingPayNotifyURL [CMCUserManager shareManager].bestpay
#define kAPI_Device @"2f27725cc48a642c5d98ff863b2928318e6a337c5428652e09fecbacb6ae8a65" //外网
//#define kAPI_Device  @"58bca76f27829c1fc189e6a3b30696dd7a13533ffa17dcf3552033ee84545de3" //内网
//#define kAPI_Device @"b54beebb3a352a6f496f522ddfeddef0dd7c27872a47ff1140fc9a59b3dd6f4d"
#define kAPI_City [[NSUserDefaults standardUserDefaults] objectForKey:@"city"]
#define kAPI_AllMainColor [UIColor colorWithHexString:@"f6ad12"] //整体的颜色
#define KAPI_lineColor [UIColor colorWithHexString:@"ededed"] //自定义cell线的颜色
//翼支付的数据key
#define KEY @"36F4EF70FFF1288A4422A15D3EC8A4882A1A7FE4EA1E5163"
//翼支付交易key
#define PSWD @"341316"
//商户号
#define MERCHANTID @"01420103041482000"

#define kAPI_image @"http://192.168.1.11:8221/"
#define kAPI_loc_entry  [CMCUserManager shareManager].loc_entry
//#define kAPI_loc_entry  @"http://192.168.1.11:8222"

#define KAPI_GetSIG(dic)  [BaseUtil md5:[Helper getSigWithArray:dic]]

#define kAPI_color [UIColor colorWithHexString:@"dff1f7"]


//判断是否为iOS7
#define IS_iOS7 ((floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1))

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define IS_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否为iPad
#define IS_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//广告
#define kAPI_GetImage(path) [NSString stringWithFormat:@"%@/static/%@",kAPI_Main,path]

#define IS_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//**************优惠专区********************
#define KAPI_couponzone(token,tag,type,page,nums,timestamp,sig)  [[NSString stringWithFormat:@"%@/user/couponzone?channel=%@&token=%@&app_ver=%@&tag=%@&type=%@&page=%@&nums=%@&timestamp=%@&sig=%@",kAPI_Main,KAPI_NewChannel,token,APPVersion,tag,type,page,nums,timestamp,sig] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

//**********************************************************************
//商户的优惠券列表
#define KAPI_MerchantCoupon(mid,timestamp,sig)  [NSString stringWithFormat:@"%@/open/merchantcoupon?channel=%@&app_ver=%@&mid=%@&timestamp=%@&sig=%@",kAPI_Main,KAPI_NewChannel,APPVersion,mid,timestamp,sig]
//下载打折券

#define KAPI_DownCoupon(token,timestamp,sig,coupon_id)  [NSString stringWithFormat:@"%@/user/downcoupon?channel=%@&app_ver=%@&token=%@&timestamp=%@&sig=%@&coupon_id=%@",kAPI_Main,KAPI_NewChannel,APPVersion,token,timestamp,sig,coupon_id]

//第一次访客登录
#define KAPI_guestlogin(coord_x,coord_y,timestamp,sig,city_id) [NSString stringWithFormat:@"%@/user/guestlogin?channel=%@&coord_x=%@&coord_y=%@&timestamp=%@&sig=%@&app_ver=%@&city_id=%@",kAPI_Main,KAPI_NewChannel,coord_x,coord_y,timestamp,sig,APPVersion,city_id]
//第二次访客登录
//#define KAPI_userGuestlogin [NSString stringWithFormat:@"%@/user/guestlogin",kAPI_loc_entry]
#define KAPI_userGuestlogin(coord_x,coord_y,timestamp,sig) [NSString stringWithFormat:@"%@/user/guestlogin?channel=%@&app_ver=%@&coord_x=%@&coord_y=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,coord_x,coord_y,timestamp,sig]



//注册
#define KAPI_Register(coord_x,coord_y,phone,password,timestamp,sig,device,code) [NSString stringWithFormat:@"%@/user/reg?channel=%@&coord_x=%@&coord_y=%@&phone=%@&password=%@&timestamp=%@&sig=%@&sys=1&device=%@&code=%@&app_ver=%@",kAPI_Main,KAPI_NewChannel,coord_x,coord_y,phone,password,timestamp,sig,device,code,APPVersion]
//登录
#define KAPI_Login(coord_x,coord_y,phone,password,timestamp,sig,sys,device) [NSString stringWithFormat:@"%@/user/login?channel=%@&coord_x=%@&coord_y=%@&phone=%@&password=%@&timestamp=%@&sig=%@&sys=%@&device=%@&app_ver=%@",kAPI_Main,KAPI_NewChannel,coord_x,coord_y,phone,password,timestamp,sig,sys,device,APPVersion]
//有坐标,有缓存的city_id和zid,phone,password 用户登录
#define KAPI_NewUserLogin(coord_x,coord_y,phone,password,timestamp,sig,sys,device,city_id) [NSString stringWithFormat:@"%@/user/login?channel=%@&coord_x=%@&coord_y=%@&phone=%@&password=%@&timestamp=%@&sig=%@&sys=%@&device=%@&app_ver=%@&city_id=%@",kAPI_Main,KAPI_NewChannel,coord_x,coord_y,phone,password,timestamp,sig,sys,device,APPVersion,city_id]

//第二次登录
#define KAPI_userLogin(token,zid,coord_x,coord_y,timestamp,sig) [NSString stringWithFormat:@"%@/user/login?channel=%@&app_ver=%@&token=%@&zid=%@&coord_x=%@&coord_y=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,token,zid,coord_x,coord_y,timestamp,sig]

//登录   忘记密码
#define KAPI_smsresetpass(timestamp,phone,sig) [NSString stringWithFormat:@"%@/user/smsresetpass?channel=%@&timestamp=%@&phone=%@&sig=%@&app_ver=%@",kAPI_Main,KAPI_NewChannel,timestamp,phone,sig,APPVersion]
//登录   验证码设置新密码
#define KAPI_resetpassbycode(timestamp,phone,code,newpass,sig) [NSString stringWithFormat:@"%@/user/resetpassbycode?channel=%@&timestamp=%@&phone=%@&code=%@&newpass=%@&sig=%@&app_ver=%@",kAPI_Main,KAPI_NewChannel,timestamp,phone,code,newpass,sig,APPVersion]
//社区首页
#define KAPI_zone(sig,zid) [NSString stringWithFormat:@"%@/zone/index?channel=%@&timestamp=%@&app_ver=%@&sig=%@&zid=%@",kAPI_loc_entry,KAPI_NewChannel,timestamp,APPVersion,sig,zid]


//切换城市获取社区列表
#define kAPI_getCity [NSString stringWithFormat:@"%@/index/city",kAPI_loc_entry]
#define KAPI_GetCityList(sig,timestamp) [NSString stringWithFormat:@"%@/user/getcitylist?channel=%@&app_ver=%@&timestamp=%@&sig=%@",kAPI_Main,KAPI_NewChannel,APPVersion,timestamp,sig]

#define KAPI_GetAreaList(city_id,search,page,nums,timestamp,sig) [NSString stringWithFormat:@"%@/zone/list?channel=%@&app_ver=%@&city_id=%@&search=%@&page=%@&nums=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,city_id,search,page,nums,timestamp,sig]

//首页搜索
#define kAPI_getSearch [NSString stringWithFormat:@"%@/index/search",kAPI_loc_entry]

//获取首页bana上的图片
#define KAPI_index(timestamp,sig,token,tenement,id) [NSString stringWithFormat:@"%@/index/index?channel=f3243a756a6d37ea6fdb0a8687cd1634&timestamp=%@&sig=%@&tenement=%@&id=%@",kAPI_Main,timestamp,sig,tenement,id]
//获取物业版的广告图片
//#define KAPI_propertyIndex [NSString stringWithFormat:@"%@/property/index",kAPI_loc_entry]
//获取物业首页
#define KAPI_propertyIndex(token,zid,timestamp,sig) [NSString stringWithFormat:@"%@/property/index?channel=%@&app_ver=%@&token=%@&zid=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,token,zid,timestamp,sig]


//获取指定商铺信息
#define kAPI_getmerchantnews [NSString stringWithFormat:@"%@/merchant/detail",kAPI_loc_entry]
#define KAPI_GetSig(dic)  [BaseUtil md5:[BaseUtil getSigWithArray:dic]]






//商户首页
#define KAPI_MerchantDetail(mid,sig)  [NSString stringWithFormat:@"%@/merchant/detail?channel=%@&app_ver=%@&mid=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,mid,[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]],sig]

//商户首页用户评论列表
#define KAPI_EvaluateList(mid,page,nums,timestamp,sig)  [NSString stringWithFormat:@"%@/evaluate/list?channel=%@&app_ver=%@&mid=%@&page=%@&nums=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,mid,page,nums,timestamp,sig]


//商户商品列表
#define KAPI_MerchantGoodsList(mid,type_id,page,nums,sig,service_id)  [NSString stringWithFormat:@"%@/merchant/goodslist?channel=%@&app_ver=%@&mid=%@&type_id=%@&page=%@&nums=%@&timestamp=%@&sig=%@&service_id=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,mid,type_id,page,nums,[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]],sig,service_id]



//商品详情
//#define KAPI_MerchantGoodDetail(mid,id,sig)  [NSString stringWithFormat:@"%@/merchant/goodsdetail?channel=%@&app_ver=%@&mid=%@&id=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,mid,id,[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]],sig]

//******************************物业*************************************************
//我的物业缴费订单
#define KAPI_mypropertyorder(timestamp,sig,token,owner_id,type,page,nums) [NSString stringWithFormat:@"%@/user/mypropertyorder?channel=%@&timestamp=%@&sig=%@&token=%@&app_ver=%@&owner_id=%@&type=%@&page=%@&nums=%@",kAPI_Main,KAPI_NewChannel,timestamp,sig,token,APPVersion,owner_id,type,page,nums]
//物业缴费订单支付
#define KAPI_propertyorderpay(timestamp,sig,token,order_id,payment) [NSString stringWithFormat:@"%@/user/propertyorderpay?channel=%@&timestamp=%@&sig=%@&token=%@&app_ver=%@&order_id=%@&payment=%@",kAPI_Main,KAPI_NewChannel,timestamp,sig,token,APPVersion,order_id,payment]
//物业详情
#define KAPI_adviceinfo(advice_id,token,timestamp,sig) [NSString stringWithFormat:@"%@/property/adviceinfo?channel=%@&app_ver=%@&advice_id=%@&token=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,advice_id,token,timestamp,sig]
//物业评价
#define KAPI_propertyaddeval(token,zid,one,two,three,four,five,timestamp,sig) [NSString stringWithFormat:@"%@/property/addeval?channel=%@&app_ver=%@&token=%@&zid=%@&one=%@&two=%@&three=%@&four=%@&five=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,token,zid,one,two,three,four,five,timestamp,sig]
//获取物业评价数据
#define KAPI_geteval(token,zid,timestamp,sig) [NSString stringWithFormat:@"%@/property/geteval?channel=%@&app_ver=%@&token=%@&zid=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,token,zid,timestamp,sig]



//************************************************************************************

//获取用户信息
#define KAPI_getuserinfo(timestamp,sig,token) [NSString stringWithFormat:@"%@/user/getuserinfo?channel=%@&timestamp=%@&sig=%@&token=%@&app_ver=%@",kAPI_Main,KAPI_NewChannel,timestamp,sig,token,APPVersion]


//获取修改的用户信息
#define KAPI_getModelUserinfo(timestamp,sig,token,type,value) [NSString stringWithFormat:@"%@/user/userinfo?channel=%@&timestamp=%@&sig=%@&token=%@&type=%@&value=%@&app_ver=%@",kAPI_Main,KAPI_NewChannel,timestamp,sig,token,type,value,APPVersion] 
//我的设置 物业地址
#define KAPI_myproperty(timestamp,sig,token) [NSString stringWithFormat:@"%@/user/myproperty?channel=%@&timestamp=%@&sig=%@&token=%@&app_ver=%@",kAPI_Main,KAPI_NewChannel,timestamp,sig,token,APPVersion]

//获取水电费
#define KAPI_GetPropertyFeelifeSig(address,mobile_phone,token,type) [NSString stringWithFormat:@"address=%@channel=f3243a756a6d37ea6fdb0a8687cd1634mobile_phone=%@timestamp=%@token=%@type=%@e475d767f473d67e9cb8e351040b02da",address,mobile_phone,kAPI_timestamp,token,type]
#define KAPI_GetPropertyFeelife(address,mobile_phone,token,sig,type) [NSString stringWithFormat:@"%@/property/feelife?address=%@&channel=f3243a756a6d37ea6fdb0a8687cd1634&mobile_phone=%@&timestamp=%@&token=%@&sig=%@&type=%@",kAPI_Main,address,mobile_phone,[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]],token,sig,type]

//物业报修投诉列表
#define KAPI_propertyComplain(token,zid,type,genre,content,timestamp,sig) [NSString stringWithFormat:@"%@/property/advice?channel=%@&app_ver=%@&token=%@&zid=%@&type=%@&genre=%@&content=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,token,zid,type,genre,content,timestamp,sig]
//物业 简介

#define KAPI_propertyIntro(token,zid,timestamp,sig) [NSString stringWithFormat:@"%@/property/intro?channel=%@&app_ver=%@&token=%@&zid=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,token,zid,timestamp,sig]


//获取点菜
#define KAPI_Getscategory [NSString stringWithFormat:@"%@/merchant/goodscategory",kAPI_loc_entry]
// 折扣券type = 1 代金券 type=2  store_id
#define kAPI_getCouponList [NSString stringWithFormat:@"%@/coupon/getcouponlist",kAPI_loc_entry]
//首页 预订
#define KAPI_GetMyAddreserve(token,sig,category_id,comment,desknum,peoplenum,reservephone,reservetime,sex,store_id,type,username) [NSString stringWithFormat:@"%@/reserve/addreserve?channel=f3243a756a6d37ea6fdb0a8687cd1634&timestamp=%@&token=%@&sig=%@&category_id=%@&comment=%@&desknum=%@&peoplenum=%@&reservephone=%@&reservetime=%@&sex=%@&store_id=%@&type=%@&username=%@",kAPI_Main,[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]],token,sig,category_id,comment,desknum,peoplenum,reservephone,reservetime,sex,store_id,type,username]
//获取精品推荐
#define KAPI_GetExcuse [NSString stringWithFormat:@"%@/merchant/excuse",kAPI_loc_entry]
//获取banna上的数据

//获取短信验证码
#define KAPI_Regsmscode(timestamp,sig,phone) [NSString stringWithFormat:@"%@/user/regsmscode?channel=%@&timestamp=%@&sig=%@&phone=%@&app_ver=%@",kAPI_Main,KAPI_NewChannel,timestamp,sig,phone,APPVersion]



//优惠详情
#define kAPI_getCouponDetail(coupon_id,timestamp,sig) [[NSString stringWithFormat:@"%@/open/coupondetail?channel=%@&app_ver=%@&coupon_id=%@&timestamp=%@&sig=%@",kAPI_Main,KAPI_NewChannel,APPVersion,coupon_id,timestamp,sig] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
//优惠券下载
#define kAPI_getCouponBuy [NSString stringWithFormat:@"%@/coupon/buy",kAPI_loc_entry]

//获取商品

#define KAPI_Getgoods [NSString stringWithFormat:@"%@/merchant/goods",kAPI_loc_entry]
//点击后退按钮提交购物车
#define KAPI_GetSubmitorder [NSString stringWithFormat:@"%@/user/submitorder",kAPI_loc_entry]
//提交外卖
#define KAPI_GetTakeoutInfo [NSString stringWithFormat:@"%@/user/gettakeoutinfo",kAPI_loc_entry]


//物业
//添加物业评分

#define KAPI_Addappraise [NSString stringWithFormat:@"%@/property/addappraise",kAPI_loc_entry]
//添加地址
#define KAPI_Addaddress(address,phone,name,timestamp,token,sig) [NSString stringWithFormat:@"%@/user/addaddress?address=%@&channel=%@&phone=%@&name=%@&timestamp=%@&token=%@&sig=%@&app_ver=%@",kAPI_Main,address,KAPI_NewChannel,phone,name,timestamp,token,sig,APPVersion]

//我的收货地址
#define KAPI_Myaddress(timestamp,token,sig) [NSString stringWithFormat:@"%@/user/myaddress?channel=%@&timestamp=%@&token=%@&sig=%@&app_ver=%@",kAPI_Main,KAPI_NewChannel,timestamp,token,sig,APPVersion]

//编辑收货地址
#define KAPI_EditAddress(address,address_id,phone,name,token,sig) [NSString stringWithFormat:@"%@/user/editaddress?address=%@&channel=%@&address_id=%@&phone=%@&name=%@&timestamp=%@&token=%@&sig=%@&app_ver=%@",kAPI_Main,address,KAPI_NewChannel,address_id,phone,name,timestamp,token,sig,APPVersion] 
//删除收货地址
#define KAPI_Deladdress(address_id,timestamp,token,sig) [NSString stringWithFormat:@"%@/user/deladdress?channel=%@&address_id=%@&timestamp=%@&token=%@&sig=%@&app_ver=%@",kAPI_Main,KAPI_NewChannel,address_id,timestamp,token,sig,APPVersion]
//*************************我的*********************************

//我的券包
#define kAPI_getMycoupon(token,sig,type,page,nums) [NSString stringWithFormat:@"%@/user/mycoupon?channel=%@&timestamp=%@&token=%@&sig=%@&app_ver=%@&type=%@&page=%@&nums=%@",kAPI_Main,KAPI_NewChannel,timestamp,token,sig,APPVersion,type,page,nums]
//我的预订
#define kAPI_getMyReserve(token,sig) [NSString stringWithFormat:@"%@/reserve/myreserve?channel=f3243a756a6d37ea6fdb0a8687cd1634&timestamp=%@&token=%@&sig=%@",kAPI_Main,[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]],token,sig]

//我的活动  活动列表
#define kAPI_myactilist(token,city_id,timestamp,zid,sig) [NSString stringWithFormat:@"%@/user/myactilist?channel=%@&token=%@&app_ver=%@&city_id=%@&timestamp=%@&zid=%@&sig=%@",kAPI_Main,KAPI_NewChannel,token,APPVersion,city_id,timestamp,zid,sig]
//我的活动 活动详情
#define kAPI_myactiinfo(timestamp,suid,id,sig) [NSString stringWithFormat:@"%@/activities/myactiinfo?channel=f3243a756a6d37ea6fdb0a8687cd1634&timestamp=%@&suid=%@&id=%@&sig=%@",kAPI_Main,timestamp,suid,id,sig]
//我的活动 提交评价
#define kAPI_upevaluate(timestamp,suid,id,sig,description) [NSString stringWithFormat:@"%@/activities/upevaluate?channel=f3243a756a6d37ea6fdb0a8687cd1634&timestamp=%@&suid=%@&id=%@&sig=%@&description=%@",kAPI_Main,timestamp,suid,id,sig,description]
//我的活动 我也说一句
#define kAPI_evaluateinfo(token,id,sig,content) [NSString stringWithFormat:@"%@/user/upevaluate?channel=%@&token=%@&app_ver=%@&id=%@&sig=%@&content=%@",kAPI_Main,KAPI_NewChannel,token,APPVersion,id,sig,content]

#define KAPI_headpic [NSString stringWithFormat:@"%@/user/headpic",kAPI_Main]
//上传投诉报修图片
#define KAPI_AdviceImage [NSString stringWithFormat:@"%@/property/adviceimage",kAPI_loc_entry]

#define KAPI_advicelist(token,zid,type,page,nums,timestamp,sig) [NSString stringWithFormat:@"%@/property/advicelist?channel=%@&app_ver=%@&token=%@&zid=%@&type=%@&page=%@&nums=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,token,zid,type,page,nums,timestamp,sig]

//我的订单
#define kAPI_getMyorder(timestamp,token,sig,page,nums) [NSString stringWithFormat:@"%@/user/myorder?channel=%@&timestamp=%@&token=%@&sig=%@&app_ver=%@&page=%@&nums=%@",kAPI_Main,KAPI_NewChannel,timestamp,token,sig,APPVersion,page,nums]

//我的订单  订单详情
#define kAPI_getMyorderDetail(timestamp,token,sig,order_id) [NSString stringWithFormat:@"%@/user/orderdetail?channel=%@&timestamp=%@&token=%@&sig=%@&order_id=%@&app_ver=%@",kAPI_loc_entry,KAPI_NewChannel,timestamp,token,sig,order_id,APPVersion]
//提交订单
#define KAPI_UserNewOrder [NSString stringWithFormat:@"%@/user/neworder",kAPI_loc_entry]

//我的   用户评价
#define kAPI_getMyorderUsereva(timestamp,token,sig,order_id,evaluate_content,evaluate_taste,evaluate_speed,evaluate_serve) [NSString stringWithFormat:@"%@/order/usereva?channel=f3243a756a6d37ea6fdb0a8687cd1634&timestamp=%@&token=%@&sig=%@&order_id=%@&evaluate_content=%@&evaluate_taste=%@&evaluate_speed=%@&evaluate_serve=%@",kAPI_Main,timestamp,token,sig,order_id,evaluate_content,evaluate_taste,evaluate_speed,evaluate_serve]
//短信分享apk
#define kAPI_smsshare(timestamp,token,sig,phone) [NSString stringWithFormat:@"%@/user/smsshare?channel=f3243a756a6d37ea6fdb0a8687cd1634&timestamp=%@&token=%@&sig=%@&phone=%@",kAPI_Main,timestamp,token,sig,phone]


//修改密码
#define kAPI_getChangepass(timestamp,token,sig,password,newpass) [NSString stringWithFormat:@"%@/user/changepass?channel=%@&timestamp=%@&token=%@&sig=%@&password=%@&newpass=%@&app_ver=%@",kAPI_Main,KAPI_NewChannel,timestamp,token,sig,password,newpass,APPVersion]
//取消预订
#define KAPI_Clearreserve(timestamp,sig,rid,token) [NSString stringWithFormat:@"%@/reserve/clearreserve?channel=f3243a756a6d37ea6fdb0a8687cd1634&timestamp=%@&sig=%@&rid=%@&token=%@",kAPI_Main,timestamp,sig,rid,token]


//物业费
#define kAPI_getFeepark(timestamp,token,sig,type,address,mobile_phone) [NSString stringWithFormat:@"%@/property/feepark?channel=f3243a756a6d37ea6fdb0a8687cd1634&timestamp=%@&token=%@&sig=%@&type=%@&address=%@&mobile_phone=%@",kAPI_Main,timestamp,token,sig,type,address,mobile_phone]

#define kAPI_getOrderFeepark(timestamp,token,sig,mobile_phone,type,address,center_id,id,price,number) [NSString stringWithFormat:@"%@/property/getlife?channel=f3243a756a6d37ea6fdb0a8687cd1634&timestamp=%@&token=%@&sig=%@&mobile_phone=%@&type=%@&address=%@&center_id=%@&id=%@&price=%@&number=%@",kAPI_Main,timestamp,token,sig,mobile_phone,type,address,center_id,id,price,number]
//添加物业评分

#define KAPI_Getappraise [NSString stringWithFormat:@"%@/property/getappraise",kAPI_loc_entry]



//*********************************************************************


#define kAPI_getCommunity(city_id) [[NSString stringWithFormat:@"%@/api/area/getAreaList?city_id=%@",kAPI_Main,city_id] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
//获取验证码
//#define kAPI_GetCode(num) [NSString stringWithFormat:@"http://www.cnsqk.com/api.php?__fn=verification_code&phoneNumber=%@",num]



//修改个人信息
#define kAPI_ChangeUserInfo(uid,type,value) [[NSString stringWithFormat:@"%@/api/Index/edituserinfos?uid=%@&type=%@&value=%@",kAPI_Main,uid,type,value]stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]



#define Login_In  @"登录"


//修改个人姓名
#define kAPI_ModifyName(uid,rname) [NSString stringWithFormat:@"%@/api/Index/edituserinfos?uid=%@&type=rname&value=%@",kAPI_Main,uid,rname]
//修改生日
#define kAPI_birthDay(uid,birthday) [NSString stringWithFormat:@"%@/api/Index/edituserinfos?uid=%@&type=birthday&value=%@",kAPI_Main,uid,birthday]
//修改个性签名
#define kAPI_personal(uid,personal) [NSString stringWithFormat:@"%@/api/Index/edituserinfos?uid=%@&type=personal&value=%@",kAPI_Main,uid,personal]
//修改昵称
#define kAPI_nname(uid,nname) [NSString stringWithFormat:@"%@/api/Index/edituserinfos?uid=%@&type=nname&value=%@",kAPI_Main,uid,nname] 
//修改性别
#define kAPI_Sex(uid,value) [NSString stringWithFormat:@"%@/api/Index/edituserinfos?uid=%@&type=sex&value=%@",kAPI_Main,uid,value] 
//获取个人信息
#define kAPI_getOnesinfo(uid) [NSString stringWithFormat:@"%@/api/Index/getOnesinfo?uid=%@",kAPI_Main,uid] 


//可使用 已使用 已过期

#define kAPI_getMycouponStatus(uid,type,status) [[NSString stringWithFormat:@"%@/api/mycoupon/getMycoupon?uid=%@&type=%@&status=%@",kAPI_Main,uid,type,status] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]

//关于我们
#define kAPI_aboutUs [[NSString stringWithFormat:@"%@/api/index/aboutus",kAPI_Main] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
//设置里的物业地址
#define kAPI_set_getaddress(phone) [[NSString stringWithFormat:@"%@/api/Payproperty/getaddress?phone=%@",kAPI_Main,phone] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]





//***************************首页*****************************************
//获取商户类型  button

//#define kAPI_getMerchantCategory [[NSString stringWithFormat:@"%@/api/merchant/getCategory",kAPI_Main] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
//获取精品推荐数据
//
//#define kAPI_getMerchantExcuse [[NSString stringWithFormat:@"%@/api/Merchant/excuse?center_id=7",kAPI_Main] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
//@"http://192.168.1.11:8201/api/merchant/getMerchantType?type_id=1&type=taste"
#define kAPI_getMerchantType(type_id,type) [[NSString stringWithFormat:@"%@/api/merchant/getMerchantType?type_id=%@&type=%@",kAPI_Main,type_id,type] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
//获取商铺详情页
//口味 速度 服务  默认 0 0 0
#define kAPI_getMerchantTasteType(type_id,taste,speed,serve) [[NSString stringWithFormat:@"%@/api/merchant/getMerchantType?type_id=%@&taste=%@&speed=%@&serve=%@",kAPI_Main,type_id,taste,speed,serve] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
//#define kAPI_getMerchantType(type_id,page) [[NSString stringWithFormat:@"%@/api/merchant/getMerchantType?type_id=%@&page=%@",kAPI_Main,type_id,page] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
//获取指定商铺信息 店铺详情
//#define kAPI_getMerchantNews(id) [[NSString stringWithFormat:@"%@/api/merchant/getMerchantNews?id=%@",kAPI_Main,id] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
//获取评价
#define kAPI_getEvaluateList(id) [[NSString stringWithFormat:@"%@/api/Evaluate/getEvaluate?id=%@",kAPI_Main,id] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]




//获取图片
#define kAPI_getImage(Img) [NSString stringWithFormat:@"%@/@",kAPI_Main,Img]

#define kAPI_getScategroy(store_id) [[NSString stringWithFormat:@"%@/api/Scategroy/getScategroy?store_id=%@",kAPI_Main,store_id] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
//点餐之后点击提交
#define kAPI_getReserveadd [NSString stringWithFormat:@"%@/api/reserve/reserveadd",kAPI_Main]
//点击后退按钮提交购物车
//#define kAPI_addgoodstobuycar [NSString stringWithFormat:@"%@/api/buycar/addgoodstobuycar",kAPI_Main]
//点击买单  post提交
#define kAPI_NewAddorder [NSString stringWithFormat:@"%@/api/order/addorder",kAPI_Main]
//http://192.168.1.250/cc/index.php/api/reserve/reserveadd
//预订 post服务器
#define kAPI_NewReserveadd [NSString stringWithFormat:@"%@/api/reserve/reserveadd",kAPI_Main]

//外卖
#define kAPI_gettakeout(store_id) [[NSString stringWithFormat:@"%@/api/takeout/gettakeout?store_id=%@&takeout=2",kAPI_Main,store_id] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
//外卖的提交订单
#define kAPI_addorder [NSString stringWithFormat:@"%@/api/order/addorder",kAPI_Main]

//我的购物车
#define kAPI_mybuycarlist(user_id,shop_id) [[NSString stringWithFormat:@"%@/api/buycar/mybuycarlist?user_id=%@&shop_id=%@",kAPI_Main,user_id,shop_id] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]


//小区通知
//#define kAPI_getNewsList(center_id,user_id) [[NSString stringWithFormat:@"%@/api/NewsCommunity/getNewsList?center_id=%@&user_id=%@",kAPI_Main,center_id,user_id] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]

//小区通知详情
#define kAPI_setNewsStatus(token,notice_id,timestamp,sig) [NSString stringWithFormat:@"%@/property/noticeinfo?channel=%@&app_ver=%@&token=%@&notice_id=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,token,notice_id,timestamp,sig]

//物业
//获取小区的地址
#define kAPI_PaypropertyGetaddress(phone) [[NSString stringWithFormat:@"%@/api/Payproperty/getaddress?phone=%@",kAPI_Main,phone] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
//上传 投诉意见 "p_type" : "1"投诉   "p_type" : "2"报修
#define kAPI_PaypropertyComplanit [NSString stringWithFormat:@"%@/api/Payproperty/insert_complanit",kAPI_Main]

//http://192.168.1.119/cc/cm/server/index.php/api/coupon/getcouponlist?store_id=1&type=1


//获取水费详情
#define kAPI_getpaylife(phone,type) [NSString stringWithFormat:@"%@/api/Payproperty/getpaylife?phone=%@&type=%@",kAPI_Main,phone,type]
//评价
//#define KAPI_getCommentReslut(center_id) [[NSString stringWithFormat:@"%@/api/Payproperty/getappraise?center_id=%d",kAPI_Main,center_id]stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
//评价的提交
#define KAPI_getCommentInsert_eval(center_id,mobile_phone,p_user_id,one,two,three,four,five) [[NSString stringWithFormat:@"%@/api/Payproperty/insert_eval?center_id=%@&mobile_phone=%@&p_user_id=%@&one=%@&two=%@&three=%@&four=%@&five=%@",kAPI_Main,center_id,mobile_phone,p_user_id,one,two,three,four,five] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
//物业费
//#define KAPI_getNewProperty(mobile_phone) [[NSString stringWithFormat:@"%@/api/Payproperty/getproperty?mobile_phone=%@",kAPI_Main,mobile_phone]stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
//停车费
#define KAPI_getcar_number(mobile_phone) [[NSString stringWithFormat:@"%@/api/Payproperty/getcar_number?mobile_phone=%@",kAPI_Main,mobile_phone]stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]

//小区通知
#define KAPI_notice(token,zid,timestamp,sig,page,nums) [NSString stringWithFormat:@"%@/property/notice?channel=%@&app_ver=%@&token=%@&zid=%@&timestamp=%@&sig=%@&page=%@&nums=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,token,zid,timestamp,sig,page,nums]
//活动

//活动首页
#define kAPI_actindex(token,zid,timestamp,sig,city_id) [NSString stringWithFormat:@"%@/zone/actindex?channel=%@&app_ver=%@&token=%@&zid=%@&timestamp=%@&sig=%@&city_id=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,token,zid,timestamp,sig,city_id]

#define kAPI_newstore(center_id,type,timestamp,sig) [NSString stringWithFormat:@"%@/activities/newstore?channel=%@&center_id=%@&type=%@&timestamp=%@&sig=%@",kAPI_Main,kAPI_channel,center_id,type,timestamp,sig]

//活动列表
#define kAPI_actilist(zid,page,nums,timestamp,sig,token) [NSString stringWithFormat:@"%@/zone/actilist?channel=%@&zid=%@&page=%@&nums=%@&timestamp=%@&sig=%@&token=%@&app_ver=%@",kAPI_loc_entry,KAPI_NewChannel,zid,page,nums,timestamp,sig,token,APPVersion]
//本周新开张
#define kAPI_newsmerchant(zid,page,nums,timestamp,sig,token) [NSString stringWithFormat:@"%@/zone/newsmerchant?channel=%@&zid=%@&page=%@&nums=%@&timestamp=%@&sig=%@&token=%@&app_ver=%@",kAPI_loc_entry,KAPI_NewChannel,zid,page,nums,timestamp,sig,token,APPVersion]

//7-社区活动详情
#define kAPI_actiinfo(zid,id,timestamp,sig,token) [NSString stringWithFormat:@"%@/zone/actdetail?channel=%@&zid=%@&id=%@&timestamp=%@&sig=%@&app_ver=%@&token=%@",kAPI_loc_entry,KAPI_NewChannel,zid,id,timestamp,sig,APPVersion,token]


//报名
#define kAPI_signup(token,city_id,zid,id,timestamp,sig) [NSString stringWithFormat:@"%@/zone/actsignup?channel=%@&token=%@&app_ver=%@&city_id=%@&zid=%@&id=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,token,APPVersion,city_id,zid,id,timestamp,sig]


//**********************支付*************************************************
//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088411390645759"
//收款支付宝账号
#define SellerID  @"2696776191@qq.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @""

//商户私钥，自助生成
#define PartnerPrivKey  @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAKzDYvAmE/qMzju55bvx4un+RCZtalwNIaH754bN5wZRv3DWlpYBf3Mgjz3IKEwevNQ0stK74y5LWLDpEi1vpQm05SsKTNRkH8JqZIAJscaZItxZ11qDFmd7eI4Sk6qSfiia1Ytt4VMBo9TphIlu/tN2Pj+u3iFa7IKFP+4mKhZtAgMBAAECgYBEtTAT8hDgBD/A4R3MsVZdWRIhdkJmeZJ2qYhaxGisyrYoWi9pWQ8m6jwNhh0AqPjQLGUyCic/sheDxC3GhDBOFKB9qfBubIg/Dp9FF4/Ge6KWVsgDWXkcQfG67Z1VREPeL9TQi7le/wtPtQdeAqbwo7ya1bw68j2cTYHIAxnywQJBANdPYVX5G/+wXCkv1Vx6W+w5a8Qmz9swM+pfR+Dt2Ul+hKbI1iszfIei7YGttdec2Lrf88pbF+Lio25IUnLisuMCQQDNaZsVx5201M44vGjDU7kjoSFyCEo1hxGDckCzN3gB4FfbCHYUiUX4uUFLAsyUCK9Z9h5z7AHwzdqUjNkZQEJvAkBGd4NqyNniCA1RqYcR+jXljTF5BB7ZJOCI32A9/Ho19INjtq1pfDNQjQFghMLT61B/cNZwLvoVVomYiXD6irlzAkAA5XsVxz868MrNmJTkdVMTgrqAouSgAyziY/dAUPenGnGHtSu+vzKc+UH9r89wvfD19YsAeoEvqdZQW6T+5TblAkBMJA7jF3fz8Ucr1H5O1zRr2lB9H+cErWqAT2qUh3cfnGm2Nslw80zSD9vdwBj7pPaFp+RBxCKKw3oqH9/7b/86"


//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCYRacvQm+K14AnT6TeZ2rSDh60RUU4xYP2K0zzg3/9IM3aGzI5eXQxV2WtNU8jUspCNld7R9dEJJeYIztfEjVc64G1jl7gysHZRH+tCyJZEQsN0ZvrtWXsU8OM1qKYxuVl8WpWSz13NCDpE5J3W88hNJc/zZYh/FZh7t1mVKMyNwIDAQAB"
//************************************************************************



//判断是否获取数据成功
#define IsSuccess [[[respondObject objectForKey:@"info"] objectForKey:@"result"] intValue] == 0


//得到sig
#define KAPI_GetSig(dic)  [BaseUtil md5:[BaseUtil getSigWithArray:dic]]



//商户列表
#define KAPI_MerchantList(zid,trade_id,page,nums,sig)  [NSString stringWithFormat:@"%@/merchant/list?channel=%@&app_ver=%@&zid=%@&trade_id=%@&page=%@&nums=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,zid,trade_id,page,nums,kAPI_timestamp,sig]


//商户首页
#define KAPI_MerchantDetail(mid,sig)  [NSString stringWithFormat:@"%@/merchant/detail?channel=%@&app_ver=%@&mid=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,mid,[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]],sig]

//商户首页用户评论列表
//#define KAPI_EvaluateList(mid,page,nums,sig)  [NSString stringWithFormat:@"%@/evaluate/list?channel=%@&app_ver=%@&mid=%@&page=%@&nums=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,mid,page,nums,[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]],sig]



//商品详情
#define KAPI_MerchantGoodDetail(id,sig)  [NSString stringWithFormat:@"%@/merchant/goodsdetail?channel=%@&app_ver=%@&id=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,id,[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]],sig]



//商户商品分类
#define KAPI_MerchantType(mid,sig,service_id)  [NSString stringWithFormat:@"%@/merchant/type?channel=%@&app_ver=%@&mid=%@&timestamp=%@&sig=%@&service_id=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,mid,[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]],sig,service_id]




//商户商品详情
#define KAPI_MerchantGoodsDetail(mid,id,sig)  [NSString stringWithFormat:@"%@/merchant/goodsdetail?channel=%@&app_ver=%@&mid=%@&type_id=%@&page=%@&nums=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,mid,id,[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]],sig]

//商户相册
#define KAPI_MerchantAlbum(mid,sig) [NSString stringWithFormat:@"%@/merchant/album?channel=%@&app_ver=%@&mid=%@&cid=%@&zid=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,mid,[CMCUserManager shareManager].cid,k_zid,[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]],sig]

//社区红包列表
#define KAPI_MyBonus(page,timestamp,sig) [NSString stringWithFormat:@"%@/user/mybonus?channel=%@&token=%@&app_ver=%@&page=%@&nums=%@&timestamp=%@&sig=%@",kAPI_Main,KAPI_NewChannel,[CMCUserManager shareManager].token,APPVersion,page,@"8",timestamp,sig]


//社区红包详情
#define KAPI_MyBonusDeatail(id,timestamp,sig) [NSString stringWithFormat:@"%@/user/bonusdetail?channel=%@&token=%@&app_ver=%@&id=%@&timestamp=%@&sig=%@",kAPI_Main,KAPI_NewChannel,[CMCUserManager shareManager].token,APPVersion,id,timestamp,sig]


//订单支付
#define KAPI_orderPay(order_id,timestamp,sig) [NSString stringWithFormat:@"%@/user/orderpay?channel=%@&token=%@&app_ver=%@&order_id=%@&timestamp=%@&sig=%@",kAPI_Main,KAPI_NewChannel,[CMCUserManager shareManager].token,APPVersion,order_id,timestamp,sig]

//取消订单
#define KAPI_orderCancel(order_id,timestamp,sig) [NSString stringWithFormat:@"%@/user/ordercancel?channel=%@&token=%@&app_ver=%@&order_id=%@&timestamp=%@&sig=%@",kAPI_Main,KAPI_NewChannel,[CMCUserManager shareManager].token,APPVersion,order_id,timestamp,sig]

//订单确认
#define KAPI_orderFinish(order_id,timestamp,sig) [NSString stringWithFormat:@"%@/user/orderfinish?channel=%@&token=%@&app_ver=%@&order_id=%@&timestamp=%@&sig=%@",kAPI_Main,KAPI_NewChannel,[CMCUserManager shareManager].token,APPVersion,order_id,timestamp,sig]


//用户评价
#define KAPI_OrdereValute  [NSString stringWithFormat:@"%@/user/orderevaluate",kAPI_loc_entry]//0317


////用户评价上传图片
//#define KAPI_OrdereValuteImage(id,image_name,upimage,timestamp,sig) [NSString stringWithFormat:@"%@/user/orderevaluate?channel=%@&app_ver=%@&token=%@&id=%@&image_name=%@&upimage=%@&timestamp=%@&sig=%@",kAPI_loc_entry,KAPI_NewChannel,APPVersion,[CMCUserManager shareManager].token,id,image_name,upimage,timestamp,sig]

//用户评价上传图片
#define KAPI_OrdereValuteImage [NSString stringWithFormat:@"%@/user/orderevaluateimage",kAPI_loc_entry]

