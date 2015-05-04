//
//  CMCUserCommentVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-13.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCUserCommentVC.h"
#import "CMCCommentCell.h"
#import "CMCPhotoDisPlayVC.h"

@interface CMCUserCommentVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *commentArr;
@property (nonatomic,assign)int page;

@end

@implementation CMCUserCommentVC

- (NSMutableArray *)commentArr{
    if (_commentArr == nil) {
        self.commentArr = [NSMutableArray array];
    }
    return _commentArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"网友点评";
    _page = 1;
    // Do any additional setup after loading the view.
    [self createSubViews];
    [self loadData];
    
}



#pragma mark - 加载数据 － 
- (void)loadData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *timestamp = kAPI_timestamp;
    NSString *page = [NSString stringWithFormat:@"%d",_page];
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"mid":self.mid,@"page":page,@"nums":@"8",@"timestamp":timestamp};
    
    NSString *sig = KAPI_GetSig(dic);
    
    NSString *url = KAPI_EvaluateList(self.mid,page, @"8",timestamp,sig);
    NSLog(@"url ==== %@",url);
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"respondObject ====== %@",respondObject);
        if ([[[[respondObject objectForKey:@"info"] objectForKey:@"result"] stringValue] isEqualToString:@"0"]) {
            NSArray *commentArr = [respondObject objectForKey:@"data"];
            for (NSDictionary *tmpDic in commentArr) {
                [self.commentArr addObject:tmpDic];
                
            }
            [_myTableView reloadData];
        }
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [BaseUtil toast:@"数据加载失败"];
        
    }];
    
    
    
    
    
    
    
}

#pragma mark - 创建子视图 - 
- (void)createSubViews{
    
    [self setupTableView];
    
    
}

- (void)setupTableView{
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_myTableView];
}


#pragma mark - tableviewDelegate -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _commentArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //得到尺寸
    NSDictionary *dataDic = _commentArr[indexPath.row];
    NSString *contentStr = [dataDic objectForKey:@"content"];
    CGRect rect = [CMCUserManager _getSizeWithString:contentStr withWidth:self.view.width - 46 withHeight:20000];
    
    NSArray *array = [dataDic objectForKey:@"image"];
    CGFloat imgF = 0.0;
    if (array.count >= 1) {
        if (array.count == 1) {
            if ([array.firstObject isEqualToString:@""]) {
                imgF = 0.0;
            }else{
                imgF = 40;
            }
        }else{
            imgF = 40;
        }
        
    }else{
        imgF = 0.0;
    }
    return 10 + 32 + 7.5 + rect.size.height + 10 + imgF;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"cell";
    CMCCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (nil == cell) {
        cell = [[CMCCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    NSDictionary *dataDic = _commentArr[indexPath.row];
    cell.dataDic = dataDic;
    [cell setupTapBlock:^(int num) {
        CMCPhotoDisPlayVC *playVC = [[CMCPhotoDisPlayVC alloc]init];
        playVC.num = num + 1;
        
        NSArray *array = [dataDic objectForKey:@"image"];
        if (array.count) {
            
            NSMutableArray *dataArr = [NSMutableArray array];
            for (NSString *string in array) {
                
                [dataArr addObject:string];
                
            }
            NSLog(@"dataArr ==== %@",dataArr);
            playVC.dataArr = [NSArray arrayWithArray:dataArr];
            [self.navigationController pushViewController:playVC animated:YES];
        }
        
    }];

    
    return cell;
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
