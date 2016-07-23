//
//  UIView+anchorPoint.m
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/12.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "UIView+anchorPoint.h"

@implementation UIView (anchorPoint)

- (void)setAnchorPointTo:(CGPoint)point{
    self.frame = CGRectOffset(self.frame, (point.x - self.layer.anchorPoint.x) * self.frame.size.width, (point.y - self.layer.anchorPoint.y) * self.frame.size.height);
    self.layer.anchorPoint = point;
}

@end
