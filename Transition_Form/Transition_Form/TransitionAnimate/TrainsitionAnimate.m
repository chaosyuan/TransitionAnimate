//
//  TrainsitionAnimate.m
//  Transition_Form
//
//  Created by yuanwei on 16/7/5.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "TrainsitionAnimate.h"
#import "UIViewController+TrainsitionExtension.h"

#define k_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define k_SCREEN_HIGHT  [UIScreen mainScreen].bounds.size.height

@implementation TrainsitionAnimate

- (instancetype)init{
    return [self initWithAnimateType:animate_push andDuration:0.5f];
}

- (instancetype)initWithAnimateType:(Animate_Type)type andDuration:(CGFloat)duration{
    if (self = [super init]) {
        _type = type;
        _duration = duration;
    }
    return self;
}
#pragma mark --UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{

    return _duration;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    self.type == animate_push ? [self pushAnimateWithAnimateTransition:transitionContext] : [self popAnimateWithAnimateTransition:transitionContext];
}

- (void)pushAnimateWithAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    ////获取参与转场的视图控制器
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    ///获取转场发生的容器
    UIView *containView = [transitionContext containerView];
    
    //起始位置
    CGRect originFrame = [fromVC.targetView convertRect:fromVC.targetView.bounds toView:fromVC.view];
    //产生视图镜像
    UIView *snapshotView = [fromVC.targetView snapshotViewAfterScreenUpdates: NO];
    snapshotView.frame   = originFrame;
    
    //结束位置
    CGRect  finishFrame = [toVC.targetView convertRect:toVC.targetView.bounds toView:toVC.view];
    
    CGFloat height = CGRectGetMidY(finishFrame);
    toVC.targetHeight = height;
    
    UIView *backgrayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, k_SCREEN_WIDTH, k_SCREEN_HIGHT)];
    backgrayView.backgroundColor = [UIColor lightGrayColor];
    
    UIView *whitebackView = [[UIView alloc] initWithFrame:CGRectMake(0, height, k_SCREEN_HIGHT, k_SCREEN_HIGHT-height)];
    whitebackView.backgroundColor = [UIColor whiteColor];

    //使用initialFrameForViewController 和 finalFrameForViewController 获取过渡开始和结束时每个ViewController的frame
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    //注意add 顺序
    [containView addSubview:toVC.view];
    [containView addSubview:backgrayView];
    
    [backgrayView addSubview:whitebackView];
    [containView  addSubview:snapshotView];
    
    
    [UIView animateWithDuration:_duration  animations:^{
        snapshotView.frame = finishFrame;
        snapshotView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:_duration  animations:^{
                snapshotView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (finished) {
                    [UIView animateWithDuration:_duration animations:^{
                        snapshotView.alpha = 0.0f;
                    } completion:^(BOOL finished) {
                        if(finished){
                            [backgrayView removeFromSuperview];
                            [snapshotView removeFromSuperview];
                            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                        }
                    }];
                    [self addPathAnimateWithView:backgrayView fromPoint:snapshotView.center];
                }
            }];
        }
    }];
}
- (void)popAnimateWithAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containView = [transitionContext containerView];
    CGRect originFrame  = [fromVC.targetView convertRect:fromVC.targetView.bounds toView:fromVC.view];
    
    UIView *snapshotView = [fromVC.targetView snapshotViewAfterScreenUpdates: NO];
    snapshotView.frame   = originFrame;
    
    CGRect finishFrame   = [toVC.targetView convertRect:toVC.targetView.bounds toView:toVC.view];
    UIView *backgrayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, k_SCREEN_WIDTH, k_SCREEN_HIGHT)];
    backgrayView.backgroundColor  = [UIColor lightGrayColor];
    
    UIView *backWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, fromVC.targetHeight, k_SCREEN_WIDTH, k_SCREEN_HIGHT-fromVC.targetHeight)];
    backWhiteView.backgroundColor = [UIColor whiteColor];
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    [containView  addSubview:toVC.view];
    [containView  addSubview:fromVC.view];
    [containView  addSubview:backgrayView];
    [backgrayView addSubview:backWhiteView];
    [containView  addSubview:snapshotView];
    
    [self addPathAnimateWithView:backgrayView fromPoint:snapshotView.center];
    
    [UIView animateWithDuration:_duration delay:_duration options:UIViewAnimationOptionTransitionNone animations:^{
        snapshotView.frame = finishFrame;
        snapshotView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    } completion:^(BOOL finished) {
        if (finished) {
            [fromVC.view removeFromSuperview];
            
            [UIView animateWithDuration:_duration animations:^{
                backgrayView.alpha = 0.f;
                snapshotView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [backgrayView removeFromSuperview];
                [snapshotView removeFromSuperview];
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
        }
    }];
}

#pragma mark -- 收合动画(CAShapeLayer + UIBezierPath)
- (void)addPathAnimateWithView:(UIView *)toView fromPoint:(CGPoint)point{

    UIBezierPath *path1 = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, k_SCREEN_WIDTH, k_SCREEN_HIGHT)];
    [path1 appendPath:[UIBezierPath bezierPathWithArcCenter:point radius:0.1 startAngle:0 endAngle:2 * M_PI clockwise:NO]];
    
    CGFloat radius = point.y > 0 ? k_SCREEN_WIDTH * 3/4 : k_SCREEN_HIGHT * 3 / 4 - point.y;
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, k_SCREEN_WIDTH, k_SCREEN_HIGHT)];
    [path2 appendPath:[UIBezierPath bezierPathWithArcCenter:point radius:radius startAngle:0 endAngle:2 * M_PI clockwise:NO]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    toView.layer.mask = shapeLayer;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue   = _type == animate_push ? (__bridge id)path1.CGPath:(__bridge id)path2.CGPath;
    pathAnimation.toValue     = _type == animate_push ? (__bridge id)path2.CGPath:(__bridge id)path1.CGPath;
    pathAnimation.duration    = _duration;
    pathAnimation.repeatCount = 1;
    pathAnimation.fillMode            = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [shapeLayer addAnimation:pathAnimation forKey:@"pathAnimate"];
}

@end
