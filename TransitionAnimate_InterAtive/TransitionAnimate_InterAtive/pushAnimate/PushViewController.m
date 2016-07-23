//
//  PushViewController.m
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/12.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "PushViewController.h"
#import "PopAnimate.h"
#import "InteractiveTransition.h"
#import "PopViewController.h"
#import "Masonry.h"

@interface PushViewController ()<PushControllerDelegate>

@property (nonatomic,strong) InteractiveTransition *interativeTransition;

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"push";
    self.view.backgroundColor = [UIColor grayColor];
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [backImageView setImage:[UIImage imageNamed:@"background"]];
    [self.view addSubview:backImageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"滑动push" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(84);
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.interativeTransition setPushBlock:^{
        [weakSelf push];
    }];
    
    [self.interativeTransition addGestureForViewController:self];
}
- (InteractiveTransition *)interativeTransition{
    if (!_interativeTransition) {
        _interativeTransition = [InteractiveTransition interativeTransitionWithTransitionType:InteractiveTransitionPush GestureDirection:InteractiveTransitionGestureDirectionLeft];
    }
    return _interativeTransition;
}
- (void)push{

    PopViewController *popVc = [[PopViewController alloc] init];
    popVc.delegate = self;
    self.navigationController.delegate = popVc;
    [self.navigationController pushViewController:popVc animated:YES];
}
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush{

    return self.interativeTransition;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
