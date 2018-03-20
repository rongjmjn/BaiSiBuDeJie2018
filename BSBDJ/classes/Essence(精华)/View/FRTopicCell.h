//
//  FRTopicCell.h
//  BSBDJ
//
//  Created by FanrongZeng on 2018/3/18.
//  Copyright © 2018年 FanrongZeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FRTopicItem;

@interface FRTopicCell : UITableViewCell

/**帖子模型*/
@property (nonatomic, strong) FRTopicItem *item;

@end
