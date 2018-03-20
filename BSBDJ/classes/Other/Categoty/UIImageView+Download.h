//
//  UIImageView+Download.h
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/19.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Download)
- (void)fr_setLargeImageUrl:(NSString *)largeImageUrl smallImageUrl:(NSString *)smallImageUrl placholder:(UIImage *)placholder;

- (void)fr_setHeader:(NSString *)url;
@end
