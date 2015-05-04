//
//  CMCCommunityTableViewCell.h
//  ChinaMobileCommunity
//
//  Created by mac on 14-12-27.
//  Copyright (c) 2014年 zhangyanqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCCommunity.h"

typedef void(^RemoveFromSuperViewBlock)();

@interface CMCCommunityTableViewCell : UITableViewCell
{

    UILabel *communityLabel;
    UILabel *distanceLabel ;
    UILabel *placeLabel;
    
}
@property (nonatomic, strong) CMCCommunity *community;
- (void)creatTableViewcommunityLabel:(CMCCommunity *)community;

- (void)setupRemoveSuperViewBlock:(RemoveFromSuperViewBlock)myBlock;

@end
