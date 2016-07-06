//
//  FirstViewController.h
//  Transsition_Scale
//
//  Created by yuanwei on 16/7/4.
//  Copyright © 2016年 YuanWei. All rights reserved.
//


#import <UIKit/UIKit.h>


@class CollectionViewCell;

@interface FirstViewController : UIViewController


@property (nonatomic,strong) UICollectionView *collectionView;


- (CollectionViewCell *)collectionViewForCell;

@end
