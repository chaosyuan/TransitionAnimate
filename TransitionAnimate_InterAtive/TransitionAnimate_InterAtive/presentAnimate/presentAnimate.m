//
//  presentAnimate.m
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/12.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "presentAnimate.h"

@interface presentAnimate()

@property (nonatomic,assign) TransitionType type;

@end

@implementation presentAnimate

- (instancetype)initWithTransitionType:(TransitionType)type{
    
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}
+ (instancetype)transitionWithTransitionType:(TransitionType)type{
    
    return [[self alloc] initWithTransitionType:type];
    
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
 return _type == TransitionTypePresent ? 0.5 : 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    switch (_type) {
        case TransitionTypePresent:
            [self presentAnimate:transitionContext];
            break;
            
        case TransitionTypeDismiss:
            [self dismissAnimate:transitionContext];
            break;
    }
}

- (void)presentAnimate:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //fromVc是presetingViewController     presentedViewController是toVc
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *snapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = fromVC.view.frame;
    fromVC.view.hidden = YES;
    
    [containerView addSubview:snapshotView];
    [containerView addSubview:toVC.view];
  
    
    toVC.view.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, 400);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0/0.55 options:0 animations:^{
        
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
        snapshotView.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

        if ([transitionContext transitionWasCancelled]) {
            fromVC.view.hidden = false;
            [snapshotView removeFromSuperview];
        }
    }];
    
}

- (void)dismissAnimate:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //presentedViewController是fromVc toVc是presetingViewController
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    // 转场容器的最后一个子视图就是 presetingViewController.view截图视图
    NSArray *subViewsArray = containerView.subviews;
    
    UIView *tempView = subViewsArray[MIN(subViewsArray.count, MAX(0, subViewsArray.count - 2))];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^(){
        
        fromVC.view.transform = CGAffineTransformIdentity;
        tempView.transform    = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        if ([transitionContext transitionWasCancelled]) {
           
            [transitionContext completeTransition:false];
        }else{
            [transitionContext completeTransition:true];
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
    
}

@end
