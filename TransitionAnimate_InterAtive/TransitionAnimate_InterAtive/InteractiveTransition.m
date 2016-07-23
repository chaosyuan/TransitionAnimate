//
//  InteractiveTransition.m
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/12.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "InteractiveTransition.h"


@interface InteractiveTransition()

@property (nonatomic,assign) InteractiveTransitionGestureDirection direction;
@property (nonatomic,assign) InteractiveTransitionType type;

@property (nonatomic,weak) UIViewController *vc;

@end

@implementation InteractiveTransition

+ (instancetype)interativeTransitionWithTransitionType:(InteractiveTransitionType)type GestureDirection:(InteractiveTransitionGestureDirection)direction{

    return  [[self alloc] initWithTransitionType:type GestureDirection:direction];
}
- (instancetype)initWithTransitionType:(InteractiveTransitionType)type GestureDirection:(InteractiveTransitionGestureDirection)direction{

    self = [super init];
    if (self) {
         _type = type;
        _direction = direction;
    }
    return self;
}
- (void)addGestureForViewController:(UIViewController *)viewcontroller{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    self.vc = viewcontroller;
    [viewcontroller.view addGestureRecognizer:pan];
}
// 手势过渡过程
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{

    CGFloat persent = 0;
    switch (_direction) {
        case InteractiveTransitionGestureDirectionLeft:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case InteractiveTransitionGestureDirectionRight:{
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case InteractiveTransitionGestureDirectionUp:{
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
        case InteractiveTransitionGestureDirectionDown:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
    }
    
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.isBegininteration = true;
            [self startGesture];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            [self updateInteractiveTransition:persent];
              break;
        }
          
        case UIGestureRecognizerStateEnded:{
            self.isBegininteration = false;
            if (persent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
        }
            break;
        default:
            
            break;
    }
}
- (void)startGesture{
    switch (_type) {
            
        case InteractiveTransitionPresent:{
            if (_presentBlock) {
                self.presentBlock();
            }
        }
              break;
        case InteractiveTransitionDismiss:
            [_vc dismissViewControllerAnimated:YES completion:nil];
            break;
            
        case InteractiveTransitionPush:{
            if (_pushBlock) {
                _pushBlock();
            }
        }
            break;
        case InteractiveTransitionPop:
            [_vc.navigationController popViewControllerAnimated:YES];
            break;
    }
}
@end
