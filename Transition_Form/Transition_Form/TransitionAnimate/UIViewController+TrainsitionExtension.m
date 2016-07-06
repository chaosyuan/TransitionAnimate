//
//  UIViewController+TrainsitionExtension.m
//  Transition_Form
//
//  Created by yuanwei on 16/7/5.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "UIViewController+TrainsitionExtension.h"
#import <objc/runtime.h>

@implementation UIViewController (TrainsitionExtension)

@dynamic targetHeight;
@dynamic targetView;

- (void)setTargetHeight:(CGFloat)targetHeight{
    objc_setAssociatedObject(self, @selector(targetHeight), @(targetHeight), OBJC_ASSOCIATION_RETAIN);
}

- (CGFloat)targetHeight{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
- (void)setTargetView:(UIView *)targetView{
    objc_setAssociatedObject(self, @selector(targetView),targetView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)targetView{
    return objc_getAssociatedObject(self, _cmd);
}

@end
