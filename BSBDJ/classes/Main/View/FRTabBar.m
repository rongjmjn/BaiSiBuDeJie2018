//
//  FRTabBar.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/11.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRTabBar.h"

@interface FRTabBar ()

//发布按钮
@property (nonatomic ,weak) UIButton *pulishBtn;

/**记录上一次被点击按钮的tag*/
@property (assign, nonatomic) NSInteger didClickTabBarBtnTag;

@end

@implementation FRTabBar

//懒加载发布按钮
-(UIButton *)pulishBtn{
    if (!_pulishBtn) {
        UIButton *pulishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [pulishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [pulishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        
        [pulishBtn sizeToFit];
        
        _pulishBtn = pulishBtn;
        
        [self addSubview:_pulishBtn];
    }
    return _pulishBtn;
}



//布局子控件的frame,必须重写此方法
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSInteger count = self.items.count + 1;
    
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    
    NSInteger i = 0;
    
    for (UIControl *tabBarBtn in self.subviews) {
        if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i += 1;
            }
            tabBarBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
            
            tabBarBtn.tag = i;
            
            i ++;
            
            
            //添加tabBar点击监听
            [tabBarBtn addTarget:self action:@selector(tabBarBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    self.pulishBtn.center = CGPointMake(self.width * 0.5, self.height * 0.53);
}

#pragma mark - 监听tabBar按钮点击
- (void)tabBarBtnOnClick:(UIControl *)tabBarBtn{
    if(self.didClickTabBarBtnTag == tabBarBtn.tag){
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:FRTabBarButtonDidRepeatClickNotification object:nil];
    }
    
    self.didClickTabBarBtnTag = tabBarBtn.tag;
}

@end
