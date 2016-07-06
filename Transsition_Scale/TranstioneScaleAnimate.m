//
//  TranstioneScaleAnimate.m
//  Transsition_Scale
//
//  Created by yuanwei on 16/7/1.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "TranstioneScaleAnimate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "CollectionViewCell.h"

@implementation TranstioneScaleAnimate


- (instancetype)init{
    return [self initWithAnimateType:animate_push andDuration:0.35f];
}

- (instancetype)initWithAnimateType:(Animate_Type)type andDuration:(CGFloat)dura
{
    if (self = [super init]) {
        _type = type;
        _duration = dura;
    }
    return self;
}
#pragma mark -- UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return _duration;
}
- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext{
    if (self.type == animate_push) {
        [self pushAnimateWithanimateTransition:transitionContext];
    }else{
        [self popAnimateWithanimateTransition:transitionContext];
    }
}

#pragma mark -- push
- (void)pushAnimateWithanimateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
{
    //获取参与转场的视图控制器
    FirstViewController *fromVC = (FirstViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondViewController *toVC   = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //获取转场发生的容器
    UIView *containerView    = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    CollectionViewCell *cell = (CollectionViewCell *)[fromVC.collectionView cellForItemAtIndexPath:[[fromVC.collectionView indexPathsForSelectedItems] firstObject]];
    
    //生成视图镜像
    UIView *cellImageSnapshot = [cell.pictureImage snapshotViewAfterScreenUpdates:NO];
    cellImageSnapshot.frame   = [containerView convertRect:cell.pictureImage.frame fromView:cell.pictureImage.superview];
    cell.pictureImage.hidden  = YES;
    
    //获取转场结束时 Controller 的Frame
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0.f;
    toVC.imageView.hidden   = YES;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:cellImageSnapshot];
    
    [UIView animateWithDuration:duration animations:^{
        toVC.view.alpha  = 1.0f;
        cellImageSnapshot.frame = [containerView convertRect:toVC.imageView.frame fromView:toVC.view];
    } completion:^(BOOL finished) {
        
        toVC.imageView.hidden = NO;
        cell.hidden = NO;
        [cellImageSnapshot removeFromSuperview];
        //转场完成
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}
#pragma mark -- pop
- (void)popAnimateWithanimateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
{
    SecondViewController *fromVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    FirstViewController  *toVC   = (FirstViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView *imageSnapshot = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    imageSnapshot.frame = [containerView convertRect:fromVC.imageView.frame fromView:fromVC.imageView.superview];
    fromVC.imageView.hidden = YES;
    
    CollectionViewCell *cell = (CollectionViewCell *)[toVC collectionViewForCell];
    cell.pictureImage.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.backgroundColor  = [UIColor whiteColor];
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:imageSnapshot];
    
    [UIView animateWithDuration:duration animations:^{

        toVC.view.alpha = 1.0f;
        imageSnapshot.frame = [containerView convertRect:cell.pictureImage.frame fromView:cell.pictureImage.superview];
        
    } completion:^(BOOL finished) {
        
        [imageSnapshot removeFromSuperview];
        fromVC.imageView.hidden  = NO;
        cell.pictureImage.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];

}

@end
