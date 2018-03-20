//
//  FRTitleButton.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/16.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRTitleButton.h"

@implementation FRTitleButton

//重写指定构造方法,给控件设置属性
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

/**重写此方法,去除高亮状态的所有操作*/
-(void)setHighlighted:(BOOL)highlighted {
    
}

@end
