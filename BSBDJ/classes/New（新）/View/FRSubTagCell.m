//
//  FRSubTagCell.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/13.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRSubTagCell.h"
#import "UIImageView+WebCache.h"

@interface FRSubTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *munView;


@end

@implementation FRSubTagCell

//在模型属性的setter方法中给控制赋值
- (void)setItem:(FRSubTagItem *)item{
    _item = item;
    
    [_iconImageV sd_setImageWithURL:[NSURL URLWithString:_item.image_list ] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        // 加载成功就会调用
        // 只要想生成新的图片 => 图形上下文
        // 1.开启图形上下文
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        // 2.描述裁剪区域
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        
        // 3.设置裁剪区域
        [clipPath addClip];
        
        // 4.画图片
        [image drawAtPoint:CGPointZero];
        
        // 5.从上下文取出图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        // 抗锯齿
        _iconImageV.image = image;
        
        // 6.关闭上下文
        UIGraphicsEndImageContext();
    }];
    
    _nameView.text = _item.theme_name;
    
    _munView.text = [NSString stringWithFormat:@"%@人阅读",_item.sub_number];
    NSInteger num = [_item.sub_number integerValue];
    CGFloat numF = 0;
    if (num > 10000) {
        numF = num / 10000.0;
        _munView.text = [NSString stringWithFormat:@"%.1f万人阅读",numF];
    }
    
    //图片的圆角处理
    //_iconImageV.layer.cornerRadius = 25;
    //裁剪
    //_iconImageV.layer.masksToBounds = YES;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //iOS7取消分割线不到边的设置
    //self.layoutMargins = UIEdgeInsetsZero;
    
}

-(void)setFrame:(CGRect)frame{
    
    frame.size.height -= 1;
    
    //真正设置frame
    [super setFrame:frame];
}

@end
