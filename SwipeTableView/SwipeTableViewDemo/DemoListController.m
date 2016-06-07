//
//  DemoListController.m
//  SwipeTableView
//
//  Created by Roy lee on 16/4/2.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

#import "DemoListController.h"
#import "DemoViewController.h"

@interface DemoListController ()

@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation DemoListController{
    UILabel * oneLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[@{
                            @"title":@"SingleOneKindView",
                            @"actionIdfy":kShouldReuseableViewIdentifier,
                            },
                        @{
                            @"title":@"HybridItemViews",
                            @"actionIdfy":kHybridItemViewsIdentifier,
                            },
                        @{
                            @"title":@"AdjustContentSize",
                            @"actionIdfy":kAdjustContentSizeToFitMaxItemIdentifier,},
                        @{
                            @"title":@"DisabledBarScroll",
                            @"actionIdfy":kDisabledSwipeHeaderBarScrollIdentifier,},
                        @{
                            @"title":@"HiddenNavigationBar",
                            @"actionIdfy":kHiddenNavigationBarIdentifier,
                            }];
    //测试block;
    oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:oneLabel];
    oneLabel.text = @"hello world";
    oneLabel.center = self.view.center;
    
}

#pragma mark - UITableView M
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"list_cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataSource[indexPath.row][@"title"];
    return cell;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
//viewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    DemoViewController * demoVC = [segue destinationViewController];
    [demoVC returnValueBlock:^(NSString *title) {
        oneLabel.text = title;
    }];
    UITableViewCell * cell = sender;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    demoVC.actionIdentifier = _dataSource[indexPath.row][@"actionIdfy"];
    demoVC.title            = _dataSource[indexPath.row][@"title"];
    [super prepareForSegue:segue sender:sender];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
