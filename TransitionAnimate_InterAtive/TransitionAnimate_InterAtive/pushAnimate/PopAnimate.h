//
//  PopAnimate.h
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/12.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,TransitionType) {
    TransitionPush = 0,
    TransitionPop
};

@interface PopAnimate : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign)TransitionType type;

- (instancetype)initWithTransitionType:(TransitionType)type;
+ (instancetype)transitionWithType:(TransitionType)type;

@end
