//
//  presentAnimate.h
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/12.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger,TransitionType) {
    TransitionTypePresent = 0,
    TransitionTypeDismiss
};

@interface presentAnimate : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTransitionType:(TransitionType)type;
+ (instancetype)transitionWithTransitionType:(TransitionType)type;


@end
