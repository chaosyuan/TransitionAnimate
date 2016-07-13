//
//  NavigationInteractiveTransition.m
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/13.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "NavigationInteractiveTransition.h"
#import "PopAnimate.h"


@interface NavigationInteractiveTransition()

@property (nonatomic,weak) UINavigationController *navc;
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation NavigationInteractiveTransition

- (instancetype)initWithViewController:(UIViewController *)vc
{
    self = [super init];
    if (self) {
        _navc = (UINavigationController *)vc;
        _navc.delegate = self;
    }
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0){
    if(operation == UINavigationControllerOperationPop){
        
        return [[PopAnimate alloc] init];
    }
    return nil;
    
}
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0){
    
    if ([animationController isKindOfClass:[PopAnimate class]])
        return self.interactivePopTransition;
    
    return nil;
    
}
- (void)panGestureAction:(UIPanGestureRecognizer *)gesture{
    
    CGFloat progress = [gesture translationInView:gesture.view].x / (gesture.view.bounds.size.width * 1.0f);
    progress = MIN(1.0, MAX(0.0f, progress));
    if(gesture.state == UIGestureRecognizerStateBegan){
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navc popToRootViewControllerAnimated:YES];
    }else if(gesture.state == UIGestureRecognizerStateChanged){
        
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }else if(gesture.state == UIGestureRecognizerStateCancelled  || gesture.state == UIGestureRecognizerStateEnded){
        if (progress > 0.5f) {
            [self.interactivePopTransition finishInteractiveTransition];
        }else{
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        
        self.interactivePopTransition = nil;
    }
}


@end
