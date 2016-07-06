//
//  SecondViewController.m
//  Transition_Form
//
//  Created by yuanwei on 16/7/5.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#define k_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define k_SCREEN_HIGHT  [UIScreen mainScreen].bounds.size.height


#import "SecondViewController.h"
#import "TrainsitionAnimate.h"
#import "UIViewController+TrainsitionExtension.h"
#import "FirstViewController.h"

@interface SecondViewController ()<UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIView *targetView;
@property (nonatomic,strong) TrainsitionAnimate   *animate;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *headView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.animate = [[TrainsitionAnimate alloc] initWithAnimateType:animate_pop andDuration:1.5f];
    [self.view addSubview:self.targetView];
    
    [self initUI];
}


- (void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, k_SCREEN_WIDTH, k_SCREEN_HIGHT/2-64)];
    back.contentMode = UIViewContentModeScaleToFill;
    back.backgroundColor = [UIColor lightGrayColor];
    back.image = [UIImage imageNamed:@"page.jpg"];
    
    
    UIView *image = [[UIView alloc] initWithFrame:CGRectMake(20, k_SCREEN_HIGHT/2 - 64 - 70, k_SCREEN_WIDTH/3-20, (k_SCREEN_WIDTH/3 - 20)*1.3)];
    image.backgroundColor = self.select_color;
    self.targetView = image;
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, k_SCREEN_WIDTH, k_SCREEN_HIGHT-200)];
    _headView.backgroundColor = [UIColor purpleColor];
    [_headView addSubview:back];
    [_headView addSubview:image];
    
    
    self.tableView.tableHeaderView = _headView;
}


- (void)setSelect_color:(UIColor *)select_color{
    _select_color = select_color;
    _targetView.backgroundColor = _select_color;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        return self.animate;
    }else{
        return nil;
    }
    
}

#pragma mark -- UITabelViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString  *identId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identId];
    
    if (!cell) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identId];
    }
    cell.textLabel.text = @"TransitionAnimate";
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, k_SCREEN_WIDTH, k_SCREEN_HIGHT)];
        _tableView.dataSource      = self;
        _tableView.delegate        = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
    }
    return _tableView;
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
