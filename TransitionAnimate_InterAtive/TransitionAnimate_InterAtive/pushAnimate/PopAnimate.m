//
//  PopAnimate.m
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/12.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "PopAnimate.h"
#import "UIView+anchorPoint.h"

@interface PopAnimate()


@end

@implementation PopAnimate

- (instancetype)initWithTransitionType:(TransitionType)type{

    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}
+ (instancetype)transitionWithType:(TransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.f;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    switch (_type) {
        case TransitionPush:
            [self pushAnimate:transitionContext];
            break;
        case TransitionPop:
            [self popAnimate:transitionContext];
            break;
        default:
            break;
    }
}
#pragma mark --push
- (void)pushAnimate:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *snapshotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = fromVC.view.frame;
    
 
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapshotView];
    fromVC.view.hidden = YES;
    [containerView insertSubview:toVC.view atIndex:0];

    
    [snapshotView setAnchorPointTo:CGPointMake(0, 0.5)];
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m34 = -0.0002;
    containerView.layer.sublayerTransform = transform3D;
    
    CAGradientLayer *fromGradLayer = [CAGradientLayer layer];
    fromGradLayer.frame = fromVC.view.bounds;
    fromGradLayer.colors = @[(id)[UIColor blackColor].CGColor,(id)[UIColor blackColor].CGColor];
    fromGradLayer.startPoint = CGPointMake(0.0, 0.5);
    fromGradLayer.endPoint   = CGPointMake(0.8, 0.5);
    
    UIView *fromShadowView = [[UIView alloc] initWithFrame:fromVC.view.bounds];
    fromShadowView.backgroundColor = [UIColor clearColor];
    fromShadowView.alpha = 0;
    [fromShadowView.layer insertSublayer:fromGradLayer atIndex:1];
    [snapshotView addSubview:fromShadowView];
    
    
    CAGradientLayer *toGradLayer = [CAGradientLayer layer];
    toGradLayer.frame = fromVC.view.bounds;
    toGradLayer.colors = @[(id)[UIColor blackColor].CGColor,(id)[UIColor blackColor].CGColor];
    fromGradLayer.startPoint = CGPointMake(0.0, 0.5);
    fromGradLayer.endPoint   = CGPointMake(0.8, 0.5);
    
    UIView *toShadowView = [[UIView alloc] initWithFrame:fromVC.view.bounds];
    toShadowView.backgroundColor = [UIColor clearColor];
    [toShadowView.layer insertSublayer:toGradLayer atIndex:1];
    toShadowView.alpha = 1.0;
    [toVC.view addSubview:toShadowView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        snapshotView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
        fromShadowView.alpha = 1.0;
        toShadowView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            [snapshotView removeFromSuperview];
            fromVC.view.hidden = NO;
        }
    }];
    
    
}
#pragma mark --pop
- (void)popAnimate:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *snapshotView = containerView.subviews.lastObject;
    [containerView addSubview:toVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        snapshotView.layer.transform = CATransform3DIdentity;
        fromVC.view.subviews.lastObject.alpha = 1.0;
        snapshotView.subviews.lastObject.alpha = 0.0;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
            [snapshotView removeFromSuperview];
            toVC.view.hidden = NO;
        }
    }];
}

@end
