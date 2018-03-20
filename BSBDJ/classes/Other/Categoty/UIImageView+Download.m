//
//  UIImageView+Download.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/19.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "UIImageView+Download.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "UIImage+image.h"

@implementation UIImageView (Download)
- (void)fr_setLargeImageUrl:(NSString *)largeImageUrl smallImageUrl:(NSString *)smallImageUrl placholder:(UIImage *)placholder
{
    [self sd_setImageWithURL:[NSURL URLWithString:largeImageUrl] placeholderImage:placholder];
    
    /*
     // 这段代码只对真机有效
     // 首先检测缓存中是否有原图（大图）
     UIImage *largeImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:largeImageUrl];
     if (largeImage) {
     self.image = largeImage;
     } else {
     AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
     if (mgr.isReachableViaWiFi) { // WIFI
     [self sd_setImageWithURL:[NSURL URLWithString:largeImageUrl] placeholderImage:placholder];
     } else if (mgr.isReachableViaWWAN) { // 手机自带网络
     [self sd_setImageWithURL:[NSURL URLWithString:smallImageUrl] placeholderImage:placholder];
     } else { // 没有网络
     self.image = placholder; // 或者显示占位图片
     }
     }*/
}

- (void)fr_setHeader:(NSString *)url
{
    // UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] fr_circleImage];
    // self.image = [UIImage circleImageWithImage:image];
    
    UIImage *placeholder = [UIImage fr_circleImageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        self.image = [image fr_circleImage];
    }];
    //    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
