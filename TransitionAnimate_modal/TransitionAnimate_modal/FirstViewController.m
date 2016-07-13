//
//  FirstViewController.m
//  TransitionAnimate_modal
//
//  Created by yuanwei on 16/7/6.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "FirstViewController.h"
#import "ModalTransitionDelegate.h"


@interface FirstViewController ()

@property (nonatomic,strong) ModalTransitionDelegate *customAnimateDelegate;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor  = [UIColor brownColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(disMissClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)disMissClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
