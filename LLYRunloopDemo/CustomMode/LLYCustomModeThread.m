//
//  LLYCustomModeThread.m
//  LLYRunloopDemo
//
//  Created by lly on 2018/9/13.
//  Copyright © 2018年 lly. All rights reserved.
//

#import "LLYCustomModeThread.h"
#import "LLYCustomObserver.h"

static NSString *kCustomRunLoopMode = @"LLYCustomRunLoopMode";

@implementation LLYCustomModeThread

- (void)main{
    
    [[NSThread currentThread] setName:@"LLYCustomRunLoopModeThread"];
    NSLog(@"current thread = %@",[NSThread currentThread]);
    NSLog(@"runloop = %@",[NSRunLoop currentRunLoop]);
    
    [LLYCustomObserver addCustomObserver];

    CFRunLoopAddCommonMode(CFRunLoopGetCurrent(), (__bridge CFStringRef)(kCustomRunLoopMode));
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(wakeupRunloop) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:kCustomRunLoopMode];
    
    NSLog(@"runloop = %@",[NSRunLoop currentRunLoop]);
    
    [[NSRunLoop currentRunLoop] runMode:kCustomRunLoopMode beforeDate:[NSDate distantFuture]];
    
}

- (void)wakeupRunloop{
    
    NSLog(@"wakeupRunloop");
    
}

@end
