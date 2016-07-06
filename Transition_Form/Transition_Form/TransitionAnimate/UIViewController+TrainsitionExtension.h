//
//  UIViewController+TrainsitionExtension.h
//  Transition_Form
//
//  Created by yuanwei on 16/7/5.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TrainsitionExtension)

@property (nonatomic,assign) CGFloat  targetHeight;
@property (nonatomic,weak)   UIView  *targetView;

@end
