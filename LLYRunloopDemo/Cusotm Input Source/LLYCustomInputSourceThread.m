//
//  LLYCustomInputSourceThread.m
//  LLYRunloopDemo
//
//  Created by lly on 2018/9/12.
//  Copyright © 2018年 lly. All rights reserved.
//

#import "LLYCustomInputSourceThread.h"
#import "LLYCustomInputSource.h"
#import "LLYCustomObserver.h"

@interface LLYCustomInputSourceThread ()

@property (nonatomic, strong) LLYCustomInputSource *inputSources;
@property (nonatomic, strong) NSRunLoop *runloop;

@end

@implementation LLYCustomInputSourceThread

- (void)main{

    [[NSThread currentThread] setName:@"LLYCustomInputSourceThread"];
    NSLog(@"current thread = %@",[NSThread currentThread]);
    self.runloop = [NSRunLoop currentRunLoop];
    NSLog(@"runloop = %@",self.runloop);

    //1.添加自定义Input source 到 runloop
    self.inputSources = [[LLYCustomInputSource alloc]init];
    [self.inputSources addToCurrentRunLoop];
    
    NSLog(@"runloop = %@",self.runloop);
    
    //2.添加runloop的观察者
    [LLYCustomObserver addCustomObserver];
    
    //3.再添加一个能唤醒runloop的方法，不然runloop会一直睡下去。。。这里需要注意一下顺序，需要在run之前添加,因为当前runloop内没有可主动唤醒的source 所以run之后当前线程会立即进入睡眠。不会执行run后面的代码。
    
    //尝试一下几种不同的唤醒方式
    //3.1 timer方式唤醒
    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(wakeupRunloop) userInfo:nil repeats:YES];
    [self.runloop addTimer:timer forMode:NSDefaultRunLoopMode];
    
    //3.2 手动唤醒 需要一个source
//    CFRunLoopSourceSignal(self.inputSources.runLoopSource);
//    CFRunLoopWakeUp(CFRunLoopGetCurrent());
    
    NSLog(@"runloop = %@",self.runloop);

    //5.如果没有手动run runloop的话 当前runloop是不会自动运行的 这里顺便看一下几个run方法的区别
    
    //5.1 run //只会睡眠不会退出
    [self.runloop run];
    
    //5.2 runMode:beforeDate //只执行一次 执行完就退出
//    [self.runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    
    //5.3 runUntilDate //到时间了才退出
//    [self.runloop runUntilDate:[NSDate distantFuture]];

}

- (void)wakeupRunloop{
    
    NSLog(@"wakeupRunloop");
    CFRunLoopStop(CFRunLoopGetCurrent());

//    4.手动标记为需要处理
//    source0每次触发前都需要标记一下。因为上一次处理完以后该source会被标记为不再处理
//    CFRunLoopSourceSignal(self.inputSources.runLoopSource);
}
@end
