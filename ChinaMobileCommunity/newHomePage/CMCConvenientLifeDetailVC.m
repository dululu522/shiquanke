//
//  CMCCMCConvenientLifeDetailVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-14.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCConvenientLifeDetailVC.h"
#import "CMCConvenientLifeListTVCell.h"
#import "CMCFoodDetail.h"
#import "TCShopStoreServiceTableViewCell.h"
#import "CMCShopDetailIntroductionTVCell.h"
#import "CMCYouHuiVC.h"
#import "CMCShopDetailCell.h"
#import "CMCPlaceCell.h"
#import "CMCShoppingGoodsVC.h"
#import "CMCCommentCell.h"
#import "CMCConvenientLifeCouponsVC.h"
#import "MerchantDetailModel.h"
#import "CMCOnlineBookingVC.h"
#import "CMCPayViewController.h"
#import "CMCTakeOutTableVC.h"
#import "CMCYouHuiVC.h"
#import "BMapKit.h"
#import "CMCShoppingGoodsVC.h"
#import "CMCUserCommentVC.h"
#import "CMCPhotoLibaryVC.h"
#import "CMCWashColthesVC.h"
#import "CMCStoreServiceVC.h"  //到店服务
#import "CMCHousingInformationTableVC.h" //房源信息
#import "CMCPhotoDisPlayVC.h"



@interface CMCConvenientLifeDetailVC ()<UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) MerchantDetailModel *myModel;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic,assign)CGRect rect;
@property (nonatomic, strong) NSMutableArray *listArr; //用来放购物,买单,优惠
@property (nonatomic, strong) NSMutableDictionary *serviceDic; //通过id找出对应的项目名
@property (nonatomic,strong)NSMutableArray *imgArr;
@property (nonatomic,strong)NSArray *evaluateArr;
@property (nonatomic,strong)NSMutableArray *commentArr;

@end
static BOOL isTure ;
@implementation CMCConvenientLifeDetailVC

- (NSArray *)evaluateArr{
    if (_evaluateArr == nil) {
        self.evaluateArr = [NSArray array];
    }
    return _evaluateArr;
}

- (NSMutableArray *)imgArr{
    if (_imgArr == nil) {
        self.imgArr = [NSMutableArray array];
    }
    return _imgArr;
}

- (NSMutableArray *)commentArr{
    if (_commentArr == nil) {
        self.commentArr = [NSMutableArray array];
    }
    return _commentArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.listArr = [[NSMutableArray alloc]init];
    self.serviceDic = [[NSMutableDictionary alloc] init];
    self.title = @"商家详情";
    // Do any additional setup after loading the view.
    [self createSubViews];
    [self loadData];
    [self loadCommentData];//评论列表
    [self loadPhoto];//商铺相册
    //创建服务列表
    isTure = YES;
    [self didClickserviceButton:nil];
    NSLog(@"kAPI_Service %@",kAPI_Service);
//通过项目的id取出对应的项目名
    [self fromIdGeterviceName];
}

//通过项目的id取出对应的项目名
- (void)fromIdGeterviceName
{

    for (NSDictionary *tempDic in kAPI_Service) {
        [self.serviceDic setObject:[tempDic objectForKey:@"name"] forKey:[tempDic objectForKey:@"id"]];
        NSLog(@"%@",[tempDic objectForKey:@"name"]);
        NSLog(@"%@",[tempDic objectForKey:@"id"]);

        
    }

}

#pragma mark - 创建子视图 －

- (void)createSubViews{
    [self creatServiceButton];
    [self setupTableView];
}

/**
 *  右服务按钮
 */
- (void)creatServiceButton
{
    //服务
    UIButton *serviceButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 53, 33)];
    [serviceButton setBackgroundImage:[UIImage imageNamed:@"rightBar_btn"] forState:UIControlStateNormal];
    [serviceButton setTitle:@"服务" forState:UIControlStateNormal];
    serviceButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [serviceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [serviceButton addTarget:self action:@selector(didClickserviceButton:) forControlEvents:UIControlEventTouchUpInside];
    [serviceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:serviceButton];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
  
}
/**
 *  点击事件
 *
 *  @param button 参数
 */
- (void)didClickserviceButton:(UIButton *)button
{
    if (isTure == YES) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 94, 0, 94, 42 * self.listArr.count)];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        [self.view addSubview:_listTableView];
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        isTure = NO;
    } else if (isTure == NO) {
        [_listTableView removeFromSuperview];
        isTure = YES;
    }
}

//创建tableview
- (void)setupTableView{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableView];
}


#pragma mark - 数据请求 -
- (void)loadData
{
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"mid":self.mid,@"timestamp":kAPI_timestamp};
    NSString *sig = KAPI_GetSig(dic);
    NSString *url = KAPI_MerchantDetail(self.mid, sig);
    
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"reso = %@",respondObject);
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                NSDictionary *dataDic = [respondObject objectForKey:@"data"];
                MerchantDetailModel *merchantDetail = [MerchantDetailModel merchantDetailWithDic:dataDic];
                self.myModel = merchantDetail;
                
                self.evaluateArr = [[respondObject objectForKey:@"data"] objectForKey:@"evaluate"];
                //服务列表
                NSString *service = merchantDetail.service;
                self.listArr = [NSMutableArray arrayWithArray:[service componentsSeparatedByString:@","]];
                NSLog(@"self.listArr %@",self.listArr);
                
                [self.myTableView reloadData];
                [self.listTableView reloadData];
                self.listTableView.frame = CGRectMake(self.view.bounds.size.width - 94, 0, 94, 42 * self.listArr.count);
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            } else if([[infoDic objectForKey:@"result"] intValue] == 3){
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

                CMCLoginViewController *loginVC = [[CMCLoginViewController alloc] init];
                loginVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:loginVC animated:YES];
            
            } else {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [BaseUtil toast:@"服务端返回数据错误"];
            
            }
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


//用户评论列表
- (void)loadCommentData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *timestamp = kAPI_timestamp;
    
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"mid":self.mid,@"page":@"1",@"nums":@"10000",@"timestamp":timestamp};
    
    NSString *sig = KAPI_GetSig(dic);
    
    NSString *url = KAPI_EvaluateList(self.mid,@"1",@"10000",timestamp,sig);
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"respondObject ====== %@",respondObject);
        if ([[[[respondObject objectForKey:@"info"] objectForKey:@"result"] stringValue] isEqualToString:@"0"]) {
            NSArray *commentArr = [respondObject objectForKey:@"data"];
            for (NSDictionary *tmpDic in commentArr) {
                [self.commentArr addObject:tmpDic];
                
            }
            
        }
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [BaseUtil toast:@"数据加载失败"];
        
    }];
    
}

- (void)loadPhoto{
    NSLog(@"k_zid %@",k_zid);
    if (self.mid && k_zid && [CMCUserManager shareManager].cid) {
        NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"cid":[CMCUserManager shareManager].cid,@"mid":self.mid,@"zid":k_zid,@"timestamp":kAPI_timestamp};
        NSString *sig = KAPI_GetSig(dic);
        NSString *url = KAPI_MerchantAlbum(self.mid, sig);
        [BaseUtil get:url success:^(id respondObject) {
            NSLog(@"--------------%@",respondObject);
            if (IsSuccess) {
                self.imgArr = [[respondObject objectForKey:@"data"] objectForKey:@"image"];
            }
            [_myTableView reloadData];
        } failure:^(NSError *error) {
            
        }];
    }

    
    
    
}

#pragma mark - TableViewDelegate -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.myTableView == tableView){
        
        return 3;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.myTableView == tableView) {
        if (section == 0) {
//            return 4;
            return 3;
        }
        if (section == 1) {
            return 1;
        }
        if (section == 2) {
            if (self.evaluateArr.count < 2) {
                return self.evaluateArr.count + 1;//0317
            }
            return 3;
        }
    }
    if (self.listTableView == tableView) {
        return self.listArr.count;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _myTableView) {
        if (section == 1) {
            return 36;
        }
        if (section == 2) {
            return 23;
        }
        
        return 0.1;
        
    }
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.myTableView == tableView) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                return 120;
            }else{
                return 44;
            }
            
        }
        if (indexPath.section == 1) {
            if ([CMCUserManager shareManager].isClick) {
                return self.rect.size.height + 40;
            }
            return 90;
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                return 44;
            }else{
                //得到尺寸
                NSDictionary *dataDic = self.evaluateArr[indexPath.row - 1];
                NSString *contentStr = [dataDic objectForKey:@"content"];
                CGRect rect = [CMCUserManager _getSizeWithString:contentStr withWidth:self.view.width - 46 withHeight:20000];
                
                NSString *imageStr = [dataDic objectForKey:@"image"];
                 CGFloat imgF = 0.0;
                if (imageStr.length > 1) {
                    imgF = 40;
                }else{
                    imgF = 0.0;
                }
                return 10 + 32 + 7.5 + rect.size.height + 10 + imgF;
                
            }
            
        }
    }
    if (self.listTableView == tableView) {
        return 42;
        
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        UILabel *titleL = [[UILabel alloc]init];
        titleL.frame = CGRectMake(0, 0, self.view.frame.size.width, 36);
        titleL.text = @"  商家简介";
        titleL.font = [UIFont systemFontOfSize:13];
        titleL.textColor = [UIColor colorWithHexString:@"8c8c8c"];
        titleL.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
        return titleL;
    }
    if (section == 2) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithHexString:@"f5f4f4"];
        return view;
    }
    
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.myTableView) {
        //第一分区
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                CMCShopDetailCell *cell =[[CMCShopDetailCell alloc] init];
                cell.myModel = _myModel;
                cell.num = [NSString stringWithFormat:@"%lu",(unsigned long)self.imgArr.count];
                [cell setupPhotoBlock:^{
                    //查看商户相册
                    CMCPhotoLibaryVC *photoVC = [[CMCPhotoLibaryVC alloc]init];
                    photoVC.imgArr = self.imgArr;
                    [self.navigationController pushViewController:photoVC animated:YES];
                    
                }];
                return cell;
            }
            CMCPlaceCell *cell = [[CMCPlaceCell alloc]init];
            cell.row = indexPath.row;
            cell.myModel = _myModel;
            cell.category = self.category;
            return cell;
            
        }
        //第二分区
        if (indexPath.section == 1) {
            CMCShopDetailIntroductionTVCell *cell =[[CMCShopDetailIntroductionTVCell alloc] init];
            cell.infoStr = _myModel.intro;
          self.rect =  [self _getSizeWithString:cell.infoStr withWidth:self.view.width - 30 withHeight:20000];
            [cell setupBlock:^{
               //点击全部查看对应的方法
                [self allBttAction:cell];
                
            }];
            return cell;
        }
    }
    
    //第三分区
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.text = @"网友点评";
            cell.textLabel.textColor = [UIColor colorWithHexString:@"5c5c5c"];
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //多少个数量//0317
            UILabel *numL = [[UILabel alloc]initWithFrame:CGRectMake(70,12, 100, 20)];
            numL.textColor = k_color(@"656565");
            numL.font = k_font(12);
            numL.text = [NSString stringWithFormat:@"(%d)",self.commentArr.count];
            [cell.contentView addSubview:numL];
            
            //分割线
            UIView *sepeV = [[UIView alloc]init];
            sepeV.frame = CGRectMake(10,cell.height - 0.5, cell.width - 20, 0.5);
            sepeV.backgroundColor = [UIColor colorWithHexString:@"ededed"];
            [cell.contentView addSubview:sepeV];
            
            return cell;
        }else{
            CMCCommentCell *cell = [[CMCCommentCell alloc]init];
            NSDictionary *dataDic = self.evaluateArr[indexPath.row - 1];
            cell.dataDic = dataDic;
            
            [cell setupTapBlock:^(int num) {
                CMCPhotoDisPlayVC *playVC = [[CMCPhotoDisPlayVC alloc]init];
                playVC.num = num + 1;
                
                NSString *imageStr = [dataDic objectForKey:@"image"];
                if (imageStr.length > 1) {
                    NSArray *imgArr = [imageStr componentsSeparatedByString:@","];
                    NSMutableArray *dataArr = [NSMutableArray array];
                    for (NSString *string in imgArr) {
                        
                        [dataArr addObject:string];
                    }
                    
                  playVC.dataArr = [NSArray arrayWithArray:dataArr];
                  [self.navigationController pushViewController:playVC animated:YES];
                }
                
            }];
            
            
            return cell;
        }
        
    }
    
    //服务
    if (tableView == self.listTableView) {
        static NSString *str = @"REUSED";
        TCShopStoreServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[TCShopStoreServiceTableViewCell alloc] init];
        }
        //        cell.indexPath = indexPath.row;
//        [cell creatImageView:[self.listArr objectAtIndex:indexPath.row] title:[self.listArr objectAtIndex:indexPath.row]];
        NSString *name = [self.serviceDic objectForKey:[self.listArr objectAtIndex:indexPath.row]];
        NSLog(@"name %@",name);
        [cell creatImageView:name title:name];
        cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        return cell;
    }
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击tableview上的cell
    if (self.myTableView == tableView) {
        [_listTableView removeFromSuperview];
        isTure = YES;
        if (indexPath.section == 0) {
            //地址
            if (indexPath.row == 1) {
                
            //跳转百度地图
//                [self LookMapLocation];
                
                
            }
            //电话
            if (indexPath.row == 2) {
                UIAlertView *arlerView = [[UIAlertView alloc]initWithTitle:@"是否拨打商家电话？" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"电话：%@",_myModel.tel.firstObject],@"取消", nil];
                [arlerView show];
            }
            //快速购物
//            if (indexPath.row == 3) {
//                if ([self.category isEqualToString:@"餐饮美食"]) {
//                    CMCOrderViewController *orderVC = [[CMCOrderViewController alloc]init];
//                    orderVC.merchant_id = _myModel.mid;
//                    orderVC.merchant_name = _myModel.name;
//                    [self.navigationController pushViewController:orderVC animated:YES];
//                    
//                }else if ([self.category isEqualToString:@"便利生活"]){
//                    CMCShoppingGoodsVC *shoppingGoodsVC = [[CMCShoppingGoodsVC alloc] init];
//                    shoppingGoodsVC.merchant_id = _myModel.mid;
//                    [self.navigationController pushViewController:shoppingGoodsVC animated:YES];
//                }
//                
//            }
        }
        //第三分区
        if (indexPath.section == 2) {
            //网友点评
            if (indexPath.row == 0) {
                if (self.evaluateArr.count == 0) {
                    [BaseUtil toast:@"暂无评论"];
                    return;
                }
                CMCUserCommentVC *commentVC = [[CMCUserCommentVC alloc]init];
                
                commentVC.mid = _myModel.mid;
                [self.navigationController pushViewController:commentVC animated:YES];
            }
        }
        
    }
    if (_listTableView == tableView)
    {
        NSString *type_id = self.listArr[indexPath.row];
        NSLog(@"type_id %@",type_id);
        switch ([type_id intValue]) {
            case 1:
            {
                CMCShoppingGoodsVC *orderVC = [[CMCShoppingGoodsVC alloc]init];
                orderVC.title =[self.serviceDic objectForKey:type_id];
                orderVC.merchant_id = _myModel.mid;
                orderVC.merchant_name = _myModel.name;
                orderVC.service_id = type_id;
                [self.navigationController pushViewController:orderVC animated:YES];
                
            }
                break;
            case 2:
            {
                CMCShoppingGoodsVC *takeOutVC = [[CMCShoppingGoodsVC alloc]init];
//                takeOutVC.title = @"外卖";
                takeOutVC.title =[self.serviceDic objectForKey:type_id];

                takeOutVC.merchant_id = _myModel.mid;
                takeOutVC.merchant_name = _myModel.name;
                takeOutVC.service_id = type_id;
                [self.navigationController pushViewController:takeOutVC animated:YES];
                
            }
                break;
            case 3:
            {
                CMCPayViewController *payVC = [[CMCPayViewController alloc] init];
                payVC.merchant_id = _myModel.mid;
                payVC.merchant_name = _myModel.name;
                payVC.title =[self.serviceDic objectForKey:type_id];

                payVC.service_id = type_id;
                [self.navigationController pushViewController:payVC animated:YES];
                
            }
                break;
            case 4:
            {
                CMCOnlineBookingVC *bookingVC = [[CMCOnlineBookingVC alloc] init];
                bookingVC.merchant_id = self.mid;
                bookingVC.merchant_name = _myModel.name;
                bookingVC.title =[self.serviceDic objectForKey:type_id];

                [self.navigationController pushViewController:bookingVC animated:YES];
                
            }
                break;
            case 5:
            {
                CMCConvenientLifeCouponsVC *couponsVC = [[CMCConvenientLifeCouponsVC alloc] init];
                couponsVC.merchant_id = _myModel.mid;
                couponsVC.title =[self.serviceDic objectForKey:type_id];

                [self.navigationController pushViewController:couponsVC animated:YES];
            }
                break;
            case 6:
            {
                CMCShoppingGoodsVC *goodsVC = [[CMCShoppingGoodsVC alloc]init];
//                goodsVC.title = @"购物";
                goodsVC.title =[self.serviceDic objectForKey:type_id];

                goodsVC.merchant_id = _myModel.mid;
                 goodsVC.service_id = type_id;
                goodsVC.merchant_name = _myModel.name;
                [self.navigationController pushViewController:goodsVC animated:YES];
            }
                break;
                //家政服务
            case 7:
            {
                NSLog(@"%@",_myModel.mid);
                //家政服务
                CMCHousingInformationTableVC *homeVC = [[CMCHousingInformationTableVC alloc]init];
                homeVC.mid = _myModel.mid;
                homeVC.title =[self.serviceDic objectForKey:type_id];

                homeVC.service_id = type_id;
//                homeVC.title = @"家政服务";
                homeVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:homeVC animated:YES];
            }
                break;
                //房源信息
            case 8:
            {
                NSLog(@"%@",_myModel.mid);
                //房源信息 
                CMCHousingInformationTableVC *homeVC = [[CMCHousingInformationTableVC alloc]init];
                homeVC.mid = _myModel.mid;
                homeVC.title =[self.serviceDic objectForKey:type_id];

                homeVC.service_id = type_id;
                homeVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:homeVC animated:YES];
                
            }
                break;
                //预约洗车
            case 9:
            {

                CMCShoppingGoodsVC *orderVC = [[CMCShoppingGoodsVC alloc]init];
//                orderVC.title = @"预约洗车";
                orderVC.title =[self.serviceDic objectForKey:type_id];

                orderVC.merchant_id = _myModel.mid;
                orderVC.merchant_name = _myModel.name;
                orderVC.service_id = type_id;
                [self.navigationController pushViewController:orderVC animated:YES];
                
            }
                break;
               
            case 10:
            {
                 //预约装饰

                CMCShoppingGoodsVC *orderVC = [[CMCShoppingGoodsVC alloc]init];
//                orderVC.title = @"预约装饰";
                orderVC.title =[self.serviceDic objectForKey:type_id];

                orderVC.merchant_id = _myModel.mid;
                orderVC.merchant_name = _myModel.name;
                orderVC.service_id = type_id;
                [self.navigationController pushViewController:orderVC animated:YES];
                
            }
                break;
                //上门洗车
            case 11:
            {
                CMCShoppingGoodsVC *orderVC = [[CMCShoppingGoodsVC alloc]init];
//                orderVC.title = @"上门洗车";
                orderVC.title =[self.serviceDic objectForKey:type_id];

                orderVC.merchant_id = _myModel.mid;
                orderVC.merchant_name = _myModel.name;
                orderVC.service_id = type_id;
                [self.navigationController pushViewController:orderVC animated:YES];
                
                
            }
                break;
                //上门装饰
            case 12:
            {

                CMCShoppingGoodsVC *orderVC = [[CMCShoppingGoodsVC alloc]init];
//                orderVC.title = @"上门装饰";
                orderVC.title =[self.serviceDic objectForKey:type_id];

                orderVC.merchant_id = _myModel.mid;
                orderVC.merchant_name = _myModel.name;
                orderVC.service_id = type_id;
                [self.navigationController pushViewController:orderVC animated:YES];
                
            }
                break;
                //汽车用品
            case 13:
            {
                CMCShoppingGoodsVC *orderVC = [[CMCShoppingGoodsVC alloc]init];
//                orderVC.title = @"汽车用品";
                orderVC.title =[self.serviceDic objectForKey:type_id];

                orderVC.merchant_id = _myModel.mid;
                orderVC.merchant_name = _myModel.name;
                orderVC.service_id = type_id;
                [self.navigationController pushViewController:orderVC animated:YES];
                
            }
                break;
                //洗衣
            case 14:
            {
                CMCWashColthesVC *washColthes = [[CMCWashColthesVC alloc]init];
//                washColthes.category = @"洗衣";
                washColthes.title =[self.serviceDic objectForKey:type_id];

                washColthes.merchant_id = _myModel.mid;
                washColthes.merchant_name = _myModel.name;
                washColthes.service_id = type_id;
                [self.navigationController pushViewController:washColthes animated:YES];
            }
                break;
                //修鞋
            case 15:
            {
                CMCWashColthesVC *washColthes = [[CMCWashColthesVC alloc]init];
//                washColthes.category = @"修鞋";
                washColthes.title =[self.serviceDic objectForKey:type_id];

                washColthes.merchant_id = _myModel.mid;
                washColthes.merchant_name = _myModel.name;
                washColthes.service_id = type_id;
                [self.navigationController pushViewController:washColthes animated:YES];
                
            }
                break;
                //到店按摩
            case 16:
            {
                CMCShoppingGoodsVC *takeOutVC = [[CMCShoppingGoodsVC alloc]init];
//                takeOutVC.title = @"到店美甲";
                takeOutVC.title =[self.serviceDic objectForKey:type_id];

                takeOutVC.merchant_id = _myModel.mid;
                takeOutVC.merchant_name = _myModel.name;
                takeOutVC.service_id = type_id;
                [self.navigationController pushViewController:takeOutVC animated:YES];
                
            }
                break;
                //到店修脚
            case 17:
            {
                CMCShoppingGoodsVC *takeOutVC = [[CMCShoppingGoodsVC alloc]init];
//                takeOutVC.title = @"到店美甲";
                takeOutVC.title =[self.serviceDic objectForKey:type_id];

                takeOutVC.merchant_id = _myModel.mid;
                takeOutVC.merchant_name = _myModel.name;
                takeOutVC.service_id = type_id;
                [self.navigationController pushViewController:takeOutVC animated:YES];
                
            }
                break;
                //到店美甲
            case 18:
            {
//                ******************
//                CMCStoreServiceVC *storeServiceVC = [[CMCStoreServiceVC alloc] init];
//                storeServiceVC.merchant_id = _myModel.mid;
//                storeServiceVC.merchant_name =_myModel.name;
//                storeServiceVC.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:storeServiceVC animated:YES];
                CMCShoppingGoodsVC *takeOutVC = [[CMCShoppingGoodsVC alloc]init];
//                takeOutVC.title = @"到店美甲";
                takeOutVC.title =[self.serviceDic objectForKey:type_id];

                takeOutVC.merchant_id = _myModel.mid;
                takeOutVC.merchant_name = _myModel.name;
                takeOutVC.service_id = type_id;
                [self.navigationController pushViewController:takeOutVC animated:YES];
                
            }
                break;
                //上门按摩
            case 19:
            {
                CMCShoppingGoodsVC *takeOutVC = [[CMCShoppingGoodsVC alloc]init];
//                takeOutVC.title = @"上门按摩";
                takeOutVC.title =[self.serviceDic objectForKey:type_id];

                takeOutVC.merchant_id = _myModel.mid;
                takeOutVC.merchant_name = _myModel.name;
                takeOutVC.service_id = type_id;
            [self.navigationController pushViewController:takeOutVC animated:YES];
            }
                break;
                //上门修脚
            case 20:
            {
                CMCShoppingGoodsVC *takeOutVC = [[CMCShoppingGoodsVC alloc]init];
//                takeOutVC.title = @"上门修脚";
                takeOutVC.title =[self.serviceDic objectForKey:type_id];

                takeOutVC.merchant_id = _myModel.mid;
                takeOutVC.merchant_name = _myModel.name;
                takeOutVC.service_id = type_id;
                [self.navigationController pushViewController:takeOutVC animated:YES];
                
            }
                break;
                //上门美甲
            case 21:
            {
                CMCShoppingGoodsVC *takeOutVC = [[CMCShoppingGoodsVC alloc]init];
//                takeOutVC.title = @"上门修脚";
                takeOutVC.title =[self.serviceDic objectForKey:type_id];

                takeOutVC.merchant_id = _myModel.mid;
                takeOutVC.merchant_name = _myModel.name;
                takeOutVC.service_id = type_id;
                [self.navigationController pushViewController:takeOutVC animated:YES];
                
            }
                break;
                //到店美发
            case 22:
            {
                CMCWashColthesVC *washColthes = [[CMCWashColthesVC alloc]init];
//                washColthes.category = @"到店美发";
                washColthes.title =[self.serviceDic objectForKey:type_id];

                washColthes.merchant_id = _myModel.mid;
                washColthes.merchant_name = _myModel.name;
                washColthes.service_id = type_id;
                [self.navigationController pushViewController:washColthes animated:YES];
            }
                break;
                //到店美容
            case 23:
            {
                CMCWashColthesVC *washColthes = [[CMCWashColthesVC alloc]init];
//                washColthes.category = @"到店美容";
                washColthes.title =[self.serviceDic objectForKey:type_id];

                washColthes.merchant_id = _myModel.mid;
                washColthes.merchant_name = _myModel.name;
                washColthes.service_id = type_id;
                [self.navigationController pushViewController:washColthes animated:YES];
            }
                break;
                //上门美发
            case 24:
            {
                CMCWashColthesVC *washColthes = [[CMCWashColthesVC alloc]init];
//                washColthes.category = @"上门美发";
                washColthes.title =[self.serviceDic objectForKey:type_id];

                washColthes.merchant_id = _myModel.mid;
                washColthes.merchant_name = _myModel.name;
                washColthes.service_id = type_id;
                [self.navigationController pushViewController:washColthes animated:YES];
                
            }
                break;
                //上门美容
            case 25:
            {
                CMCWashColthesVC *washColthes = [[CMCWashColthesVC alloc]init];
//                washColthes.category = @"上门美容";
                washColthes.title =[self.serviceDic objectForKey:type_id];

                washColthes.merchant_id = _myModel.mid;
                washColthes.merchant_name = _myModel.name;
                washColthes.service_id = type_id;
                [self.navigationController pushViewController:washColthes animated:YES];
                
            }
                break;
            default:
                break;
        }
        
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


- (void)allBttAction:(CMCShopDetailIntroductionTVCell *)cell{
    NSIndexPath *indexPath = [_myTableView indexPathForCell:cell];
    if ([CMCUserManager shareManager].isClick) {
        [CMCUserManager shareManager].isClick = NO;
        
    }else{
        [CMCUserManager shareManager].isClick = YES;
    }
    [_myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


//跳转到百度地图界面
- (void)LookMapLocation{
    //初始化调启导航时的参数管理类
    BMKNaviPara* para = [[BMKNaviPara alloc]init];
    
    //指定导航类型
    para.naviType = BMK_NAVI_TYPE_WEB;
    
    //初始化起点节点
    BMKPlanNode* start = [[BMKPlanNode alloc] init];
    //指定起点经纬度
    CLLocationCoordinate2D coor1;
    coor1.latitude = [CMCUserManager shareManager].latitude;
    coor1.longitude = [CMCUserManager shareManager].longitude;
    start.pt = coor1;
    
    start.name = [CMCUserManager shareManager].location;
    //指定起点
    para.startPoint = start;
    
    
    
    //初始化终点节点
    BMKPlanNode* end = [[BMKPlanNode alloc] init];
    CLLocationCoordinate2D coor2;
//    coor2.latitude = self.latitude;
//    coor2.longitude = self.longitude;
    end.pt = coor2;
    para.endPoint = end;
    //指定终点名称
    end.name = _myModel.name;
    //指定调启导航的app名称
    para.appName = [NSString stringWithFormat:@"%@", @"testAppName"];
    //    para.appName = [NSString stringWithFormat:@"%@", @"十全客"];
    
    //调启web导航
    [BMKNavigation openBaiduMapNavigation:para];

}



#pragma mark - 公共方法 -
//根据字符串得到所占的高度
- (CGRect)_getSizeWithString:(NSString *)string withWidth:(NSInteger)width withHeight:(NSInteger)height{
    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize size = CGSizeMake(width, height);
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    return rect;
}

#pragma mark - UIAlertViewDelegate - 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
//        NSString *number = [alertView buttonTitleAtIndex:0];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_myModel.tel.firstObject]]];
        
    }

}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [CMCUserManager shareManager].isClick = NO;
}


#pragma mark end
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
