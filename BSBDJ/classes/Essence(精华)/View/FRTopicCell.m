//
//  FRTopicCell.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/18.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRTopicCell.h"
#import "FRTopicItem.h"
#import "UIImageView+WebCache.h"

#import "FRTopicPictureView.h"
#import "FRTopicVoiceView.h"
#import "FRTopicVideoView.h"

#import "UIImageView+Download.h"

@interface FRTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;

/******************中间的view*******************/
/**picture*/
@property (weak,nonatomic) FRTopicPictureView *pictureV;
/**video*/
@property (weak,nonatomic) FRTopicVideoView *videoV;
/**voice*/
@property (weak,nonatomic) FRTopicVoiceView *voiceV;
@end

@implementation FRTopicCell

#pragma mark - 懒加载控件
/**pictureV*/
- (FRTopicPictureView *)pictureV{
    if (!_pictureV) {
        _pictureV = [FRTopicPictureView viewFromNib];
        [self addSubview:_pictureV];
    }
    return _pictureV;
}
/**video*/
- (FRTopicVideoView *)videoV{
    if (!_videoV) {
        _videoV = [FRTopicVideoView viewFromNib];
        [self addSubview:_videoV];
    }
    return _videoV;
}
/**voice*/
- (FRTopicVoiceView *)voiceV{
    if (!_voiceV) {
        _voiceV = [FRTopicVoiceView viewFromNib];
        [self addSubview:_voiceV];
    }
    return _voiceV;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
}

//重写模型setter方法,给cell赋值
- (void)setItem:(FRTopicItem *)item{
    _item = item;
    
    [self.profileImageView fr_setHeader:item.profile_image];//处理用户头像
    
    self.nameLabel.text = item.name;
    self.passtimeLabel.text = item.passtime;
    self.text_label.text = item.text;
    
    //中间view
    if (item.type == FRTopicTypePicture){
        self.videoV.hidden = YES;
        self.voiceV.hidden = YES;
        self.pictureV.hidden = NO;
        self.pictureV.topicItem = item;
    }else if (item.type == FRTopicTypeVideo){
        self.videoV.hidden = NO;
        self.voiceV.hidden = YES;
        self.pictureV.hidden = YES;
        self.videoV.topicItem = item;
    }else if (item.type == FRTopicTypeVoice){
        self.videoV.hidden = YES;
        self.voiceV.hidden = NO;
        self.pictureV.hidden = YES;
        self.voiceV.topicItem = item;
    }else if(item.type == FRTopicTypeWord){
        self.videoV.hidden = YES;
        self.voiceV.hidden = YES;
        self.pictureV.hidden = YES;
    }
    
    
    //最热评论
    if (item.top_cmt.count){
        self.topCmtView.hidden = NO;
        NSDictionary *dict = item.top_cmt.firstObject;
        NSString *content = dict[@"content"];
        if(content.length == 0){
            content = @"语音评论";
        }
        NSString *userName = dict[@"user"][@"username"];
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@ : %@",userName, content];
    }else{
        self.topCmtView.hidden = YES;
    }
    
    // 设置底部工具条按钮文字
    [self setupButton:self.dingButton number:item.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:item.cai placeholder:@"踩"];
    [self setupButton:self.repostButton number:item.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:item.comment placeholder:@"评论"];
}

/**
 *  设置按钮的数字 (placeholder是一个中文参数, 故意留到最后, 前面的参数就可以使用点语法等智能提示)
 */
- (void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

//处理cell的分割线
- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

#pragma mark - 布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.item.type == FRTopicTypePicture) {
        self.pictureV.frame = self.item.middleFrame ;
    }else if (self.item.type ==FRTopicTypeVideo) {
        self.videoV.frame = self.item.middleFrame ;
    }else if (self.item.type == FRTopicTypeVoice) {
        self.voiceV.frame = self.item.middleFrame;
    }
}

@end
