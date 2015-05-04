//
//  CMCUserManager.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-9-18.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMCAcconutInfo.h"
@interface CMCUserInfo : NSObject
@property (nonatomic, copy) NSString *id,*username;
+ (instancetype)fromDict:(NSDictionary *)dict;
@end


@interface CMCUserManager : NSObject
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) CMCUserInfo *userInfo;
@property (nonatomic, strong) CMCAcconutInfo *accountInfo;
@property (nonatomic, strong) NSString *dateStr; //传入日期
@property (nonatomic, assign) float labelValue;//传入uistepper上的文字为零
@property (nonatomic,copy) NSString *residentialAddressStr; //投诉和报修 选择的小区地址
@property (nonatomic, copy) NSString *residentialCenter_id;
@property (nonatomic, strong) NSString *communityType; //小区类型
@property (nonatomic, strong) NSDictionary *center_idDic;//通过小区的名字找出center_id

@property (nonatomic, strong) NSString *yuDingTime;
@property (nonatomic, strong) NSString *nickname; //昵称
@property (nonatomic, strong) NSString *individualitySignature; //个性签名

@property (nonatomic, strong) NSString *latLongStr; //经纬度
@property (nonatomic, strong) NSString *address; //百度地图得到的地址
@property (nonatomic, strong) NSString *login_id;// 也就是物业中的center_id
@property (nonatomic, strong) NSString *location; //现在所在的位置  首页 物业的titleView上的文字

//@property (nonatomic, strong) NSString *suid; //用户id
@property (nonatomic, strong) NSArray *bannaArr; //用户id
@property (nonatomic, strong) NSString *currentAddress;
@property (nonatomic, strong) NSString *real_name;
@property (nonatomic,assign)BOOL isClick;//是否收回


@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *uid;  //用户id
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *city_id;// 城市id
@property (nonatomic, strong) NSString *file_url;//图片的url
@property (nonatomic, strong) NSString *loc_entry;
@property (nonatomic, strong) NSString *phone; //用户电话
@property (nonatomic, strong) NSString *password; //用户密码
@property (nonatomic, strong) NSString *alipay; // 支付宝回调的url
@property (nonatomic, strong) NSString *bestpay; // 翼支付回调的url
@property (nonatomic, strong) NSString *cid;  //城市管理 id
@property (nonatomic, strong) NSString *mid;  //商户 id
@property (nonatomic, strong) NSString *zid;  //社区 id
@property (nonatomic, strong) NSString *z_name; //社区名字

@property (nonatomic,strong)  NSMutableDictionary *orderDic;//点菜菜单
@property (nonatomic,strong) NSMutableDictionary *dataDic;//商品列表
@property (nonatomic,strong) NSString *edageNum;
@property (nonatomic,strong) NSString *price;

@property (nonatomic, strong) NSString *express_money;//物流费
@property (nonatomic, strong) NSString *order_money;//物流额度
@property (nonatomic, strong) NSString *zbanner; // 加载物业banner
@property (nonatomic, strong) NSString *wuye_address;





+ (instancetype)shareManager;
+ (BOOL)isLogined;
+ (void)storeAccountInKeychain:(NSString*)Account;
+ (void)storePasswordInKeychain:(NSString*)psd;
+ (NSString*)getAccountFromKeychain;
+ (NSString*)getPasswordFromKeychain;
+ (void)clearAccountInfo;
//根据字符串得到所占的高度
+ (CGRect)_getSizeWithString:(NSString *)string withWidth:(NSInteger)width withHeight:(NSInteger)height;

@end
