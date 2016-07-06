//
//  FirstViewController.m
//  Transition_Form
//
//  Created by yuanwei on 16/7/5.
//  Copyright © 2016年 YuanWei. All rights reserved.
//


#define k_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define k_SCREEN_HIGHT  [UIScreen mainScreen].bounds.size.height

#import "FirstViewController.h"
#import "UIViewController+TrainsitionExtension.h"
#import "TrainsitionAnimate.h"
#include "CollectionCell.h"
#import "SecondViewController.h"

@interface FirstViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UICollectionView   *collectionView;
@property (nonatomic,strong) TrainsitionAnimate *animate;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FirstVc";
    self.animate = [[TrainsitionAnimate alloc] init];
    [self.view addSubview:self.collectionView];
    
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}
#pragma mark --UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    CGFloat hue          = (arc4random() % 256 / 256.0 );
    CGFloat saturation   = (arc4random() % 128 / 256.0 ) + 0.5f;
    CGFloat brightness   = (arc4random() % 128 / 256.0 ) + 0.5f;
    cell.backgroundColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.f];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{

    CollectionCell *cell = (CollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    self.targetView = cell;
    SecondViewController *seconVC = [[SecondViewController alloc] init];
    seconVC.select_color = cell.backgroundColor;
    [self.navigationController pushViewController:seconVC animated:YES];
}

- (UICollectionView *)collectionView{

    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake(k_SCREEN_WIDTH/3-20, (k_SCREEN_WIDTH/3-20)*1.3)];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [layout setMinimumInteritemSpacing:20];
        [layout setMinimumLineSpacing:20];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, k_SCREEN_WIDTH, k_SCREEN_HIGHT) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate        = self;
        _collectionView.dataSource      = self;
        [_collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"cellId"];
    }
    return _collectionView;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
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
