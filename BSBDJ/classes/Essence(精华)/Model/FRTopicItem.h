//
//  FRTopicItem.h
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/17.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import <Foundation/Foundation.h>

//枚举
typedef NS_ENUM(NSInteger,FRTopicType) {
    /** 全部 */
    FRTopicTypeAll = 1,
    /** 图片 */
    FRTopicTypePicture = 10,
    /** 段子 */
    FRTopicTypeWord = 29,
    /** 声音 */
    FRTopicTypeVoice = 31,
    /** 视频 */
    FRTopicTypeVideo = 41
};

@interface FRTopicItem : NSObject
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 小图 */
@property (nonatomic, copy) NSString *image0;
/** 中图 */
@property (nonatomic, copy) NSString *image2;
/** 大图 */
@property (nonatomic, copy) NSString *image1;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;
/** 是否为动态图 */
@property (nonatomic, assign) BOOL is_gif;
/** 最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;
/**帖子类型*/
@property (assign, nonatomic) FRTopicType type;
/******************额外增加的属性,便于开发*******************/
/**cell的高度*/
@property (assign, nonatomic) CGFloat cellHeight;
/**middleView的frame*/
@property (assign, nonatomic) CGRect middleFrame;
/**是否是长图*/
@property (assign, nonatomic, getter = isBigPicture) BOOL bigPicture;
@end
