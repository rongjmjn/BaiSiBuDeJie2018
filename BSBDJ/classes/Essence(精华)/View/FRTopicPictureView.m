//
//  FRTopicPictureView.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/18.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRTopicPictureView.h"
#import "FRTopicItem.h"
#import "FRSeeBigPictureViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+Download.h"

@interface FRTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *gifImgeView;
@property (weak, nonatomic) IBOutlet UIImageView *imgeView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPicBtn;

@end

@implementation FRTopicPictureView

- (void)awakeFromNib{
    [super awakeFromNib];
   
    self.imgeView.userInteractionEnabled = YES;//允许图片view交互
    //给图片view添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seeBigPicture)];
    [self.imgeView addGestureRecognizer:tap];
}

-(void)setTopicItem:(FRTopicItem *)topicItem{
    _topicItem = topicItem;
    
    //[self.imgeView sd_setImageWithURL:[NSURL URLWithString:topicItem.image2]];
    [self.imgeView fr_setLargeImageUrl:topicItem.image1 smallImageUrl:topicItem.image0 placholder:nil];
    
    self.gifImgeView.hidden = !topicItem.is_gif;
    
    if (topicItem.isBigPicture){
        self.seeBigPicBtn.hidden = NO;
        [self.seeBigPicBtn addTarget:self action:@selector(seeBigPicture) forControlEvents:UIControlEventTouchUpInside];
        self.imgeView.contentMode = UIViewContentModeTop;
        self.imgeView.clipsToBounds = YES;
    }else if (!topicItem.isBigPicture){
        self.seeBigPicBtn.hidden = YES;
        self.imgeView.contentMode = UIViewContentModeScaleToFill;
        self.imgeView.clipsToBounds = NO;
    }
}

#pragma mark - 监听按钮点击
- (void)seeBigPicture{
    FRSeeBigPictureViewController *seeBigPicVC = [[FRSeeBigPictureViewController alloc]init];
    
    //传递模型
    seeBigPicVC.topicItem = self.topicItem;
    
    //获取根控制器
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    //[rootVC.navigationController pushViewController:seeBigPicVC animated:YES];  无效
    [rootVC presentViewController:seeBigPicVC animated:YES completion:nil];
}

@end
