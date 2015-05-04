//
//  CMCPaketDetailVC.h
//  ChinaMobileCommunity
//
//  Created by mac on 15-3-6.
//  Copyright (c) 2015年 zhangyanqiu. All rights reserved.
//

#import "CMCPublicClassViewController.h"
#import "CMCPacket.h"//0318
@interface CMCPaketDetailVC : CMCPublicClassViewController

@property (nonatomic,strong)NSString *bonusID;
@property (nonatomic,strong)CMCPacket *dataModel;


@end
