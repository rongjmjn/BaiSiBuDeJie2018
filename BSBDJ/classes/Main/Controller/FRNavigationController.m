//
//  FRNavigationController.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/11.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRNavigationController.h"

@interface FRNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation FRNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置返回按钮,把系统的返回按钮覆盖,滑动返回功能就没有了
    // 恢复滑动返回功能 => 为什么滑动返回功能没有? 1.有个手势在处理,可能把手势清空 ×
    // 2.手势代理做了事情,导致手势失效,从而滑动返回功能没有
    //self.interactivePopGestureRecognizer.delegate = self;
    //设置这个代理之后app会现假死:是因为在根控制器使用滑动返回,而根控制器不需要滑动返回
    
    //要实现全屏滑动返回,自己搞一个手势代替系统的滑动返回
    //禁止系统手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
    id target = self.interactivePopGestureRecognizer.delegate;
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    [self.view addGestureRecognizer:pan];
    
    //设置代理,处理假死状态
    pan.delegate = self;
}



//加载类的时候只调用一次
+ (void)load{
    
    //用appearance获取导航条
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    //用富文本属性设置
    NSMutableDictionary *attrDic = [NSMutableDictionary dictionary];
    attrDic[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [navBar setTitleTextAttributes:attrDic];
    
    //导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

//重写这个系统方法,统一设置返回键
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //非根控制器才要返回,过滤掉跟控制器
    if(self.childViewControllers.count > 0){
    viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highLightImage:[UIImage imageNamed:@"navigationButtonReturnClick"] title:@"返回" target:self action:@selector(back)];
        
        //统一设置隐藏底部bar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //这样才是真正执行push
    [super pushViewController:viewController animated:YES];
}
//监听点击
- (void)back{
    [self popViewControllerAnimated:YES];
}

#pragma mark - 防止滑动返回假死,实现UIGestureRecognizerDelegate代理方法
//是否触发手势: 只有非根控制器才需要滑动返回功能
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count > 1;
}

@end
