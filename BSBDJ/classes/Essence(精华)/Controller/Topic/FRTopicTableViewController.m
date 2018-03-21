//
//  FRTopicTableViewController.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/19.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRTopicTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "UIImageView+WebCache.h"
#import "FRTopicCell.h"

#import <SVProgressHUD/SVProgressHUD.h>

#import "FRRefreshHeader.h"
#import "FRRefreshHeader2.h"
#import "FRRefreshFooter.h"

static NSString * const ID = @"FRTopicCellID";

@interface FRTopicTableViewController ()
/**会话管理者*/
@property (nonatomic, strong) AFHTTPSessionManager *mgr;
/**加载到最后一个帖子的信息记录*/
@property (nonatomic,copy) NSString *maxtime;
/**模型数组*/
@property (strong,nonatomic) NSMutableArray *topicsItem;

/** 写这个声明只是为了点语法 */
- (NSString *)listType;

@end

@implementation FRTopicTableViewController
/** 判断是精华页面还是新帖页面 */
- (NSString *)listType{
    
    if ([@"FREssenceViewController" isEqualToString:NSStringFromClass(self.parentViewController.class)]) return @"list";
        
    if ([@"FRNewViewController" isEqualToString:NSStringFromClass(self.parentViewController.class)]) return @"newlist";
    
    return nil;
}

/**实现这个方法是仅仅是要消除警告*/
- (FRTopicType)type {return 0;}

/**懒加载会话管理者*/
- (AFHTTPSessionManager *)mgr{
    if (!_mgr) {
        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
        _mgr = mgr;
    }
    return _mgr;
}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
 
    //  解决iOS11 刷新控件的问题
    if (@available (iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    }
    
    self.tableView.backgroundColor  = FRColor(215, 215, 215);
    
    self.tableView.contentInset = UIEdgeInsetsMake(FRNavBarMaxY + FRTitlesViewH, 0, FRTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //估算一个靠谱的高度
    self.tableView.estimatedRowHeight = 160;
    
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarBtnOnClick) name:FRTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleBtnRepeatClick) name:FRTitleButtonDidRepeatClickNotification object:nil];

    
    //初始化refresh控件
    [self setupRefresh];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FRTopicCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
}
/**类释放时,移除通知*/
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听点击
/**标题栏按钮重复点击*/
- (void)titleBtnRepeatClick{
    [self tabBarBtnOnClick];
}
/**tabBar按钮重复点击*/
- (void)tabBarBtnOnClick{
    // 如果当前控制器的view不在window上面，就直接返回
    if (self.tableView.window == nil) return;
    
    // 如果当前控制器的view没有跟window重叠
    if (self.tableView.scrollsToTop == NO) return;
    
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - 加载网络数据
/**新数据加载*/
- (void)loadNewData{
    
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.listType;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    
    //发送请求
    [self.mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary  *_Nullable responseObject) {
        
        //记录最后一个帖子信息
        _maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组转模型数组
        NSArray *list = responseObject[@"list"];//字典数组
        _topicsItem = [FRTopicItem mj_objectArrayWithKeyValuesArray:list];
        
        //刷新数据
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FRLOG(@"%@",error);
        
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

/**加载更多数据*/
- (void)loadMoreData{
    //拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.listType;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    
    //发送请求
    [self.mgr GET:FRBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //记录maxtime
        _maxtime = responseObject[@"info"][@"maxtime"];
        
        //模型数组
        NSArray *moreTopics = [FRTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //添加模型
        [self.topicsItem addObjectsFromArray:moreTopics];
        
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FRLOG(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - TableView数据源和代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topicsItem.count == 0);
    return self.topicsItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FRTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //取出对应模型
    FRTopicItem *topicItem = self.topicsItem[indexPath.row];
    
    [topicItem cellHeight]; //每次给cell赋值的时候,先计算cell的高度,避免一些问题
    
    cell.item = topicItem;
    
    return cell;
}
/**返回cell的高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取出对应的模型
    FRTopicItem *item = _topicsItem[indexPath.row];
    
    return item.cellHeight;;
}
/**cell被选中就会调用*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FRTopicCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - scrollView代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //清除图片缓存
    [[SDImageCache sharedImageCache] clearMemory];
    
}

#pragma mark - refresh控件
- (void)setupRefresh{
    //下拉刷新控件
    self.tableView.mj_header = [FRRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //下拉刷新
    [self.tableView.mj_header beginRefreshing];
    
    //上拉刷新
    self.tableView.mj_footer = [FRRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
@end












