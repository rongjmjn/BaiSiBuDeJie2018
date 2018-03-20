//
//  FRRefreshHeader2.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/19.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRRefreshHeader2.h"

@implementation FRRefreshHeader2


/**重写构造方法*/
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        // 自动切换透明度
        self.automaticallyChangeAlpha = YES;
        
        //隐藏时间
        self.lastUpdatedTimeLabel.hidden = YES;
        
        //修改状态文字颜色
        self.stateLabel.textColor = [UIColor redColor];
        
    }
    return self;
}

@end
