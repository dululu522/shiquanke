//
//  CMCPhotoDisPlayVC.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-2.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPhotoDisPlayVC.h"
#import "PictureDisplay.h"

@interface CMCPhotoDisPlayVC ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *btmScrlV;
@property (nonatomic,strong)UILabel *numL;//查看第几张


@end

@implementation CMCPhotoDisPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.title = [NSString stringWithFormat:@"%d/%d",_num,_dataArr.count];
    // Do any additional setup after loading the view.
    [self createSubViews];
    
}

#pragma mark - 创建子视图 － 
- (void)createSubViews{
    
    [self setupbttmScrollView];
//    [self setupLable];
}

- (void)setupLable{
    _numL = [[UILabel alloc]init];
    _numL.frame = CGRectMake((self.view.width - 100) / 2, 15, 100, 40);
    _numL.text = [NSString stringWithFormat:@"%d/%d",_num,_dataArr.count];
    _numL.textAlignment = NSTextAlignmentCenter;
    _numL.textColor = [UIColor whiteColor];
    _numL.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_numL];
    
    
}

- (void)setupbttmScrollView{
    _btmScrlV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
    _btmScrlV.pagingEnabled = YES;
    _btmScrlV.bounces = NO;//
    _btmScrlV.delegate = self;
    _btmScrlV.contentSize = CGSizeMake(self.view.width * self.dataArr.count, self.view.height - 64);
    _btmScrlV.contentOffset = CGPointMake(self.view.width * (self.num - 1), 0);
    [self.view addSubview:_btmScrlV];
    NSLog(@"dataArr ==== %@",self.dataArr);
    for (int i = 0; i < self.dataArr.count; i++) {
        NSURL *url = [BaseUtil systemRandomlyGenerated:self.dataArr[i] type:@"" number:@""];
        NSLog(@"======url = %@",url);
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            UIImage *image = [UIImage imageWithData:responseObject];
            PictureDisplay *pic = [PictureDisplay pictureWith:image withFrame:CGRectMake(i * self.view.width, 0, self.view.width, self.view.height)];
//            pic.backgroundColor = [UIColor orangeColor];
            [_btmScrlV addSubview:pic];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        [operation start];
    }
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int i = scrollView.contentOffset.x / self.view.width + 1;
    _numL.text = [NSString stringWithFormat:@"%d/%d",i,_dataArr.count];
    self.title = [NSString stringWithFormat:@"%d/%d",i,_dataArr.count];
    
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
