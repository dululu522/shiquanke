//
//  CMCPhotoLibaryVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-2.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPhotoLibaryVC.h"
#import "CMCPhotoDisPlayVC.h"


@interface CMCPhotoLibaryVC ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)UICollectionView *myCollectionView;



@end

@implementation CMCPhotoLibaryVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"相册";
    // Do any additional setup after loading the view.
    [self createSubViews];
//    [self loadData];
    
}

#pragma mark - 创建子视图 － 

- (void)createSubViews{
    [self setupCollectionView];
    
}

- (void)setupCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(149, 117);
    layout.sectionInset = UIEdgeInsetsMake(7, 5, 5, 7);
    
    _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) collectionViewLayout:layout];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    _myCollectionView.backgroundColor = [UIColor whiteColor];
    _myCollectionView.directionalLockEnabled = YES;
    
    [_myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    
    [self.view addSubview:_myCollectionView];
    
    
}

#pragma mark - 数据请求 - 

- (void)loadData{
    NSDictionary *dic = @{@"channel":KAPI_NewChannel,@"app_ver":APPVersion,@"cid":[CMCUserManager shareManager].cid,@"mid":self.mid,@"zid":[CMCUserManager shareManager].zid,@"timestamp":kAPI_timestamp};
    NSString *sig = KAPI_GetSig(dic);
    NSString *url = KAPI_MerchantAlbum(self.mid, sig);
    [BaseUtil get:url success:^(id respondObject) {
        NSLog(@"--------------%@",respondObject);
        if (IsSuccess) {
            self.imgArr = [[respondObject objectForKey:@"data"] objectForKey:@"image"];
        }
        [_myCollectionView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}




#pragma mark - collectionViewDelegate - 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"item";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 149, 117)];
    imageView.backgroundColor = [UIColor orangeColor];
    imageView.userInteractionEnabled = YES;
    NSURL *url = [BaseUtil systemRandomlyGenerated:_imgArr[indexPath.row] type:@"" number:@"1"];
    [imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"log"]];
    [cell.contentView addSubview:imageView];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CMCPhotoDisPlayVC *playVC = [[CMCPhotoDisPlayVC alloc]init];
    playVC.num = indexPath.row + 1;
    playVC.dataArr = _imgArr;
    [self.navigationController pushViewController:playVC animated:YES];
    
    
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
