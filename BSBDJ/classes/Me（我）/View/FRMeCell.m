//
//  FRMeCell.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/15.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRMeCell.h"
#import "UIImageView+WebCache.h"

@interface FRMeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImgeView;

@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation FRMeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//实现模型的setter方法,给cell赋值
- (void)setItem:(FRMeItem *)item{
    _item = item;
    
    [_iconImgeView sd_setImageWithURL:[NSURL URLWithString:item.icon] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    _name.text = item.name;
}

@end
