//
//  FRRefreshHeader.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/19.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRRefreshHeader.h"

@interface FRRefreshHeader ()
/**logo*/
@property (weak, nonatomic) UIImageView *logo;
@end

@implementation FRRefreshHeader

/**重写构造方法*/
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        // 自动切换透明度
        self.automaticallyChangeAlpha = YES;
        
        //隐藏时间
        self.lastUpdatedTimeLabel.hidden = YES;
        
        //修改状态文字颜色
        self.stateLabel.textColor = [UIColor redColor];
        
        //设置状态文字
        [self setTitle:@"下拉刷新<*!*>" forState:MJRefreshStateIdle];
        [self setTitle:@"正在加载ing" forState:MJRefreshStateRefreshing];
        [self setTitle:@"松松手,马上可以刷新>..<" forState:MJRefreshStatePulling];
        
        //设置logo
        UIImageView *logo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
        [self addSubview:logo];
        self.logo = logo;
    }
    return self;
}

/**布局子控件*/
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //self.logo.center = CGPointMake(self.width * 0.5, 0);
    self.logo.centerX = self.width * 0.5;
    self.logo.y = -self.logo.height;
}

@end
