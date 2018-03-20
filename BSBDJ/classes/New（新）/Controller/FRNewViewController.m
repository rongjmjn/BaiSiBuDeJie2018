//
//  FRNewViewController.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/10.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRNewViewController.h"
#import "FRSubTagViewController.h"

@interface FRNewViewController ()

@end

@implementation FRNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航栏
    [self settingNavigationgBar];
}

/*设置导航栏*/
- (void)settingNavigationgBar{
    
    //导航栏左边图片
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highLightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(goToSubTagVC)];
    
    //导航栏标题图片
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

//监听点击
- (void)goToSubTagVC{
    FRSubTagViewController *subTagVC = [[FRSubTagViewController alloc]init];
    
    //隐藏底部bar
    //subTagVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:subTagVC animated:YES];
}


@end
