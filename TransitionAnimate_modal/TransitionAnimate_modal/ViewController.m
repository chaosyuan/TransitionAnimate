//
//  ViewController.m
//  TransitionAnimate_modal
//
//  Created by yuanwei on 16/7/6.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "ViewController.h"
#import "ModalTransitionDelegate.h"
#import "FirstViewController.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) ModalTransitionDelegate *customAnimateDelegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    btn.backgroundColor = [UIColor purpleColor];
    btn.center  = self.view.center;
    [btn addTarget:self action:@selector(presentClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
     _customAnimateDelegate =  [[ModalTransitionDelegate alloc] init];
}
- (void)presentClick {

    FirstViewController *firstVc   = [[FirstViewController alloc] init];
    firstVc.transitioningDelegate  = _customAnimateDelegate;
    firstVc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:firstVc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
