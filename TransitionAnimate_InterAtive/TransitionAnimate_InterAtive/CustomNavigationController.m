//
//  CustomNavigationController.m
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/13.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "CustomNavigationController.h"
#import "NavigationInteractiveTransition.h"
@interface CustomNavigationController ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) NavigationInteractiveTransition *popTransition;

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:popRecognizer];
    
    self.popTransition  = [[NavigationInteractiveTransition alloc] initWithViewController:self];
    [popRecognizer addTarget:self.popTransition action:@selector(panGestureAction:)];
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
