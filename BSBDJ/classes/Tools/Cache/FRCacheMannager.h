//
//  FRCacheMannager.h
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/16.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRCacheMannager : NSObject
/**
 *  计算文件夹里文件的总大小
 */
+ (void)getCacheSizeWithDirectoryPath: (NSString *)directoryPath  completion:(void (^)(NSInteger))completionBlock;
/**
 *  删除所有的文件
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;
@end
