//
//  LLYCustomInputSourceViewController.m
//  LLYRunloopDemo
//
//  Created by lly on 2018/9/12.
//  Copyright © 2018年 lly. All rights reserved.
//

#import "LLYCustomInputSourceViewController.h"
#import "LLYCustomInputSourceThread.h"

@interface LLYCustomInputSourceViewController ()

@end

@implementation LLYCustomInputSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"CustomInputSource";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    LLYCustomInputSourceThread *thread = [[LLYCustomInputSourceThread alloc]init];
    [thread start];
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
