//
//  PresentingController.m
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/12.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "PresentingController.h"
#import "presentAnimate.h"
#import "InteractiveTransition.h"
#import "presentedController.h"
#import "Masonry.h"

@interface PresentingController ()<PresentedControllerDelegate>

@property (nonatomic,strong) InteractiveTransition *interative;

@end

@implementation PresentingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"present";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"picture"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(70);
        make.size.mas_equalTo(CGSizeMake(250, 250));
     
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"滑动present" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(imageView.mas_bottom).offset(30);
    }];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    _interative = [InteractiveTransition interativeTransitionWithTransitionType:InteractiveTransitionPresent GestureDirection:InteractiveTransitionGestureDirectionUp];
    typeof(self) __weak weakself = self;
    [_interative setPresentBlock:^(){
        [weakself present];
    }];
    [_interative addGestureForViewController:self.navigationController];
    
}

- (void)present{
    
    presentedController *presentedVC = [[presentedController alloc] init];
    presentedVC.delegate = self;
    [self presentViewController:presentedVC animated:YES completion:nil];
}

- (void)presentedControllerPressedDissmiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent{
    return _interative;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
