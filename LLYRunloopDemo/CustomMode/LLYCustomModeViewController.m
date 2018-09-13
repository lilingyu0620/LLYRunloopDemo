//
//  LLYCustomModeViewController.m
//  LLYRunloopDemo
//
//  Created by lly on 2018/9/13.
//  Copyright © 2018年 lly. All rights reserved.
//

#import "LLYCustomModeViewController.h"
#import "LLYCustomModeThread.h"

@interface LLYCustomModeViewController ()

@property (nonatomic, strong) LLYCustomModeThread *thread;

@end

@implementation LLYCustomModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.thread = [[LLYCustomModeThread alloc]init];
    [self.thread start];
    
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
