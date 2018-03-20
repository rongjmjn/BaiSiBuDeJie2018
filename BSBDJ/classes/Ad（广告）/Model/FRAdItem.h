//
//  FRAdItem.h
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/13.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRAdItem : NSObject
//广告图片
@property (nonatomic,strong) NSString *w_picurl;
//进入广告
@property (nonatomic,strong) NSString *ori_curl;
//图片宽度
@property (nonatomic,assign) CGFloat w;
//图片高度
@property (nonatomic,assign) CGFloat h;
@end
