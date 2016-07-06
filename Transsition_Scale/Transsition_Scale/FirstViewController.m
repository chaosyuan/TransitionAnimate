//
//  FirstViewController.m
//  Transsition_Scale
//
//  Created by yuanwei on 16/7/4.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "FirstViewController.h"
#import "CollectionViewCell.h"
#import "SecondViewController.h"
#import "TranstioneScaleAnimate.h"


#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HIGHT   [UIScreen mainScreen].bounds.size.height

static NSString *itemCellId  = @"itemId";

@interface FirstViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate>


@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,strong) TranstioneScaleAnimate *animate;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = @"FirstVC";
    self.animate = [[TranstioneScaleAnimate alloc] init];
    
    [self.view addSubview:self.collectionView];
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
}

- (nullable  id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    if (fromVC == self && operation == UINavigationControllerOperationPush) {
         return self.animate;
    }
    else {
        return nil;
    }
}

#pragma mark --UICollectionViewDataSourece
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemCellId forIndexPath:indexPath];
    
    cell.pictureImage.image = [UIImage imageNamed:@"picture"];
    cell.scaleLable.text    = @"Scale";
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SecondViewController *secVC = [[SecondViewController alloc] init];
    self.indexPath = indexPath;
    [self.navigationController pushViewController:secVC animated:YES];
}

- (CollectionViewCell *)collectionViewForCell {

    
    return (CollectionViewCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.indexPath.row inSection:0]];
}


- (UICollectionView *)collectionView{

    if(!_collectionView){
        
        UICollectionViewFlowLayout  *layout  = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake(150,183)];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 20;
        layout.minimumLineSpacing  = 10.0f;
        
        _collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT) collectionViewLayout:layout];
        _collectionView.backgroundColor  = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate   = self;
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:itemCellId];
    }
    return _collectionView;
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
