//
//  LLYMachPortInputSourceThread.h
//  LLYRunloopDemo
//
//  Created by lly on 2018/9/13.
//  Copyright © 2018年 lly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLYMachPortInputSourceThread : NSThread

@property (nonatomic, strong) NSPort *localPort;//子线程的端口号
@property (nonatomic, strong) NSPort *remotePort;//主线程的端口号

@end
