//
//  FRFastLoginBtn.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/14.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRFastLoginBtn.h"

@implementation FRFastLoginBtn

//布局子控件,重写此方法
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.y = 0;
    self.imageView.centerX = self.width / 2;
    
    [self.titleLabel sizeToFit];
    
    self.titleLabel.y = self.height - self.titleLabel.height;
    self.titleLabel.centerX = self.width / 2;
}

@end
