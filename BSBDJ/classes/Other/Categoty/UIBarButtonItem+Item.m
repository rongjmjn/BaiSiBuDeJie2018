//
//  UIBarButtonItem+Item.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/11.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+ (UIBarButtonItem *)itemWithImage: (UIImage *)image highLightImage: (UIImage *)highImage  target: (id)target action: (SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //包装到view
    UIView *view = [[UIView alloc]initWithFrame:button.bounds];
    
    [view addSubview:button];
    
    return [[UIBarButtonItem alloc]initWithCustomView:view];
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selImage forState:UIControlStateSelected];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 包装到UIView
    UIView *contentView = [[UIView alloc] initWithFrame:button.bounds];
    [contentView addSubview:button];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
    
}

+ (UIBarButtonItem *)backItemWithImage: (UIImage *)image highLightImage: (UIImage *)highImage title: (NSString *)title target: (id)target action: (SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highImage forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [button sizeToFit];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
    
}

@end
