//
//  FRMeViewController.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/10.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRMeViewController.h"
#import "FRSettingViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "FRWebViewController.h"
#import <SafariServices/SafariServices.h>

#import "FRMeCell.h"
#import "FRMeItem.h"
static NSString * const cellID = @"cell";
static NSInteger cols = 4;//列数
static CGFloat margin = 1;//间距

@interface FRMeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collView;
@property (nonatomic,assign) CGFloat cellWH;
/**模型数组*/
@property (strong, nonatomic) NSMutableArray *MeItems;

@end

@implementation FRMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self settingNavigationgBar];
    
    //方块视图
    [self setupFooterView];
    
    //加载数据
    [self loadData];
    
    //去掉右边滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    // 顶部间距:cellY
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //FRLOG(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset));
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    FRLOG(@"%@",NSStringFromCGRect(cell.frame));
    
}
/*设置导航栏*/
- (void)settingNavigationgBar{
    //标题
    self.navigationItem.title = @"我的";
    
    //右边
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highLightImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    UIBarButtonItem *item2 = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(moon:)];
    
    self.navigationItem.rightBarButtonItems = @[item1, item2];

}

#pragma mark - 监听点击方法

/*点击setting按钮*/
- (void)setting{
    FRSettingViewController *settingVC = [[FRSettingViewController alloc]init];
    
    [self.navigationController pushViewController:settingVC animated:YES];
    
}

//夜间模式转换
- (void)moon: (UIButton *)button{
    button.selected = !button.selected;
}



#pragma mark - collectionView方块设置
/**
 *  设置方块视图
 */
- (void)setupFooterView {
    
    //创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    //CGFloat margin = 1;//间距
    //CGFloat cols = 4;//列数
    CGFloat cellWH = (FRScreenW -(cols - 1) * margin) / cols;//cell的尺寸
    _cellWH = cellWH;
    
    //设置布局
    layout.itemSize = CGSizeMake(cellWH, cellWH);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    
    //collectionView
    self.collView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    
    _collView.backgroundColor = self.tableView.backgroundColor;
    
    //注册cell
    [_collView registerNib:[UINib nibWithNibName:NSStringFromClass([FRMeCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];
    
    //数据源
    _collView.dataSource = self;
    _collView.delegate = self;
    
    //设置footerView
    self.tableView.tableFooterView = _collView;
}

/**补全最后一行的cell*/
- (void)resvolveData{
    NSInteger extre =  _MeItems.count % cols;
    if (extre){
        extre = cols - extre;
        for (int i = 0; i < extre; i++) {
            FRMeItem *item = [[FRMeItem alloc]init];
            [self.MeItems addObject:item];
        }
    }
    
}
#pragma mark - 加载数据
/**加载网络数据*/
- (void)loadData{
    //1.创建会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    //3.发送请求
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary  *_Nullable responseObject) {
        //FRLOG(@"%@",responseObject);
        //[responseObject writeToFile:@"/Users/fanrongzeng/Desktop/me.plist" atomically:YES];
        
        //字典数组转模型数组
        _MeItems = [FRMeItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        //设置collectionView的高度
        //NSInteger extre =  _MeItems.count % cols;
        //NSInteger rows = _MeItems.count / cols;
        /*if (!extre){
            _collView.height = (self.cellWH + margin) * rows - margin;
        }else{
            _collView.height = (self.cellWH + margin) * rows + self.cellWH;
        }*/
        
        //补全最后一行的cell
        [self resvolveData];
        //rows的公式
        NSInteger rows = (_MeItems.count - 1) /cols + 1;//行数
        _collView.height = rows * self.cellWH;
        
        //重新设定tableView的底部视图
        self.tableView.tableFooterView = _collView;
        
        //刷新表格
        [self.collView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FRLOG(@"%@",error);
        
    }];
    
}

#pragma mark - collection数据源方法和代理方法
/******************数据源方法*******************/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.MeItems.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //从缓存池中取
    FRMeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    //设置数据
    cell.item = self.MeItems[indexPath.row];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //取出对应的模型
    FRMeItem *item = self.MeItems[indexPath.row];
    
    //NSURL *url = [NSURL URLWithString:self.meItem.url];
    //if ([[UIApplication sharedApplication] canOpenURL:url]){
    //    [[UIApplication sharedApplication] openURL:url];
    //     }
    
    /*if (![self.meItem.url hasPrefix:@"http"]) return;
    
    SFSafariViewController *safariVC  = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:self.meItem.url ]];
    
    [self presentViewController:safariVC animated:YES completion:nil];*/
    
    //webView
    FRWebViewController *webVC = [[FRWebViewController alloc]init];
    FRLOG(@"%@",item.url);
    webVC.url = [NSURL URLWithString:item.url];
    
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
