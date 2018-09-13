//
//  LLYMachPortInputSourceThread.m
//  LLYRunloopDemo
//
//  Created by lly on 2018/9/13.
//  Copyright © 2018年 lly. All rights reserved.
//

#import "LLYMachPortInputSourceThread.h"
#import "LLYCustomObserver.h"

#define kThreadStackSize (8 *4096)
#define kCheckinMessage 100
#define kMsg1 100
#define kMsg2 101

@interface LLYMachPortInputSourceThread ()<NSPortDelegate>

@end

@implementation LLYMachPortInputSourceThread

- (void)main{
    
    [[NSThread currentThread] setName:@"LLYMachPortInputSourceThread"];
    NSLog(@"current thread = %@",[NSThread currentThread]);

    
    self.localPort = [NSMachPort port];
    self.localPort.delegate = self;
    
    NSLog(@"runloop = %@",[NSRunLoop currentRunLoop]);
    
    [LLYCustomObserver addCustomObserver];
    
    //添加到当前的runloop 然后啥也不用做 等着被唤醒
    [[NSRunLoop currentRunLoop] addPort:self.localPort forMode:NSDefaultRunLoopMode];
    
    NSLog(@"runloop = %@",[NSRunLoop currentRunLoop]);
    
    [[NSRunLoop currentRunLoop] run];
    
}

#pragma mark - NSPortDelegate

/**
 *  接收到主线程port消息
 */
- (void)handlePortMessage:(NSPortMessage *)message{
    
    NSLog(@"接收到主线程的消息...\n");
    
    [self sendPortMessage];

}


- (void)sendPortMessage {
    
    //发送消息到主线程
    [self.remotePort sendBeforeDate:[NSDate date]
                              msgid:kMsg1
                         components:nil
                               from:self.localPort
                           reserved:0];
}



@end
