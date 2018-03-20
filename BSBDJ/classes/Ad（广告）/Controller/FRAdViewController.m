//
//  FRAdViewController.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/12.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRAdViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "FRAdItem.h"
#import <MJExtension/MJExtension.h>
#import "UIImageView+WebCache.h"
#import "FRTabBarViewController.h"


#define FRCode2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"


@interface FRAdViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *LaunchImageV;
//创建模型属性
@property (nonatomic, strong) FRAdItem *item;
/**装广告图的内容视图*/
@property (weak, nonatomic) IBOutlet UIView *adContentView;
//广告图片view: 不用每次都创建,所以使用懒加载
@property (nonatomic,weak) UIImageView *adImageV;
//跳过按钮
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@property (weak, nonatomic) NSTimer *timer;


@end

@implementation FRAdViewController
//懒加载
- (UIImageView *)adImageV{
    if (!_adImageV) {
        UIImageView *adImageV = [[UIImageView alloc]init];
        
        [_adContentView insertSubview:adImageV atIndex:1];
        
        _adImageV = adImageV;
        
        //添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [_adImageV addGestureRecognizer:tap];
        
        //允许交互
        _adImageV.userInteractionEnabled = YES;
    }
    return _adImageV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //屏幕适配:除了iPhoneX之外的
    [self setupLaunchImage];
    
    //加载数据
    [self setupAdData];
    
    //创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    

}

//监听时间改变
- (void)timeChange{
    static NSInteger i = 3;
    
    if (i == 0) {
        [self jumpClick];
        return;
    }
    
    //设置文字
    NSString *str = [NSString stringWithFormat:@"跳过 (%ld)",i];
    
    [_jumpBtn setTitle:str forState:UIControlStateNormal];
    
    i--;
}

//点击跳过按钮
- (IBAction)jumpClick {
    
    //在这里把跟控制器改为tabBarController
    FRTabBarViewController *tabBarVC = [[FRTabBarViewController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
    
    //干掉计时器
    [_timer invalidate];
}

//监听点击图片:进入广告页面
- (void)tap{
    
    NSURL *url = [NSURL URLWithString:_item.ori_curl];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

//屏幕适配
- (void)setupLaunchImage{
    //屏幕适配:除了iPhoneX之外的
    if (iPhone6P) { // 6 plus
        _LaunchImageV.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iPhone6) {
        _LaunchImageV.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iPhone5) {
        _LaunchImageV.image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    } else if (iPhone4) {
        _LaunchImageV.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
}

#pragma mark - 数据加载
//数据加载:使用第三方框架AFNetworking
- (void)setupAdData{
    //1.创建会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //以下这两段代码解决@"text/html"问题
    //mgr.responseSerializer = [AFJSONResponseSerializer new];
    
    //mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = FRCode2;

    //3.发送请求
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary  *_Nullable responseObject) {
       // NSLog(@"%@",responseObject);
        
        //[responseObject writeToFile:@"/Users/fanrongzeng/Desktop/FRAd.plist" atomically:YES];
        //3.1获取广告字典:根据plist文件可看出来是字典
        NSDictionary *adDict = [responseObject[@"ad"] firstObject];
        //3.2字典转换为数组:使用第三方框架MJExtension
        _item = [FRAdItem mj_objectWithKeyValues:adDict];
        
        //3.3设置广告图片的frame,展示图片
        //防止没有广告图片
        if (_item.h) {
            CGFloat adImageW = FRScreenW;
            CGFloat adimageH = _item.h * adImageW / _item.w;
            
            if (adimageH > FRScreenH *0.85) {
                adimageH = FRScreenH *0.85;
            }
            self.adImageV.frame = CGRectMake(0, 0, adImageW, adimageH);
            //根据图片网络地址展示图片:使用第三方框架SDWebImage
            [self.adImageV sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
