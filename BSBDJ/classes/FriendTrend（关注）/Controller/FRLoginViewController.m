//
//  FRLoginViewController.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/14.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRLoginViewController.h"
#import "FRLoginregisterView.h"
#import "UIView+xib.h"
#import "FRFastLoginView.h"

@interface FRLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCons;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation FRLoginViewController


- (IBAction)clickRegisterBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    //平移
   _leftCons.constant = _leftCons.constant == 0 ? -FRScreenW : 0;
    
    //动画
    [UIView animateWithDuration:0.5 animations:^{
        
        //更新约束
        [self.view layoutIfNeeded];
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //登录
    FRLoginregisterView *loginView = [FRLoginregisterView loginView];
    [self.middleView addSubview:loginView];
    //注册
    FRLoginregisterView *registerView = [FRLoginregisterView registerView];
    registerView.x = _middleView.width * 0.5;
    [self.middleView addSubview:registerView];
    
    //快速登录
    FRFastLoginView *fastView = [FRFastLoginView viewFromNib];
    [self.bottomView addSubview:fastView];
}
- (IBAction)clickBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*****************加载xib控件,最好固定一下尺寸*******************/

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    //登录xib设置frame
    UIView *loginV= self.middleView.subviews[0];
    loginV.frame = CGRectMake(0, 0, self.middleView.width/2, self.middleView.height);
    
    //注册xib设置fame
    UIView *registerV = self.middleView.subviews[1];
    registerV.frame = CGRectMake(FRScreenW, 0, self.middleView.width/2, self.middleView.height);
    
    //快速登录
    UIView *fastV = self.bottomView.subviews[0];
    fastV.frame = self.bottomView.bounds;
}

@end
