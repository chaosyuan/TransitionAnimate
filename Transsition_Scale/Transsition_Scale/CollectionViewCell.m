//
//  CollectionViewCell.m
//  Transsition_Scale
//
//  Created by yuanwei on 16/7/4.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _pictureImage  =   [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,150, 150)];
        [self.contentView addSubview:_pictureImage];
        
        _scaleLable  = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, 150, 28)];
        _scaleLable.font  = [UIFont systemFontOfSize:16.0f];
        _scaleLable.textAlignment  = NSTextAlignmentCenter;
        [self.contentView addSubview:_scaleLable];
        
    }
    return self;
}

@end
