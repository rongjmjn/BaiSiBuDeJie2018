//
//  FRLogRegField.m
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/14.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import "FRLogRegField.h"

@implementation FRLogRegField

-(void)awakeFromNib{
    [super awakeFromNib];
    
    //光标颜色
    self.tintColor = [UIColor whiteColor];
    
    //监听编辑
    [self addTarget:self action:@selector(editeBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(editeEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    //占位文字的颜色
    //方法一
   /* NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attrDict];*/
    
    //方法二  runtime
    UILabel *placeholderlabel = [self valueForKeyPath:@"placeholderLabel"];
    placeholderlabel.textColor = [UIColor lightGrayColor];

}

#pragma mark - 监听编辑

/**开始编辑*/
- (void)editeBegin{
    /*NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attrDict];*/
    //方法二  runtime
    UILabel *placeholderlabel = [self valueForKeyPath:@"placeholderLabel"];
    placeholderlabel.textColor = [UIColor whiteColor];

}

/**结束编辑*/
- (void)editeEnd{
    /*NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attrDict];*/
    //方法二  runtime
    UILabel *placeholderlabel = [self valueForKeyPath:@"placeholderLabel"];
    placeholderlabel.textColor = [UIColor lightGrayColor];

}
@end
