//
//  FRTopicItem.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/17.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRTopicItem.h"

@implementation FRTopicItem

//实现cellHeight的getter方法,计算cell的高度
- (CGFloat)cellHeight{
    //避免重复计算
    if (_cellHeight) return _cellHeight;
    
    /******************计算cell的高度*******************/
    
    //头像
    _cellHeight += 55;
    
    //文字
    CGFloat textMaxW = FRScreenW - 2 *FRMargin;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height + FRMargin;
    
    /**中间view*/
    if (self.type != FRTopicTypeWord) {
        CGFloat middleVW = textMaxW;
        CGFloat middleVH = middleVW * self.height / self.width;
        //判断是否为长图
        if (middleVH >= FRScreenH){
            middleVH = 200;
            self.bigPicture = YES;
        }
        
        //中间view的frame
        self.middleFrame = CGRectMake(FRMargin, _cellHeight, middleVW, middleVH);
        
        _cellHeight += middleVH + FRMargin;
    }
    
    //最热评论
    if (self.top_cmt.count) {
        
        _cellHeight += 18;
        
        NSDictionary *dict = self.top_cmt.firstObject;
        NSString *content = dict[@"content"];
        if(content.length == 0){
            content = @"语音评论";
        }
        NSString *userName = dict[@"user"][@"username"];
        content = [NSString stringWithFormat:@"%@ : %@",userName, content];
        
        _cellHeight += [content boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size.height + FRMargin;
    }
    
    //工具条
    _cellHeight += 35 + FRMargin;
    
    /******************计算cell的高度*******************/
    return _cellHeight;
    
    
}

@end
