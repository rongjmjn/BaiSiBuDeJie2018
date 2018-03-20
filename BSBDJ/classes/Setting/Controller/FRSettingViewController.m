//
//  FRSettingViewController.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/11.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRSettingViewController.h"
#import "FRCacheMannager.h"
#import "SDImageCache.h"
#import <SVProgressHUD/SVProgressHUD.h>

/**文件夹路径*/
#define FRCachePath (NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0])

@interface FRSettingViewController ()
@property (nonatomic,assign) NSInteger totalSize;
@end

@implementation FRSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"设置";
    
    [SVProgressHUD showWithStatus:@"计算缓存..."];
    
    //获取文件大小
    [FRCacheMannager getCacheSizeWithDirectoryPath:FRCachePath completion:^(NSInteger totalSize) {
        
        [SVProgressHUD dismiss];
        
        _totalSize = totalSize;
        
        //等数据计算好后刷新表格
        [self.tableView reloadData];
        
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
 

    cell.textLabel.text = [self cacheString];
    
    return cell;
}
/******************清除缓存*******************/
/**拼接缓存字符串*/
- (NSString *)cacheString{
    
    NSString *cacheStr = @"清除缓存";
    
    if (_totalSize > 1000 * 1000) {
        cacheStr = [NSString stringWithFormat:@"%@(%.1fMB)",cacheStr,(CGFloat)_totalSize /(1000*1000)];
    }else if (_totalSize > 1000){
        cacheStr = [NSString stringWithFormat:@"%@(%.1fKB)",cacheStr,(CGFloat)_totalSize /1000];
    }else if (_totalSize > 0) {
        cacheStr = [NSString stringWithFormat:@"%@(%ldlB)",cacheStr,(long)_totalSize];
    }
    
    return [cacheStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
}

#pragma mark - tableView代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [FRCacheMannager removeDirectoryPath:FRCachePath];
    
    _totalSize = 0;
    
    [self.tableView reloadData];
}
@end
