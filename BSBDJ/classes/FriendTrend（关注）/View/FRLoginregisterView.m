//
//  FRLoginregisterView.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/14.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRLoginregisterView.h"

@interface FRLoginregisterView ()
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterBtn;

@end

@implementation FRLoginregisterView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    UIImage *image = _loginRegisterBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    // 设置登录按钮背景图片
    [_loginRegisterBtn setBackgroundImage:image forState:UIControlStateNormal];
}

+ (instancetype)loginView{
    return [[NSBundle mainBundle] loadNibNamed:@"FRLoginregisterView" owner:nil options:nil][0];
}

+ (instancetype)registerView{
    return [[NSBundle mainBundle] loadNibNamed:@"FRLoginregisterView" owner:nil options:nil][1];
}

@end
