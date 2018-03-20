//
//  FRSubTagViewController.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/13.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRSubTagViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "FRSubTagItem.h"
#import "FRSubTagCell.h"
#import <SVProgressHUD/SVProgressHUD.h>

static NSString * const cellID = @"cellid";
@interface FRSubTagViewController ()
//模型数组
@property (nonatomic, strong) NSArray *subtags;

//模型
@property (nonatomic, strong) FRSubTagItem *subTagItem;

@end

@implementation FRSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [SVProgressHUD showWithStatus:@"加载数据ing"];

    //标题
    self.navigationItem.title = @"订阅标签";
    
    //1.加载数据
    [self loadData];
    
    //注册cell:从nib
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FRSubTagCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    
    
    FRLOG(@"%@",NSStringFromUIEdgeInsets(self.tableView.layoutMargins));
    // iOS8取消分割线内边距
    //self.tableView.separatorInset = UIEdgeInsetsZero;
    
    //通用的方法
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = FRColor(184, 184, 184);

}

#pragma mark - 数据加载
- (void) loadData{
    //1.创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] =@"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] =@"topic";
    
    //3.发送请求
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray  *_Nullable responseObject) {
        //FRLOG(@"%@",responseObject);
        
        //字典数组转为模型数组
        _subtags = [FRSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        
        //刷新数据:一定要记得
        [self.tableView reloadData];
        
        [SVProgressHUD  dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FRLOG(@"%@",error);
        
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - Table view data source
//有所少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _subtags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*********注册cell************/
    //先去缓存池取
    FRSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    //geicell赋值
    FRSubTagItem *item = self.subtags[indexPath.row];

    cell.item = item;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

//点击选中cell时调用这个方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //根据index取出当前cell
    FRSubTagCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //取消选中
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
@end
