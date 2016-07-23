//
//  InteractiveTransition.h
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/12.
//  Copyright © 2016年 YuanWei. All rights reserved.
//


//继承自UIPercentDrivenInteractiveTransition    交互控制器


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,InteractiveTransitionGestureDirection) {

    InteractiveTransitionGestureDirectionLeft = 0,
    InteractiveTransitionGestureDirectionRight,
    InteractiveTransitionGestureDirectionUp,
    InteractiveTransitionGestureDirectionDown
};
typedef NS_ENUM(NSUInteger,InteractiveTransitionType) {
    InteractiveTransitionPresent = 0,
    InteractiveTransitionDismiss,
    InteractiveTransitionPush,
    InteractiveTransitionPop
  
};

typedef void (^GestureBlock)();

@interface InteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic,copy) GestureBlock presentBlock;
@property (nonatomic,copy) GestureBlock pushBlock;
@property (nonatomic,assign) BOOL isBegininteration;

+ (instancetype)interativeTransitionWithTransitionType:(InteractiveTransitionType)type GestureDirection:(InteractiveTransitionGestureDirection)direction;
- (instancetype)initWithTransitionType:(InteractiveTransitionType)type GestureDirection:(InteractiveTransitionGestureDirection)direction;
- (void)addGestureForViewController:(UIViewController *)viewcontroller;

@end
