//
//  UIView+xib.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/14.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "UIView+xib.h"

@implementation UIView (xib)
+ (instancetype)viewFromNib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}
@end
