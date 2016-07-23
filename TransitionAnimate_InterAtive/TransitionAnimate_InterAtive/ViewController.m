//
//  ViewController.m
//  TransitionAnimate_InterAtive
//
//  Created by yuanwei on 16/7/12.
//  Copyright © 2016年 YuanWei. All rights reserved.
//

#import "ViewController.h"
#import "PresentingController.h"
#import "PushViewController.h"

@interface ViewController()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic,strong) NSArray *viewControllers;


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.tableview];
}



- (UITableView *)tableview{

    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        
        _tableview.dataSource = self;
        _tableview.delegate   = self;
    }
    return   _tableview;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [self.dataList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataList[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[[NSClassFromString(self.viewControllers[indexPath.row]) alloc] init] animated:YES];
}


- (NSArray *)dataList{
    if (!_dataList) {
        _dataList = @[@"present",@"全屏翻页"];
    }
    return _dataList;
}
- (NSArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = @[@"PresentingController",@"PushViewController"];
    }
    return _viewControllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
