//
//  SecondViewController.m
//  Transsition_Scale
//
//  Created by yuanwei on 16/7/4.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "SecondViewController.h"
#import "TranstioneScaleAnimate.h"

@interface SecondViewController () <UINavigationControllerDelegate>

@property (nonatomic,strong) TranstioneScaleAnimate *animate;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.title  = @"SecondVC";
    
    self.animate  =  [[TranstioneScaleAnimate alloc] initWithAnimateType:animate_pop andDuration:0.35f];

    [self initUI];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.navigationController.delegate  = self;
}

- (void)initUI{

    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _imageView.center = CGPointMake(self.view.center.x, self.view.center.y + 12);
    _imageView.image = [UIImage imageNamed:@"picture"];
    [self.view addSubview:_imageView];
    
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (fromVC == self && operation == UINavigationControllerOperationPop) {
        return self.animate;
    }else{
        return nil;
    }
    
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
