//
//  PopViewController.m
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/12.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "PopViewController.h"
#import "InteractiveTransition.h"
#import "PopViewController.h"
#import "PopAnimate.h"
#import "Masonry.h"

@interface PopViewController ()

@property (nonatomic,strong) InteractiveTransition *interationPop;
@property (nonatomic,assign) UINavigationControllerOperation operation;

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"pop";
    
    self.view.backgroundColor = [UIColor grayColor];
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [backImageView setImage:[UIImage imageNamed:@"background"]];
    [self.view addSubview:backImageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"向右滑动pop" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(PopVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(84);
    }];

    __weak typeof(self) weakSelf = self;
    [self.interationPop setPresentBlock:^(){
        [weakSelf PopVC];
    }];
    
    [self.interationPop addGestureForViewController:self];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    _operation = operation;
    return [PopAnimate transitionWithType:operation == UINavigationControllerOperationPush ? TransitionPush : TransitionPop];
    
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if (_operation == UINavigationControllerOperationPush) {
        InteractiveTransition *interativePush = [_delegate interactiveTransitionForPush];
        return interativePush.isBegininteration ? interativePush : nil;
    }else{
        
        return self.interationPop.isBegininteration ? self.interationPop : nil;
    }
}
- (InteractiveTransition *)interationPop{
    if (!_interationPop) {
        _interationPop = [InteractiveTransition  interativeTransitionWithTransitionType:InteractiveTransitionPop GestureDirection:InteractiveTransitionGestureDirectionRight];
    }
    return _interationPop;
}
- (void)PopVC{

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
