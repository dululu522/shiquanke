//
//  CMCMyVoucherDetailVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-1-5.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCMyVoucherDetailVC.h"

#import "CycleScrollView.h"
#import "CMCMyVoucherTableViewCell.h"
#import "CMCAccountVouchers.h"
//#import "GTMBase64.h"
#import "CMCDiscountDetailCell.h"
#import "CMCBuyMustKnowCell.h"
#import "CMCMyVoucherPackageCell.h"
#import "CMCMyScrollView.h"
#import "CMCMyVoucherNumberPSDCell.h"
#import "CMCMyVoucherOrderDetailVC.h"


@interface CMCMyVoucherDetailVC ()
{

    UIView *_backScrollView;
}
@property (nonatomic, strong)  UITableView *detailTableView;
@property (nonatomic, strong) CycleScrollView *myScrollview;
@property (nonatomic, strong) NSMutableArray *couponArr;
@property (nonatomic, strong) NSMutableArray *vouchersArr;
@property (nonatomic,strong)UIImageView *bannerImgV;
@property (nonatomic,strong) CMCMyScrollView *mainScorllView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation CMCMyVoucherDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.couponArr = [[NSMutableArray alloc] init];
    self.vouchersArr = [[NSMutableArray alloc] init];
//    _select = NO;
//    self.accountVoucherArr = [[NSMutableArray alloc] init];
    [self createSubViews];
    NSLog(@"self.voucherDic ======%@",self.voucherDic);

}
- (void)creatTableView
{

    self.detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    [self.detailTableView setSeparatorColor:[UIColor colorWithHexString:@"ededed"]];
    [self.view addSubview:self.detailTableView];
    self.detailTableView.tableHeaderView = _backScrollView;
}
#pragma mark - 创建子视图-
- (void)createSubViews{
    [self creatScrollViewAndPagControl];
    [self creatTableView];
    [self loadData];

    
}

- (void)creatScrollViewAndPagControl
{
    _backScrollView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.3 * self.view.bounds.size.height)];
    self.mainScorllView = [[CMCMyScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.3 * self.view.bounds.size.height) animationDuration:2];
    [_backScrollView addSubview:self.mainScorllView];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.frame = CGRectMake(0, 155, self.view.bounds.size.width, 25);//0, 0, 320, 25
    _pageControl.numberOfPages = 0;
    _pageControl.currentPage = 0;
    [_backScrollView addSubview:_pageControl];
    
    
}
#pragma mark -
#pragma mark - 滚动条
- (void)creatScrollViewArr:(NSArray *)bannaImageArr
{
    NSLog(@"*********%@",bannaImageArr);
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < bannaImageArr.count; i++) {
        if ([[bannaImageArr objectAtIndex:i] length]) {
            NSURL *url = [BaseUtil systemRandomlyGenerated:[bannaImageArr objectAtIndex:i] type:@"20" number:@"6"];
            [arr addObject:url];
        }

        
    }
    
    self.mainScorllView.dataArr = arr;
    [self.mainScorllView setupTapActionBlock:^(NSInteger pageIndex) {
        NSLog(@"===== %ld",(long)pageIndex);
    }];
    [_backScrollView addSubview:self.mainScorllView];
    
    
}
- (void)loadData
{
    [self.couponArr removeAllObjects];
    [self.vouchersArr removeAllObjects];
    CMCAccountVouchers *accountVoucher = [[CMCAccountVouchers alloc] initWithAccountVouchers:self.voucherDic];
    NSString *imageStr = [accountVoucher.detail objectForKey:@"image"];
    NSArray *imageArr = [imageStr componentsSeparatedByString:@","];
    [self creatScrollViewArr:imageArr];
    [self.couponArr addObject:accountVoucher];
    [self.detailTableView reloadData];

    
}

#pragma mark - tableviewDelegate -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 48;
    }
    if (section == 1) {
        return 26;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //第一分区
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if ([self.category isEqualToString:@"折扣券详情"]) {
                return 100;

            }
            if ([self.category isEqualToString:@"代金券详情"]) {
                return 120;
            }
        }
        if (indexPath.row == 1) {
            return 45;
        }
    }
    
    //第二分区
    if (indexPath.section == 1) {
        return 20;

    }
    
    NSString *content;
    if (self.couponArr.count) {
        CMCAccountVouchers *couponDetail = [self.couponArr objectAtIndex:0];
        content = [couponDetail.detail objectForKey:@"notice"];
    }
    
    CGRect rect =   [BaseUtil returnHeightWithContent:content WithFont:12.0 width:self.view.width - 32 height:0];
    
    return rect.size.height + 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    if (section == 1) {

        return 1;
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, self.view.width, 30);
    view.backgroundColor = k_color(@"f5f4f4");
    
    //第一分区
    if (section == 0) {
        UILabel *priceL = [[UILabel alloc]init];
        priceL.frame = CGRectMake(10, 14, 50, 22);
        priceL.font = k_font(18);
        priceL.textColor = k_color(@"ff0200");
        [view addSubview:priceL];
        
        //立即下载和立即购买
        UIButton *btt = [UIButton buttonWithType:UIButtonTypeCustom];
        btt.frame = CGRectMake(self.view.width - 11 - 79, 11, 79, 27);
//        [btt addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
        btt.titleLabel.font = k_font(12);
        [btt setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
        if ([self.category isEqualToString:@"折扣券详情"]) {
            if (self.couponArr.count) {
                CMCAccountVouchers *couponDetail = [self.couponArr objectAtIndex:0];
                priceL.text = [NSString stringWithFormat:@"%@折",[couponDetail.detail objectForKey:@"discount"]];
                
            }
            [btt setTitle:@"可使用" forState:UIControlStateNormal];
            
        }else{
            if (self.couponArr.count) {
                CMCAccountVouchers *vouchersDetail = [self.couponArr objectAtIndex:0];
                priceL.text = [NSString stringWithFormat:@"¥ %@",[vouchersDetail.detail objectForKey:@"money_buy"]];
                [btt setTitle:@"申请退款" forState:UIControlStateNormal];
                [btt addTarget:self action:@selector(didClickApplyforRefund:) forControlEvents:UIControlEventTouchUpInside];
                UILabel *oldPL = [[UILabel alloc]init];
                oldPL.frame = CGRectMake(priceL.right + 8,25,  100, 10);
                oldPL.font = k_font(10);
                oldPL.textColor = k_color(@"acacac");
                oldPL.text = [NSString stringWithFormat:@"¥%@",[vouchersDetail.detail objectForKey:@"money_use"]];
                [BaseUtil setCenterLineView:oldPL];
                [view addSubview:oldPL];
            }
        }
        [view addSubview:btt];
        
        
    }
    
    //第二分区
    if (section == 1 | section == 2) {
        UILabel *nameL = [[UILabel alloc] init];
        nameL.frame = CGRectMake(0, 10, self.view.width, 13);
        nameL.textColor = k_color(@"444444");
        nameL.font = k_font(13);
        if (section == 1) {
            nameL.text = @"   优惠详情";
        }else{
            nameL.text = @"   购买须知";
        }
        [view addSubview:nameL];
    }
    
    return view;
}
#pragma mark - 申请退款
- (void)didClickApplyforRefund:(UIButton *)button
{
    CMCMyVoucherOrderDetailVC *orderDetailVC = [[CMCMyVoucherOrderDetailVC alloc] init];
    orderDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderDetailVC animated:YES];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //折扣券详情
//    if ([self.category isEqualToString:@"折扣券详情"]) {
        if (indexPath.row == 0 && indexPath.section == 0) {
//            CMCInofCell *cell = [[CMCInofCell alloc]init];
            CMCMyVoucherPackageCell *cell = [[CMCMyVoucherPackageCell alloc] init];
            if (self.couponArr.count) {
                CMCAccountVouchers *couponDetail = [self.couponArr objectAtIndex:0];
                cell.couponDetail = couponDetail;
                cell.category = self.category;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 1 && indexPath.section == 0) {
            CMCMyVoucherNumberPSDCell *cell = [[CMCMyVoucherNumberPSDCell alloc]init];
            if (self.couponArr.count) {
                CMCAccountVouchers *couponDetail = [self.couponArr objectAtIndex:0];
                cell.couponDetail = couponDetail;
            }
            cell.category = self.category;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
        if (indexPath.section == 1) {
            static NSString *cellIndentifier = @"discountDetailCell";
            
            CMCDiscountDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (nil == cell) {
                cell = [[CMCDiscountDetailCell alloc]init];
                cell.category = self.category;
            }
            if (self.couponArr.count) {
                CMCAccountVouchers *couponDetail = [self.couponArr objectAtIndex:0];
                cell.textLabel.text = [couponDetail.detail objectForKey:@"intro"];
                cell.textLabel.textColor = [UIColor colorWithHexString:@"656565"];
                cell.textLabel.font = k_font(12);
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
        if (indexPath.section == 2) {
            
          
           UITableViewCell *cell = [[UITableViewCell alloc]init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *contentL = [[UILabel alloc]init];
            contentL.frame = CGRectMake(16, 10, self.view.width - 32, 12);
            contentL.font = k_font(12);
            contentL.textColor = k_color(@"656565");
            contentL.numberOfLines = 0;
            NSString *content;
            if (self.couponArr.count) {
                CMCAccountVouchers *couponDetail = [self.couponArr objectAtIndex:0];
                content = [couponDetail.detail objectForKey:@"notice"];
            }
            
            CGRect heigh =   [BaseUtil returnHeightWithContent:content WithFont:12.0 width:self.view.width - 32 height:0];
            contentL.frame = CGRectMake(16, 10, self.view.width - 32, heigh.size.height);
            contentL.text = content;
            [cell.contentView addSubview:contentL];
            
            return cell;
        }
//    }
    return nil;
    
}
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
