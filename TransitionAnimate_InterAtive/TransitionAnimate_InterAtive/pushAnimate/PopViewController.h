//
//  PopViewController.h
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/12.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PushControllerDelegate <NSObject>

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush;

@end

@interface PopViewController : UIViewController<UINavigationControllerDelegate>

@property (nonatomic,weak) id <PushControllerDelegate> delegate;

@end
