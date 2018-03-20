//
//  FREssenceViewController.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/10.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FREssenceViewController.h"
#import "FRTitleButton.h"

#import "FRAllViewController.h"
#import "FRTVideoViewController.h"
#import "FRVoiceViewController.h"
#import "FRPictureViewController.h"
#import "FRWordViewController.h"

@interface FREssenceViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) UIView *titleView;

@property (weak, nonatomic) UIView *underline;
/**用来显示所有控制器view的scrollView*/
@property (weak, nonatomic) UIScrollView *scrollView;
/**当前被点击的按钮*/
@property (weak, nonatomic) FRTitleButton *clickedTitleBtn;
@end

@implementation FREssenceViewController
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航栏
    [self settingNavigationgBar];
    
    //添加自控制器
    [self addChildViewControllers];
    
    //添加scrollView
    [self setupScrollView];
    
    //标题栏
    [self setupTitleView];
    
    //默认显示第一个view
    [self addChildVcViewIntoScrollView];
}

/**添加子控制器*/
- (void)addChildViewControllers{
    
    [self addChildViewController:[[FRAllViewController alloc]init]];
    [self addChildViewController:[[FRTVideoViewController alloc]init]];
    [self addChildViewController:[[FRVoiceViewController alloc]init]];
    [self addChildViewController:[[FRPictureViewController alloc]init]];
    [self addChildViewController:[[FRWordViewController alloc]init]];
}

/**
 *  把自控制器的view添加到scrollView上
 */
- (void)setupScrollView{
    self.automaticallyAdjustsScrollViewInsets = NO;//不要自动调节scrollView的内边距
    
    //创建scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    
    scrollView.frame = self.view.bounds;
    
    scrollView.pagingEnabled = YES;
    
    scrollView.backgroundColor = [UIColor purpleColor];
    
    scrollView.bounces = NO;
    
    scrollView.delegate = self;
    
    self.scrollView = scrollView;
    
    [self.view addSubview:scrollView];

    
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.width, 0);
}


/*设置导航栏*/
- (void)settingNavigationgBar{
    //设置导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highLightImage:[UIImage imageNamed:@"nav_item_game_iconN"] target:self action:@selector(game)];
    
    //设置导航栏的标题图片
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏右边的图片
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highLightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
}
/**标题栏*/
- (void)setupTitleView{
    UIView *titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(0, 64, self.view.width, 35);
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    
    //标题栏按钮
    [self setupTitleButton];
    
    //下划线
    [self setupUnderLine];
}
/**标题栏按钮*/
- (void)setupTitleButton{
    NSArray *titles = @[@"全hhh部", @"视q频",@"声hhhh音",  @"图rr片", @"段子"];
    
    //没有必要放到for循环里面
    CGFloat btnW = self.titleView.width / titles.count;
    CGFloat btnH = self.titleView.height;
    CGFloat y = 0;
    for (int i = 0; i < titles.count; i ++) {
        
        UIButton *button = [[FRTitleButton alloc]init];
        
        //绑定tag
        button.tag = i;
        
        CGFloat x = i * btnW;
        
        button.frame = CGRectMake(x, y, btnW, btnH);
 
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.titleView addSubview:button];
    }
}

/**下划线*/
- (void)setupUnderLine{
    //取出第一个标题按钮
    FRTitleButton *fistBtn = self.titleView.subviews[0];
    
    //创建下划线
    UIView *underline = [[UIView alloc]init];
    
    CGFloat underlineH = 2;
    
    underline.frame = CGRectMake(0, self.titleView.height - underlineH, fistBtn.width, underlineH);
    underline.backgroundColor = [fistBtn titleColorForState:UIControlStateSelected];
    
    [self.titleView addSubview:underline];
    
    
    [fistBtn.titleLabel sizeToFit];
    
    underline.width = fistBtn.titleLabel.width + 10;
    underline.centerX = fistBtn.centerX;
    
    //设置第一个标题按钮
    fistBtn.selected = YES;
    self.clickedTitleBtn = fistBtn;
    
    self.underline = underline;
}
//监听后调用的方法
- (void)game{
    FRFunc;
}
#pragma mark - 监听点击
/**监听标题按钮点击*/
- (void)titleBtnClick: (FRTitleButton *)button{
    
    //监听标题按钮重复点击
    if (self.clickedTitleBtn == button) {
        [[NSNotificationCenter defaultCenter] postNotificationName:FRTitleButtonDidRepeatClickNotification object:nil];
    }
    
    self.clickedTitleBtn.selected = NO;
    button.selected = YES;
    self.clickedTitleBtn = button;
    
    //下划线设置
    NSInteger index = button.tag;
    [UIView animateWithDuration:0.25 animations:^{
        self.underline.width = button.titleLabel.width + 10;
        self.underline.centerX = button.centerX;
        
        //scrollView联动
        self.scrollView.contentOffset = CGPointMake(index * self.scrollView.width, 0);

    }completion:^(BOOL finished) {
        
        [self addChildVcViewIntoScrollView];
    }];
    
    // 处理scrollView的属性scrollsToTop
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVC = self.childViewControllers[i];
        
        if (!childVC.isViewLoaded) return;
        
        UIView *childView = childVC.view;
        
        if ([childView isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)childView;
            scrollView.scrollsToTop = (i == index);
        }
        
    }
    
}

#pragma mark - 添加子控制器的view到scrollView上

- (void)addChildVcViewIntoScrollView{
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.width;
    UIViewController *VC = self.childViewControllers[index];
    [self.scrollView addSubview:VC.view];
    
    VC.view.x = index * self.scrollView.width;
    VC.view.y = 0;
    VC.view.height = self.scrollView.height;
}

#pragma mark - scrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //点击对应的按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    FRTitleButton *titleBtn = self.titleView.subviews[index];
    [self titleBtnClick:titleBtn];
}

@end
