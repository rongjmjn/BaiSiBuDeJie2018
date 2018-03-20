//
//  UIImage+image.h
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/10.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)

/*返回一个没被渲染的图片*/
+ (UIImage *)imageNameWithOriginalMode:(NSString *)imageName;

- (instancetype)fr_circleImage;

+ (instancetype)fr_circleImageNamed:(NSString *)name;

/**
 *  保存图片到自定义相册
 */
- (void)fr_saveToCustomAlbumWithCompletionHandler:(void (^)(BOOL success, NSError *error))handler;

@end
