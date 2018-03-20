//
//  FRTopicVoiceView.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/18.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRTopicVoiceView.h"
#import "FRTopicItem.h"

#import "UIImageView+WebCache.h"

@interface FRTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;

@end

@implementation FRTopicVoiceView

- (void)setTopicItem:(FRTopicItem *)topicItem{
    _topicItem = topicItem;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.image1]];
    
    if (topicItem.playcount >= 10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"%.1f万人播放", topicItem.playcount / 10000.0];
    }else{
        self.playCountLabel.text   = [NSString stringWithFormat:@"%zd人播放",topicItem.playcount];
    }
    
    NSInteger min = topicItem.voicetime / 60;
    NSInteger sec = topicItem.voicetime % 60;
    self.playTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",min,sec];
    
}

@end
