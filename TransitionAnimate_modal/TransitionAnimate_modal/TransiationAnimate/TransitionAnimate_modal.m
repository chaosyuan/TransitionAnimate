//
//  TransitionAnimate_modal.m
//  TransitionAnimate_modal
//
//  Created by yuanwei on 16/7/8.
//  Copyright © 2016年 YuanWei. All rights reserved.
//



#import "TransitionAnimate_modal.h"

@implementation TransitionAnimate_modal

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{

    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = fromVC.view;
    UIView *toView   = toVC.view;
    
    //ios8 可以使用这个方法 获取FromVC.view
    // UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    // UIView *toView   = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    if(toVC.isBeingPresented){
    
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        toView.transform = CGAffineTransformMakeTranslation(0, screenHeight);
        [containerView addSubview:toView];
        
        CGFloat toViewWidth  = containerView.bounds.size.width * 2 / 3;
        CGFloat toViewHeight = containerView.bounds.size.height * 2 / 3;
        toView.center = containerView.center;
        toView.bounds = CGRectMake(0, 0, 1, toViewHeight);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            toView.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);
            toView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
           
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    if (fromVC.isBeingDismissed) {
        
        CGAffineTransform destTransfrom = CGAffineTransformMakeTranslation(0, [UIScreen mainScreen].bounds.size.height);
        
         CGFloat fromViewHeight = fromView.frame.size.height;
        
        //[containerView insertSubview:toView belowSubview:fromView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
           
            fromView.bounds = CGRectMake(0, 0, 1, fromViewHeight);
            fromView.transform = destTransfrom;
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}


@end
