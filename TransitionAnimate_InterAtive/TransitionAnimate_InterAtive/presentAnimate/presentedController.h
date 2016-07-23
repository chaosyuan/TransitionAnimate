//
//  presentedController.h
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/12.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PresentedControllerDelegate <NSObject>

- (void)presentedControllerPressedDissmiss;
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent;

@end

@interface presentedController : UIViewController

@property (nonatomic,weak) id<PresentedControllerDelegate> delegate;

@end
