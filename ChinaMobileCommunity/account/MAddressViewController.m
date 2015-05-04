//
//  MAddressViewController.m
//  shiquanke
//
//  Created by zt on 14-6-30.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "MAddressViewController.h"

#import "AddAddressViewController.h"
#import "AddressTableViewCell.h"

@interface MAddressViewController ()<AddressTableViewCellDelegate,AddAddressViewControllerDelegate,AddAddressViewControllerDelegate>
{

    BOOL flag;
    
    NSInteger _number;

}
@property (nonatomic, strong) NSMutableArray* datasArray;
@property (nonatomic ,strong) NSIndexPath* modifyIndex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *addressArr;
@end

@implementation MAddressViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.addressArr = [[NSMutableArray alloc] init];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UIImageView *addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, 20, 20, 20)];
    addImageView.image = [UIImage imageNamed:@"my_addAddress"];
    [backView addSubview:addImageView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectMake(addImageView.right, 20, 80, 20)];
    addLabel.text = @" 添加地址";
    addLabel.font = [UIFont systemFontOfSize:18.0];
    [backView addSubview:addLabel];
    UIButton *addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addAddressBtn addTarget:self action:@selector(didAddAddressBtn:) forControlEvents:UIControlEventTouchUpInside];
    addAddressBtn.frame = backView.bounds;
    [backView addSubview:addAddressBtn];
    
    
    self.title = @"地址编辑";
    self.datasArray = [[NSMutableArray alloc] init];
    [self loadData];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, self.view.bounds.size.width, self.view.bounds.size.height - 120)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    flag = NO;
    [BaseUtil setExtraCellLineHidden:self.tableView];
    if (self.titleStr) {
        [self creatButton];
        
    }else {
        
        
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

//    _delRequest = [[NetWorkRequest alloc] init];
//    _delRequest.delegate = self;

    

}
#pragma mark- 确认按钮
- (void)creatButton
{
    UIButton *makeSureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    makeSureBtn.frame = CGRectMake(20, self.view.bounds.size.height - 120, self.view.frame.size.width - 40, 40);
    [makeSureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:kAPI_AllMainColor];
    [makeSureBtn addTarget:self action:@selector(didClickMakeSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeSureBtn];
}
- (void)didClickMakeSureBtn:(UIButton *)btn
{
    //0319
    if ([self.addressArr isKindOfClass:[NSArray class]]) {
        if ([self.addressArr count]) {
            NSLog(@"%@",self.addressArr);
            NSLog(@"呵呵呵呵 %@",[self.addressArr objectAtIndex:_number]);

            //将用户选择的地址存储到本地
            [[NSUserDefaults standardUserDefaults] setObject:[self.addressArr objectAtIndex:_number] forKey:@"selectAddress"];
        } else {
        
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"selectAddress"];
        }
    } else {
    
                [[NSUserDefaults standardUserDefaults] setObject:[self.addressArr objectAtIndex:_number] forKey:@"selectAddress"];
    }
    
    

    [self.navigationController popViewControllerAnimated:YES];

}
//添加地址
- (void)didAddAddressBtn:(UIButton *)button
{
    AddAddressViewController* add = [[AddAddressViewController alloc]init];
    add.delegate = self;
    [self.navigationController pushViewController:add animated:YES];



}
//修改地址
- (void)didModifyAddress:(AddressTableViewCell *)cell
{
        AddAddressViewController* add = [[AddAddressViewController alloc]init];
        add.isModify = YES;
        _modifyIndex = [self.tableView indexPathForCell:cell];
        add.aitem = cell.item;
        add.delegate = self;
        [self.navigationController pushViewController:add animated:YES];

}

- (void)hh
{
    [self.tableView reloadRowsAtIndexPaths:@[_modifyIndex] withRowAnimation:UITableViewRowAnimationMiddle];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshHeaderData
{
    NSLog(@"刷新");
    [self loadData];
}

- (void)refreshFooterData
{
    NSLog(@"更多");
//    [self reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datasArray count];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:YES animated:YES];
    return UITableViewCellEditingStyleDelete;
}
//进入编辑模式，按下出现的编辑按钮后

 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
     NSLog(@"aaaaaaaaaaaaaaa");
 // Delete the row from the data source

     CMCAddressItem *addressItem = [self.datasArray objectAtIndex:indexPath.row];
     [self deleteAddress:addressItem];
     [self.datasArray removeObjectAtIndex:indexPath.row];
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedAddress:)]) {
//        [self.delegate didSelectedAddress:self.datasArray[indexPath.row]];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    _number = indexPath.row;
    AddressTableViewCell *cell = (AddressTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.editButton setBackgroundImage:[UIImage imageNamed:@"my_selectAddress"] forState:UIControlStateNormal];
//    if (self.titleStr) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"addresstableviewcell";
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddressTableViewCell" owner:self options:0] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell fullDataFromItem:self.datasArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressTableViewCell *cell = (AddressTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    [cell.editButton setBackgroundImage:[UIImage imageNamed:@"my_address"] forState:UIControlStateNormal];

}


#pragma mark-
#pragma mark- 选择地址
-(void)didEditAddress:(AddressTableViewCell *)cell
{
    
        [cell.editButton setBackgroundImage:[UIImage imageNamed:@"my_selectAddress"] forState:UIControlStateNormal];


}
//删除地址
#pragma mark-
#pragma mark- 删除地址
-(void)deleteAddress:(CMCAddressItem *)item
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (item.id && [CMCUserManager shareManager].token) {
        //        NSString *sig = KAPI_DeladdressSig(cell.item.id, [CMCUserManager shareManager].token);
        NSString *timestamp = kAPI_timestamp;
        NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"address_id":item.id,@"timestamp":timestamp};
        NSLog(@"删除地址requestStr  %@",dic);
        
        
        NSString *sig = [BaseUtil getSigWithArray:dic];
        NSLog(@"删除地址sig=%@",sig);
        NSString *requestStr = KAPI_Deladdress(item.id, timestamp, [CMCUserManager shareManager].token, [BaseUtil md5:sig]);
        NSLog(@"删除地址requestStr  %@",requestStr);
        [BaseUtil get:requestStr success:^(id respondObject) {
            NSLog(@"删除地址 :%@",respondObject);
            NSDictionary *infoDic = [respondObject objectForKey:@"info"];
            
            [BaseUtil pushToLoginVCWithRespondObj:respondObject withViewController:self];
            [BaseUtil errorMesssage:respondObject];
            
            if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                //                [self deleteCellData:cell];
                [self.tableView reloadData];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }
            
        } failure:^(NSError *error) {
            
        }];
        
        
    }
}
-(void)didAddAddress:(CMCAddressItem *)item
{
    [self.datasArray addObject:item];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.datasArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
}
#pragma mark - 获取我的地址数据
- (void)loadData
{
    //0319
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *timestamp = kAPI_timestamp;
    if ([CMCUserManager shareManager].token) {
        NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"token":[CMCUserManager shareManager].token,@"app_ver":APPVersion,@"timestamp":timestamp};
        NSLog(@"我的地址:%@",dic);
        NSString *sig= [BaseUtil getSigWithArray:dic];
        NSString *requestStr = KAPI_Myaddress(timestamp, [CMCUserManager shareManager].token, [BaseUtil md5:sig]);
        NSLog(@"我的地址requestStr :%@",requestStr);
        
        [BaseUtil get:requestStr success:^(id respondObject) {
            NSLog(@"%@",respondObject);
            [self.datasArray removeAllObjects];
            
            NSDictionary *infoDic = [respondObject objectForKey:@"info"];
            
            [BaseUtil pushToLoginVCWithRespondObj:respondObject  withViewController:self];
            [BaseUtil errorMesssage:respondObject];
            
            if ([[infoDic objectForKey:@"result"] intValue] == 0) {
                if ([respondObject objectForKey:@"data"]) {
                    NSArray *dataArr = [respondObject objectForKey:@"data"];
                    for (NSDictionary *tempDic in dataArr) {
                        [self.datasArray addObject:[CMCAddressItem fromDict:tempDic]];
                        [self.addressArr addObject:tempDic];
                        
                    }
                    NSLog(@"self.addressArr %@",self.addressArr);
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [self.tableView reloadData];
                } else {
                    [BaseUtil toast:@"暂无收货地址"];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    return;
                    
                }
            } else {
                
                [BaseUtil toast:@"数据加载失败,请重新加载"];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                return;
                
            }
            
            
        } failure:^(NSError *error) {
            
        }];
    }else{
       
    }
    
}



- (void)deleteCellData:(AddressTableViewCell *)cell
{

    [self.datasArray removeObject:cell.item];
[self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationLeft];


}

@end