//
//  FRCacheMannager.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/16.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRCacheMannager.h"

@implementation FRCacheMannager
+ (void)getCacheSizeWithDirectoryPath: (NSString *)directoryPath  completion:(void (^)(NSInteger))completionBlock{
    
    //为了防止文件太多太复杂,计算时间会很长,造成app卡顿,使用开始异步任务,使用block
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        //1.创建文件管理者
        NSFileManager *manager = [NSFileManager defaultManager];
        
        // 判断下当前文件是否存在,是否是文件夹
        BOOL isDirectory;
        BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
        
        if (!isExist || !isDirectory) {
            NSException *excp =  [NSException exceptionWithName:@"fileError" reason:@"传入文件不存在,或者不是文件夹,给我传文件夹过来,ok?" userInfo:nil];
            [excp raise];
        }

        
        //2.获取某文件夹中所有的文件(指定一个文件夹路径,就能获取这个文件夹中所有子路径)
        NSArray *subPaths = [manager subpathsAtPath:directoryPath];
        
        NSInteger totalSize = 0;
        
        //3.遍历文件夹中所有的子路径:获取所有文件尺寸大小
        for (NSString *subPath in subPaths) {
            //拼接全路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            
            //排除隐藏文件
            if ([filePath containsString:@".DS"]) continue;
            //排除文件夹和无效路径
            BOOL isDirectory;
            BOOL isExist = [manager fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExist || isDirectory) continue;
            
            //获取路径的信息(attributesOfItemAtPath:只能获取文件尺寸,不能获取文件夹尺寸)
            NSDictionary *dict = [manager attributesOfItemAtPath:filePath error:nil];
            
            //获取文件大小
            totalSize += [dict fileSize];
        }
        
        //调用block一定要回到主线程里面
        dispatch_sync(dispatch_get_main_queue(), ^{
            completionBlock(totalSize);
        });
        
    });

}

+ (void)removeDirectoryPath:(NSString *)directoryPath{
    //1.创建文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    
    // 判断下当前文件是否存在,是否是文件夹
    BOOL isDirectory;
    BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        NSException *excp =  [NSException exceptionWithName:@"fileError" reason:@"传入文件不存在,或者不是文件夹,给我传文件夹过来,ok?" userInfo:nil];
        [excp raise];
    }
    
    //获取文件夹中所有的文件
    NSArray *contentPaths = [manager contentsOfDirectoryAtPath:directoryPath error:nil];
    
    for (NSString *contentPath in contentPaths) {
        //拼接全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:contentPath];
        
        //删除文件
        [manager removeItemAtPath:filePath error:nil];
    }

}

@end
