//
//  TrainsitionAnimate.h
//  Transition_Form
//
//  Created by yuanwei on 16/7/5.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,Animate_Type){
    animate_push = 0,
    animate_pop  = 1,
};

@interface TrainsitionAnimate : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithAnimateType:(Animate_Type)type andDuration:(CGFloat)duration;

@property (nonatomic,assign) CGFloat duration;
@property (nonatomic,assign) Animate_Type type;

@end
