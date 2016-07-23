//
//  presentedController.m
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/12.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "presentedController.h"
#import "PresentingController.h"
#import "InteractiveTransition.h"
#import "presentAnimate.h"
#import "Masonry.h"

@interface presentedController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) InteractiveTransition *interativeDissmiss;

@end

@implementation presentedController


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
  
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"滑动dismiss" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(150);
    }];
    self.interativeDissmiss = [InteractiveTransition interativeTransitionWithTransitionType:InteractiveTransitionDismiss GestureDirection:InteractiveTransitionGestureDirectionDown];
    [self.interativeDissmiss addGestureForViewController:self];
}

- (void)dismiss{
    if (self.delegate && [self.delegate respondsToSelector:@selector(presentedControllerPressedDissmiss)]) {
        [_delegate presentedControllerPressedDissmiss];
    }
};




- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [presentAnimate transitionWithTransitionType:TransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [presentAnimate transitionWithTransitionType:TransitionTypeDismiss];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interativeDissmiss.isBegininteration ? _interativeDissmiss : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    InteractiveTransition *transition = [_delegate interactiveTransitionForPresent];
    return transition.isBegininteration ? transition : nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
