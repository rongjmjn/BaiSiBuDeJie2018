//
//  FRRefreshFooter.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/19.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRRefreshFooter.h"

@implementation FRRefreshFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 修改状态文字的颜色
        self.stateLabel.textColor = [UIColor yellowColor];
        
        //设置状态文字
        [self setTitle:@"上拉刷新<*!*>" forState:MJRefreshStateIdle];
        [self setTitle:@"正在加载ing" forState:MJRefreshStateRefreshing];
    }
    return self;
}

@end
