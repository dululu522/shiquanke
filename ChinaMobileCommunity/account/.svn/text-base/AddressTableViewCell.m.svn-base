//
//  AddressTableViewCell.m
//  shiquanke
//
//  Created by zt on 14-6-30.
//  Copyright (c) 2014年 zt. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}
- (void)fullDataFromItem:(CMCAddressItem*)item
{
    self.item = item;
    [self.editButton setBackgroundImage:[UIImage imageNamed:@"my_address"] forState:UIControlStateNormal];
    self.editButton.userInteractionEnabled = NO;
    [self.modifyButton setBackgroundImage:[UIImage imageNamed:@"myaddr_modefy"] forState:UIControlStateNormal];
    self.modifyButton.userInteractionEnabled = YES;
    self.nameLabel.text = [NSString stringWithFormat:@"收货人:%@ ",item.name];
    self.phoneLabel.text = [NSString stringWithFormat:@"手机:%@",item.phone];
    self.addressLabel.text = [NSString stringWithFormat:@"地址:%@  ",item.address];
    NSLog(@"=====%@",self.addressLabel.text);
}

- (void)hideRightButton
{
    self.editButton.hidden = YES;
//    self.delButton.hidden = YES;
    self.modifyButton.hidden = YES;
}

- (IBAction)delButtonClick:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didDeleteAddress:)]) {
        [self.delegate didDeleteAddress:self];
    }
}
//是否选择
- (IBAction)editButtonClick:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didEditAddress:)]) {
        [self.delegate didEditAddress:self];
    }
}
- (IBAction)didClickModifyButton:(id)sender {
    
    NSLog(@"hehhhehehheh ");
    if (self.delegate &&[self.delegate respondsToSelector:@selector(didModifyAddress:)]) {
        [self.delegate didModifyAddress:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
