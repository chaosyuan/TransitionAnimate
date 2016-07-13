//
//  ModalTransitionDelegate.m
//  TransitionAnimate_modal
//
//  Created by yuanwei on 16/7/8.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "ModalTransitionDelegate.h"
#import "TransitionAnimate_modal.h"

@implementation ModalTransitionDelegate


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{

        return [[TransitionAnimate_modal alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
     return [[TransitionAnimate_modal alloc] init];
}

@end
