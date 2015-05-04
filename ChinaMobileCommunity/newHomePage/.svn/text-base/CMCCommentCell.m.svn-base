//
//  CMCCommentCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 15-2-4.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCCommentCell.h"
#import "UIViewExt.h"
#import "CommentStarView.h"
#import "StarView.h"

@interface CMCCommentCell ()
{
    UIImageView *imgView;
    CommentStarView *star;
    UILabel *timeL;
    UILabel *contentL;
}

@property (nonatomic,strong)NSArray *imgArr;
@property (nonatomic,strong)tapBlock block;


@end


@implementation CMCCommentCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    [self createSubViews];
}



//0317
- (void)createSubViews{
    [imgView removeFromSuperview];
    [star removeFromSuperview];
    [timeL removeFromSuperview];
    [contentL removeFromSuperview];
    
    for (int i = 0;i < self.imgArr.count; i++) {
        UIImageView *imageV = (UIImageView *)[self.contentView viewWithTag:80000 + i];
        [imageV removeFromSuperview];
    }
    
    UIView *view = (UIView *)[self.contentView viewWithTag:80000 + 50];
    [view removeFromSuperview];
    
    
    imgView = [[UIImageView alloc]init];
    imgView.frame = CGRectMake(14, 10, 32, 32);
    imgView.image = [UIImage imageNamed:@"log"];
    imgView.layer.cornerRadius = 16;
    imgView.clipsToBounds = YES;
    
    
    NSString *user = [BaseUtil md5:[_dataDic objectForKey:@"uid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@1/%@/%@_1.jpg",[CMCUserManager shareManager].file_url,[user substringWithRange:NSMakeRange(0, 2)],[user lowercaseString]];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
    if (image) {
        imgView.image = image;
    }
    
    
    [self.contentView addSubview:imgView];
    
    
    star = [[CommentStarView alloc]initWithFrame:CGRectMake(imgView.right + 6, 20, 150, 14)];
    star.startNum = [[_dataDic objectForKey:@"star"] integerValue];
    star.titleStr = [_dataDic objectForKey:@"nickname"];
    [self.contentView addSubview:star];
    
    
    //时间
    timeL = [[UILabel alloc]init];
    timeL.frame = CGRectMake(self.width - 110, 20, 100, 11);
    if ([[_dataDic objectForKey:@"image"] isKindOfClass:[NSString class]]) {
        timeL.text = [BaseUtil becomeNormalWithString:[_dataDic objectForKey:@"create_time"]];
    }else{
        timeL.text = [_dataDic objectForKey:@"create_time"];
    }
    
    timeL.textAlignment = NSTextAlignmentRight;
    timeL.font = [UIFont systemFontOfSize:10];
    timeL.textColor = [UIColor colorWithHexString:@"bebebe"];
    [self.contentView addSubview:timeL];
    
    
    //得到尺寸
    NSString *contentStr = [_dataDic objectForKey:@"content"];
    CGRect rect = [CMCUserManager _getSizeWithString:contentStr withWidth:self.width - 46 withHeight:20000];
    
    //评价的具体内容
    contentL = [[UILabel alloc]init];
    contentL.frame = CGRectMake(23, imgView.bottom + 7.5, self.width - 46, rect.size.height);
    contentL.text = contentStr;
    contentL.numberOfLines = 0;
    contentL.textColor = [UIColor colorWithHexString:@"7c7c7c"];
    contentL.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:contentL];
    
    
    NSMutableArray *dataArr = [NSMutableArray array];
    if ([[_dataDic objectForKey:@"image"] isKindOfClass:[NSString class]]) {
        NSString *imageStr = [_dataDic objectForKey:@"image"];
        if (imageStr.length > 1) {
            NSArray *imgArr = [imageStr componentsSeparatedByString:@","];
            
            for (NSString *string in imgArr) {
                NSURL *url = [BaseUtil systemRandomlyGenerated:string type:@"" number:@"1"];
                [dataArr addObject:url];
                
            }
            
        }
    }else{
        NSArray *imageArr = [_dataDic objectForKey:@"image"];
        if (imageArr.count >= 1) {
            for (NSString *string in imageArr) {
                if (![string isEqualToString:@""]) {
                    NSURL *url = [BaseUtil systemRandomlyGenerated:string type:@"" number:@"1"];
                    
                    [dataArr addObject:url];
                }
            }
        }
    }
    
    self.imgArr = [NSArray arrayWithArray:dataArr];
    //展示图片
    for (int i = 0; i < self.imgArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(23 + (25 + 15) * i, contentL.bottom + 10, 30, 25);
        [imageView setImageWithURL:self.imgArr[i] placeholderImage:[UIImage imageNamed:@"log"]];
        imageView.tag = 80000 + i;
        imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        
    }
    
    
    //分割线
    UIView *sepeV = [[UIView alloc]init];
    sepeV.tag = 80000 + 50;
    sepeV.frame = CGRectMake(10,self.height - 0.5, self.width - 20, 0.5);
    sepeV.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:sepeV];
    
    
}




- (void)tap:(UITapGestureRecognizer *)tap{
    UIImageView *imageV = (UIImageView *)tap.view;
    if (_block) {
        _block(imageV.tag - 80000);
    }
    
    
}

- (void)setupTapBlock:(tapBlock)myBlock{
    
    if (_block != myBlock) {
        _block = myBlock;
    }
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
