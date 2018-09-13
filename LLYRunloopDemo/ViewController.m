//
//  ViewController.m
//  LLYRunloopDemo
//
//  Created by lly on 2018/9/11.
//  Copyright © 2018年 lly. All rights reserved.
//

#import "ViewController.h"
#import "LLYCustomInputSourceViewController.h"
#import "LLYMachPortInputSourceViewController.h"
#import "LLYCustomModeViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSArray *dataSourceArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Runloop";
    self.dataSourceArray = @[@"Cusotm Input Source && Observer && Timer",@"Mach Port Input Source && Observer && Timer",@"Custom Mode && Block"];
    
    [self.view addSubview:self.mTableView];
    
//    NSRunLoop *runloop = [NSRunLoop mainRunLoop];
//    NSLog(@"runloop = %@",runloop);
//    NSLog(@"current thread = %@",[NSThread currentThread]);
    
}

- (void)LaunchThreadWithPort:(NSPort *)port{
    
    NSLog(@"current thread = %@",[NSThread currentThread]);
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    NSLog(@"runloop = %@",runloop);
    
}

#pragma mark - NSPortDelegate
- (void)handlePortMessage:(NSPortMessage *)message{
    
    NSLog(@"");
    
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = self.dataSourceArray[indexPath.row];
    return cell;
}

- (UITableView *)mTableView{
    
    if (!_mTableView) {
        _mTableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        [_mTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _mTableView;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        LLYCustomInputSourceViewController *vc = [[LLYCustomInputSourceViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1){
        LLYMachPortInputSourceViewController *vc = [[LLYMachPortInputSourceViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        LLYCustomModeViewController *vc = [[LLYCustomModeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
