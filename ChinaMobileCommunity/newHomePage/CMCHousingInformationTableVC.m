//
//  CMCHousingInformationTableVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-3.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCHousingInformationTableVC.h"
#import "CMCHouseInformationCell.h"
#import "CMCNewClassfyDianCan.h"
#import "CMCFoodModel.h"
#import "CMCHouseDetailVC.h"
#import "CMCGoodsDetailVC.h"

@interface CMCHousingInformationTableVC ()
{
    UITableView *_classifyTableView;
    UIView *_backView;


}
@property (nonatomic, strong) UITableView *shoppingTabelView;
@property (nonatomic, strong) NSMutableArray *dianCanArr;
@property (nonatomic, strong) NSMutableArray *dianCanClassfyArr;
@property (nonatomic, strong) NSString *urlStr;
@property (nonatomic,strong)  NSString  *numberOfOrder;
@property (nonatomic,strong)  NSMutableArray *numberArr;
@property (nonatomic, strong) NSMutableArray *detailArr;
@end
static BOOL isTure = YES;

@implementation CMCHousingInformationTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailArr = [[NSMutableArray alloc] init];
    _backView = [[UIView alloc] initWithFrame:self.view.bounds];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.dianCanArr = [[NSMutableArray alloc] init];
    self.dianCanClassfyArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadClassfyData];
    [self creatTopRightButton];
    [self creatTableView];
    [self didClickTopRightButton:nil];
}
- (void)creatTopRightButton
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 53, 33)];
    [button addTarget:self action:@selector(didClickTopRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"分类" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [button setBackgroundImage:[UIImage imageNamed:@"rightBar_btn"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItems = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItems;
}

#pragma mark - 分类
//点击分类
- (void)didClickTopRightButton:(UIButton *)button
{
    if (isTure == YES) {
        _classifyTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 100, 0, 100, 44 * self.dianCanClassfyArr.count)];
        _classifyTableView.delegate = self;
        _classifyTableView.dataSource = self;
        [BaseUtil setExtraCellLineHidden:_classifyTableView];
        [self.view addSubview:_classifyTableView];
        isTure = NO;
    }
    else if (isTure == NO) {
        [_classifyTableView removeFromSuperview];
        isTure = YES;
    }
    
}

- (void)creatTableView
{
    self.shoppingTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 60)];
    self.shoppingTabelView.delegate = self;
    self.shoppingTabelView.dataSource = self;
    
    
    [BaseUtil setExtraCellLineHidden:self.shoppingTabelView];
    [_backView addSubview:self.shoppingTabelView];
    
}
//加载数据
- (void)loadData:(NSString *)idStr
{
    NSLog(@"idStr = %@",idStr);
    [[CMCUserManager shareManager].dataDic removeAllObjects];
    [self.dianCanArr removeAllObjects];
//    [self creatTableView];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *timestamp = kAPI_timestamp;
    NSLog(@"^^^^^^^^^idStr %@",idStr);
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"mid":self.mid,@"type_id":idStr,@"page":@"1",@"nums":@"8",@"timestamp":timestamp,@"service_id":self.service_id};
    NSLog(@"dic = %@",dic);
    NSString *sig = KAPI_GetSig(dic);
    
    NSString *url = KAPI_MerchantGoodsList(self.mid, idStr, @"1",  @"8", sig,self.service_id);
    
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"respondObject = %@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        
        //[BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
        [BaseUtil errorMesssage:respondObject];
        
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                
                NSArray *dataArr = [respondObject objectForKey:@"data"];
                for (NSDictionary *tempDic in dataArr) {

                    CMCFoodModel *model = [CMCFoodModel foodWithDic:tempDic];
                    [self.detailArr addObject:tempDic];
                    [self.dianCanArr addObject:model];
                }
                NSLog(@"diancanArr ===== %@",self.dianCanArr);
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
                
            } else {
                [BaseUtil toast:@"此服务暂无商品"];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }
            
            [_shoppingTabelView reloadData];
            
        } else {
            [BaseUtil toast:@"数据加载失败,请重试"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
        }
    } failure:^(NSError *error) {
        
        
    }];
    
}

#pragma mark - 加载分类数据
//商户商品分类
- (void)loadClassfyData
{
    [self.dianCanClassfyArr removeAllObjects];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"mid":self.mid,@"timestamp":kAPI_timestamp,@"service_id":self.service_id};
    NSLog(@"dic = %@",dic);
    NSString *sig = KAPI_GetSig(dic);
    NSString *url = KAPI_MerchantType(self.mid, sig,self.service_id);
    
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"商户商品分类 =====%@",respondObject);
        NSDictionary *infoDic = [respondObject objectForKey:@"info"];
        if ([[infoDic objectForKey:@"result"] intValue] == 0) {
            if ([respondObject objectForKey:@"data"]) {
                NSArray *dataArr = [respondObject objectForKey:@"data"];
                for (NSDictionary *tempDic in dataArr) {
                    CMCNewClassfyDianCan *dianCanClassfy = [[CMCNewClassfyDianCan alloc] initWithDianCan:tempDic];
                    [self.dianCanClassfyArr addObject:dianCanClassfy];
                    
                }
                NSLog(@"diancanArr = %@",self.dianCanClassfyArr);
                CMCNewClassfyDianCan  *newClassfyDianCan = [self.dianCanClassfyArr objectAtIndex:0];
                
                [self loadData:newClassfyDianCan.id];
                [_classifyTableView reloadData];
                _classifyTableView.frame = CGRectMake(self.view.bounds.size.width - 100, 0, 100, 44 * self.dianCanClassfyArr.count);
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            } else {
                
                [BaseUtil toast:@"此服务暂无商品"];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
            }
        } else {
            [BaseUtil toast:@"服务端数据错误,请重试"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (tableView == _shoppingTabelView) {
        return self.dianCanArr.count;

    }
    if (tableView == _classifyTableView) {
        return self.dianCanClassfyArr.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _shoppingTabelView) {
        static NSString *str = @"reused";
        CMCHouseInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CMCHouseInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        
        if (self.dianCanArr.count) {
            CMCFoodModel *model = [self.dianCanArr objectAtIndex:indexPath.row];
            // Configure the cell...
//            cell.foodModel = model;
            cell.category = self.title;
            [cell creatHouseInformationCell:model];
        }
        return cell;
    }
    if(_classifyTableView == tableView){
        static NSString *str = @"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        CMCNewClassfyDianCan *dianCanClassfy = [self.dianCanClassfyArr objectAtIndex:indexPath.row];
        cell.textLabel.text = dianCanClassfy.name;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor colorWithHexString:@"656565"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        
        return cell;
    }
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.shoppingTabelView == tableView) {
        return 100;

    }
    if (_classifyTableView == tableView) {
        return 44;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.shoppingTabelView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_classifyTableView == tableView) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        CMCNewClassfyDianCan *dianCanClassfy = [self.dianCanClassfyArr objectAtIndex:indexPath.row];
        self.urlStr = dianCanClassfy.id;
        [self loadData:self.urlStr];
        [_classifyTableView removeFromSuperview];
        isTure = YES;
    }
    if (self.shoppingTabelView == tableView) {
        if ([self.title isEqualToString:@"家政服务"]) {
            CMCFoodModel *foodModel = [self.dianCanArr objectAtIndex:indexPath.row];
            CMCGoodsDetailVC *goodsDetailVC = [[CMCGoodsDetailVC alloc] init];
            goodsDetailVC.mid = self.mid;
            goodsDetailVC.goodsId = foodModel.id;
            goodsDetailVC.titleStr = self.title;
            goodsDetailVC.service_id = self.service_id;
            
            [self.navigationController pushViewController:goodsDetailVC animated:YES];
            
        }else{
        
            CMCFoodModel *foodModel = [self.dianCanArr objectAtIndex:indexPath.row];
            CMCHouseDetailVC *houseDetailVC = [[CMCHouseDetailVC alloc] init];
            houseDetailVC.mid = self.mid;
            houseDetailVC.goodsId = foodModel.id;
            houseDetailVC.service_id = self.service_id;
            [self.navigationController pushViewController:houseDetailVC animated:YES];
        }

    }

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
