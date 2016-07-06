//
//  TranstioneScaleAnimate.h
//  Transsition_Scale
//
//  Created by yuanwei on 16/7/1.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,Animate_Type){
     animate_push = 0,
     animate_pop  = 1,
};

@interface TranstioneScaleAnimate : NSObject  <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithAnimateType:(Animate_Type)type andDuration:(CGFloat)dura;

@property (nonatomic,assign) Animate_Type type;
@property (nonatomic,assign) CGFloat duration;

@end
