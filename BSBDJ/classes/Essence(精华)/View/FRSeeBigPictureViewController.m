//
//  FRSeeBigPictureViewController.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/19.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRSeeBigPictureViewController.h"
#import "FRTopicItem.h"
#import "UIImageView+WebCache.h"
#import "UIImage+image.h"

#import <SVProgressHUD/SVProgressHUD.h>

@interface FRSeeBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation FRSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化图片容器
    [self setupPictureView];
}


#pragma mark - 初始化图片容器
- (void)setupPictureView{
    //创建scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.bounces = NO;//去掉弹簧功能
    scrollView.userInteractionEnabled = YES;
    
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)]];
    
    [self.view insertSubview:scrollView atIndex:0];
    
    //创建imageView
    UIImageView *imageView = [[UIImageView alloc]init];
    
    /******************imageView的frame*******************/
    CGFloat imageViewW = FRScreenW;
    CGFloat imageViewH = imageViewW * self.topicItem.height / self.topicItem.width;
    CGFloat x = 0;
    CGFloat y = 0;
    if (imageViewH < FRScreenH) {
        y = (FRScreenH - imageViewH) / 2;
    }
    imageView.frame = CGRectMake(x, y, imageViewW, imageViewH);
    /******************imageView的frame*******************/
    
    scrollView.contentSize = CGSizeMake(imageViewW, imageViewH);
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topicItem.image1] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (image == nil) return;
        
        self.saveButton.enabled = YES;
    }];
    
    [scrollView addSubview:imageView];
    
    self.imageView = imageView;
    
    //缩放功能
    CGFloat maxScale = self.topicItem.width / imageViewW;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
    
    
}

#pragma mark - 监听点击
- (IBAction)save {
    
   [self.imageView.image fr_saveToCustomAlbumWithCompletionHandler:^(BOOL success, NSError *error) {
       
       if (success) {
           [SVProgressHUD showSuccessWithStatus:@"图片保存成功"];
       }else{
           
           [SVProgressHUD showErrorWithStatus:@"图片保存失败"];
           
       FRLOG(@"%@",error);
       }
       
   }];
    
}



- (IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - scrollView代理方法
/**允许imageView缩放*/
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}
@end













