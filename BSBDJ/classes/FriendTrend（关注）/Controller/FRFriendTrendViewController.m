//
//  FRFriendTrendViewController.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/10.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRFriendTrendViewController.h"
#import "FRLoginViewController.h"

@interface FRFriendTrendViewController ()

@end

@implementation FRFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self settingNavigationgBar];
}
//点击登录注册按钮
- (IBAction)clickLoginRegister {
    
    FRLoginViewController *lrVC = [[FRLoginViewController alloc]init];
    
    [self presentViewController:lrVC animated:YES completion:nil];
    
}

/*设置导航栏*/
- (void)settingNavigationgBar{
    //导航栏左边的图片
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highLightImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:nil action:nil];
    
    //导航栏标题
    self.navigationItem.title = @"我的关注";
}

@end
