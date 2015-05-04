//
//  CMCOrderFoodsVC.m
//  ChinaMobileCommunity
//
//  Created by 武鹏 on 14-11-18.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCOrderFoodsVC.h"
#import "CMCOrderCell.h"


@interface CMCOrderFoodsVC ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)UICollectionView *myCollectionView;//collectionView

- (void)creatSubViews;

@end

@implementation CMCOrderFoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatSubViews];//创建控件
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义方法 － 
- (void)creatSubViews{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(0.9 * self.view.frame.size.width, 0.45 * self.view.frame.size.width);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 3;
    layout.sectionInset = UIEdgeInsetsMake(0, 14, 0, 14);
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 20);
    self.myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:layout];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    self.myCollectionView.backgroundColor = [UIColor clearColor];
    
    //注册单元格
    [self.myCollectionView registerClass:[CMCOrderCell class] forCellWithReuseIdentifier:@"imageCell"];
//     [self.myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"detailCell"];
    
    [self.view addSubview:self.myCollectionView];
   
    
}

#pragma mark - 代理方法 － 


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *imageCell = @"imageCell";
    CMCOrderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageCell forIndexPath:indexPath];
    if (nil == cell) {
        cell = [[CMCOrderCell alloc]init];
    }
    if (indexPath.row % 2 == 0) {
    cell.str = @"ddd";
        cell.picImageView.frame = CGRectMake(0, 0, 0.25 * self.view.frame.size.height, 0.25 * self.view.frame.size.height);
        cell.picImageView.backgroundColor = [UIColor redColor];
        cell.detailImageView.frame = CGRectMake(20 + 0.25 * self.view.frame.size.height, 0, 0.25 * self.view.frame.size.height, 0.25 * self.view.frame.size.height);
        cell.detailImageView.backgroundColor = [UIColor greenColor];
    }else{
        cell.picImageView.frame = CGRectMake(20 + 0.25 * self.view.frame.size.height, 0, 0.25 * self.view.frame.size.height, 0.25 * self.view.frame.size.height);
        cell.picImageView.backgroundColor = [UIColor redColor];
        cell.detailImageView.frame = CGRectMake(0, 0, 0.25 * self.view.frame.size.height, 0.25 * self.view.frame.size.height);
        cell.detailImageView.backgroundColor = [UIColor greenColor];
    }

    
   
    
    return cell;
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
