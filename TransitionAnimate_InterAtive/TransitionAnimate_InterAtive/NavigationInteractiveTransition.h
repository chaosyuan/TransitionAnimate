//
//  NavigationInteractiveTransition.h
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/13.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NavigationInteractiveTransition : NSObject<UINavigationControllerDelegate>

- (instancetype)initWithViewController:(UIViewController *)vc;
- (UIPercentDrivenInteractiveTransition *)interactivePopTransition;
- (void)panGestureAction:(UIPanGestureRecognizer *)gesture;


@end
