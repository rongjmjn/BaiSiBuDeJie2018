//
//  FRTopicVideoView.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/18.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRTopicVideoView.h"
#import "FRTopicItem.h"

#import "UIImageView+WebCache.h"

@interface FRTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation FRTopicVideoView

- (void)setTopicItem:(FRTopicItem *)topicItem{
    _topicItem = topicItem;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.image1]];
    
    if (topicItem.playcount >= 10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"%.1f万人播放",topicItem.playcount / 10000.0];
    }else {
        self.playCountLabel.text = [NSString stringWithFormat:@"%ld人播放",(long)topicItem.playcount];
    }
    
    
    // %02zd : 占据2位，多余的空位用0来填补
    NSInteger min = topicItem.videotime / 60;
    NSInteger sec = topicItem.videotime % 60;
    self.playTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", min,sec];
    
}

@end
