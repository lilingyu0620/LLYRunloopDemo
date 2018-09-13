//
//  LLYCustomInputSource.h
//  LLYRunloopDemo
//
//  Created by lly on 2018/9/12.
//  Copyright © 2018年 lly. All rights reserved.
//

//* 需要input source处理的信息
//* 让感兴趣的客户端知道怎么联系你的input source
//* 一个处理程序例程来执行任何客户端的发送请求
//* 取消程序


#import <Foundation/Foundation.h>

// These are the CFRunLoopSourceRef callback functions.
void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode);
void RunLoopSourcePerformRoutine (void *info);
void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode);

@interface LLYCustomInputSource : NSObject

@property (nonatomic) CFRunLoopSourceRef runLoopSource;
@property (nonatomic, strong) NSMutableArray* commands;

- (id)init;
- (void)addToCurrentRunLoop;
- (void)invalidate;

// Handler method
- (void)sourceFired;

// Client interface for registering commands to process
- (void)addCommand:(NSInteger)command withData:(id)data;
- (void)fireAllCommandsOnRunLoop:(CFRunLoopRef)runloop;

@end


