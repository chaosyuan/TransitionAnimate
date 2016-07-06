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
    return [self initWithAnimateType:animate_push andDuration:1.5f];
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
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containView = [transitionContext containerView];
    
    //起始位置
    CGRect originFrame = [fromVC.targetView convertRect:fromVC.targetView.bounds toView:fromVC.view];
    UIView *snapshotView = [self customSnapshoFromView:fromVC.targetView];
    snapshotView.frame   = originFrame;
    
    //结束位置
    CGRect  finishFrame = [toVC.targetView convertRect:toVC.targetView.frame toView:toVC.view];
    
    CGFloat height = CGRectGetMidY(finishFrame);
    toVC.targetHeight = height;
    
    UIView *backgrayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, k_SCREEN_WIDTH, k_SCREEN_HIGHT)];
    backgrayView.backgroundColor = [UIColor lightGrayColor];
    
    UIView *whitebackView = [[UIView alloc] initWithFrame:CGRectMake(0, height, k_SCREEN_WIDTH, k_SCREEN_HIGHT-height)];
    //    whitebackView.backgroundColor = [UIColor whiteColor];
    whitebackView.backgroundColor = [UIColor brownColor];
    
    //注意add 顺序
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    [containView addSubview:toVC.view];
    [containView addSubview:backgrayView];
    
    [backgrayView addSubview:whitebackView];
    [containView addSubview:snapshotView];
    
    
    [UIView animateWithDuration:_duration/3  animations:^{
        snapshotView.frame = finishFrame;
        snapshotView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:_duration/3  animations:^{
                snapshotView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (finished) {
                    [UIView animateWithDuration:_duration/3 animations:^{
                        snapshotView.alpha = 0.f;
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
    CGRect originFrame = [fromVC.targetView convertRect:fromVC.targetView.bounds toView:fromVC.view];
    
    UIView *snapshotView = [self customSnapshoFromView:fromVC.targetView];
    snapshotView.frame   = originFrame;
    
    CGRect finishFrame   = [toVC.targetView convertRect:toVC.targetView.bounds toView:toVC.view];
    
    UIView *backgrayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, k_SCREEN_WIDTH, k_SCREEN_HIGHT)];
    backgrayView.backgroundColor  = [UIColor lightGrayColor];
    
    UIView *backWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, fromVC.targetHeight, k_SCREEN_WIDTH, k_SCREEN_HIGHT-fromVC.targetHeight)];
    backWhiteView.backgroundColor = [UIColor whiteColor];
    
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    [containView addSubview:toVC.view];
    [containView addSubview:fromVC.view];
    [containView addSubview:backgrayView];
    [backgrayView addSubview:backWhiteView];
    [containView addSubview:snapshotView];
    
    [self addPathAnimateWithView:backgrayView fromPoint:snapshotView.center];
    
    [UIView animateWithDuration:_duration/3 delay:_duration/3 options:UIViewAnimationOptionTransitionNone animations:^{
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

    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, k_SCREEN_WIDTH, k_SCREEN_HIGHT)];
    [path appendPath:[UIBezierPath bezierPathWithArcCenter:point radius:0.1 startAngle:0 endAngle:2*M_PI clockwise:NO]];
    
    CGFloat radius = point.y > 0 ? k_SCREEN_WIDTH*3/4 : k_SCREEN_HIGHT*3/4-point.y;
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, k_SCREEN_WIDTH, k_SCREEN_HIGHT)];
    [path2 appendPath:[UIBezierPath bezierPathWithArcCenter:point radius:radius startAngle:0 endAngle:2*M_PI clockwise:NO]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    toView.layer.mask = shapeLayer;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = _type == animate_push? (__bridge id)path.CGPath:(__bridge id)path2.CGPath;
    pathAnimation.toValue   = _type == animate_push? (__bridge id)path2.CGPath:(__bridge id)path.CGPath;
    pathAnimation.duration  = _duration/3;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [shapeLayer addAnimation:pathAnimation forKey:@"pathAnimate"];
}

//产生targetView镜像
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}

@end
