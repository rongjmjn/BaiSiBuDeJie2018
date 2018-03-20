//
//  FRTabBarViewController.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/10.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRTabBarViewController.h"
#import "FRMeViewController.h"
#import "FRNewViewController.h"
#import "FRPulishViewController.h"
#import "FREssenceViewController.h"
#import "FRFriendTrendViewController.h"
#import "UIImage+image.h"
#import "FRTabBar.h"
#import "FRNavigationController.h"

@interface FRTabBarViewController ()

@end

@implementation FRTabBarViewController

/*******************************************/
//统一设置tabBar上按钮被选中文字不需要被渲染

//load方法在类加载内存时会调用,只调用一次
+ (void)load{
    //1.获取当前类下所有UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    //2.富文本属性设置:字体,颜色,阴影,空心,图文混排
    //文字Selected状态的颜色
    NSMutableDictionary *attrSel = [NSMutableDictionary dictionary];
    attrSel[NSForegroundColorAttributeName] = [UIColor blackColor];//黑色
    [item setTitleTextAttributes:attrSel forState:UIControlStateSelected];
    
    //tabBar按钮字体大小,由正常状态决定
    NSMutableDictionary *attrNor = [NSMutableDictionary dictionary];
    attrNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrNor forState:UIControlStateNormal];
    
}
/*******************************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.添加子控件
    [self addChildViewControllers];
    
    //2.设置按钮的内容
    [self setAllButtonOfTabBar];
    
    //3.自定义tabBar
    [self setupTabBar];
    
    
}

/*自定义tabBar*/
- (void)setupTabBar{
    
    FRTabBar *tabBar = [[FRTabBar alloc]init];
    
    [self setValue:tabBar forKey:@"tabBar"];//kvc
    
}

/*所有的的子控件*/
- (void)addChildViewControllers
{
    //精华
    FREssenceViewController *essenceVC = [[FREssenceViewController alloc]init];
    essenceVC.view.backgroundColor = [UIColor redColor];
    FRNavigationController *nav = [[FRNavigationController alloc]initWithRootViewController:essenceVC];
    [self addChildViewController:nav];
    
    //新帖
    FRNewViewController *newVC = [[FRNewViewController alloc]init];
    newVC.view.backgroundColor  = [UIColor orangeColor];
    FRNavigationController *nav1 = [[FRNavigationController alloc]initWithRootViewController:newVC];
    [self addChildViewController:nav1];

    //关注
    FRFriendTrendViewController *friendTrendVC = [[FRFriendTrendViewController alloc]init];
    //friendTrendVC.view.backgroundColor = [UIColor greenColor];
    FRNavigationController *nav2 = [[FRNavigationController alloc]initWithRootViewController:friendTrendVC];
    [self addChildViewController:nav2];
    
    //我:根据箭头指向的storyboard创建控制器
    FRMeViewController *meVC = [[UIStoryboard storyboardWithName:NSStringFromClass([FRMeViewController class]) bundle:nil] instantiateInitialViewController];
    //meVC.view.backgroundColor = [UIColor grayColor];
    FRNavigationController *nav3 = [[FRNavigationController alloc]initWithRootViewController:meVC];
    [self addChildViewController:nav3];
}

/*设置所有按钮的内容*/
- (void)setAllButtonOfTabBar
{
    //精华
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精华";
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav.tabBarItem.selectedImage = [UIImage imageNameWithOriginalMode:@"tabBar_essence_click_icon"];
    
    //新帖
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageNameWithOriginalMode:@"tabBar_new_click_icon"];

    //关注
    UINavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"关注";
    nav2.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav2.tabBarItem.selectedImage = [UIImage imageNameWithOriginalMode:@"tabBar_friendTrends_click_icon"];
    
    //我
    UINavigationController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"我";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageNameWithOriginalMode:@"tabBar_me_click_icon"];
    
}

@end
