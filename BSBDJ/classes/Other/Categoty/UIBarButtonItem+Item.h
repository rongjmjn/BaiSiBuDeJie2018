//
//  UIBarButtonItem+Item.h
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/11.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)
/*highlight*/
+ (UIBarButtonItem *)itemWithImage: (UIImage *)image highLightImage: (UIImage *)highImage  target: (id)target action: (SEL)action;
/*seleted*/
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;
/*highlightAndTittle*/
+ (UIBarButtonItem *)backItemWithImage: (UIImage *)image highLightImage: (UIImage *)highImage title: (NSString *)title target: (id)target action: (SEL)action;

@end
