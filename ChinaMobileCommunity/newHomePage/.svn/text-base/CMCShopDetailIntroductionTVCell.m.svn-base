//
//  CMCShopDetailIntroductionTVCell.m
//  ChinaMobileCommunity
//
//  Created by mac on 14-11-18.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import "CMCShopDetailIntroductionTVCell.h"


@interface CMCShopDetailIntroductionTVCell ()

@property (nonatomic,strong)ButtonClickBlock block;

@end


@implementation CMCShopDetailIntroductionTVCell



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    [self createSubViews];
}


- (void)createSubViews{
    
    _contentLabel = [[UILabel alloc]init];
    
    _contentLabel.text = [NSString stringWithFormat:@"  %@",self.infoStr];
    _contentLabel.font = [UIFont systemFontOfSize:12.0];
    _contentLabel.numberOfLines = 0;
    _contentLabel.textColor = [UIColor colorWithHexString:@"666666"];
    
    
    self.lookBtt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    _lookBtt.titleLabel.font = [UIFont systemFontOfSize:13];
    [_lookBtt setTitleColor:[UIColor colorWithHexString:@"67b8fc"] forState:UIControlStateNormal];
    [_lookBtt addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([CMCUserManager shareManager].isClick) {
        [_lookBtt setTitle:@"收起" forState:UIControlStateNormal];
        CGRect rect = [CMCUserManager _getSizeWithString:self.infoStr withWidth:self.width - 30 withHeight:20000];
        _contentLabel.frame = CGRectMake(15,20,self.width - 30,rect.size.height);
    
    }else{
        _contentLabel.frame = CGRectMake(15, 20, self.width - 30, 50);
        [_lookBtt setTitle:@"全部" forState:UIControlStateNormal];
    }
     _lookBtt.frame  = CGRectMake(self.width - 30, _contentLabel.bottom + 4, 30, 13);
    
    [self.contentView addSubview:_contentLabel];
    [self.contentView addSubview:_lookBtt];
    
   
    
    
    
}
- (void)setupBlock:(ButtonClickBlock)myBlock{
    if (_block != myBlock) {
        _block = myBlock;
    }
}

- (void)buttonClickAction:(UIButton *)sender{
    if (_block) {
        _block();
    }
    
    
}



#pragma mark - 公共方法 -
//根据字符串得到所占的高度
- (CGRect)_getSizeWithString:(NSString *)string withWidth:(NSInteger)width withHeight:(NSInteger)height{
    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize size = CGSizeMake(width, height);
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    return rect;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatTitleLabel:(NSString *)title contentLabel:(NSString *)content
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 6, self.bounds.size.width - 10, 12)];
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:12.0];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor colorWithHexString:@"3a3a3a"];
    [self.contentView addSubview:titleLabel];
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, titleLabel.frame.size.height +titleLabel.frame.origin.y+11, self.bounds.size.width - 10, 44)];
    contentLabel.text = [NSString stringWithFormat:@"  %@",content];
    contentLabel.font = [UIFont systemFontOfSize:12.0];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:contentLabel];
}
@end
