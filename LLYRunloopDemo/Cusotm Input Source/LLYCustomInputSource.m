//
//  LLYCustomInputSource.m
//  LLYRunloopDemo
//
//  Created by lly on 2018/9/12.
//  Copyright © 2018年 lly. All rights reserved.
//

#import "LLYCustomInputSource.h"
#import "AppDelegate.h"

void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode){
    LLYCustomInputSource* obj = (__bridge LLYCustomInputSource*)info;
}

void RunLoopSourcePerformRoutine (void *info)
{
    LLYCustomInputSource*  obj = (__bridge LLYCustomInputSource*)info;
    [obj sourceFired];
}

void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    LLYCustomInputSource* obj = (__bridge LLYCustomInputSource*)info;
    AppDelegate* delegate = [AppDelegate sharedAppDelegate];
}

@implementation LLYCustomInputSource

- (id)init{
    CFRunLoopSourceContext context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL,
        &RunLoopSourceScheduleRoutine,
        RunLoopSourceCancelRoutine,
        RunLoopSourcePerformRoutine};
    self.runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);
    self.commands = [NSMutableArray array];
    return self;
}

- (void)addToCurrentRunLoop{
    
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFRunLoopAddSource(runloop, self.runLoopSource, kCFRunLoopDefaultMode);
    
}
- (void)invalidate{
    
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFRunLoopRemoveSource(runloop, self.runLoopSource, kCFRunLoopDefaultMode);
    
}

// Handler method
- (void)sourceFired{
    NSLog(@"Custom Input Source fired: do some work, dude!");
}

// Client interface for registering commands to process
- (void)addCommand:(NSInteger)command withData:(id)data{
    
    
    
}
- (void)fireAllCommandsOnRunLoop:(CFRunLoopRef)runloop{
    
    //手动唤醒runloop
    CFRunLoopSourceSignal(self.runLoopSource);
    CFRunLoopWakeUp(runloop);
}


@end

