//
//  LLYMachPortInputSourceViewController.m
//  LLYRunloopDemo
//
//  Created by lly on 2018/9/12.
//  Copyright © 2018年 lly. All rights reserved.
//

#import "LLYMachPortInputSourceViewController.h"
#import "LLYMachPortInputSourceThread.h"

#define kMsg1 100
#define kMsg2 101

@interface LLYMachPortInputSourceViewController ()<NSPortDelegate>{
}

@property (nonatomic, strong) NSPort *localPort;//主线程的端口号
@property (nonatomic, strong) LLYMachPortInputSourceThread *thread;

@end


@implementation LLYMachPortInputSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //给主线程的runloop加一个mach port source
    self.localPort = [[NSMachPort alloc] init];
    [self.localPort setDelegate:self];
    [[NSRunLoop currentRunLoop] addPort:self.localPort forMode:NSDefaultRunLoopMode];
    
    //创建一个子线程，并记录下主线程的端口，后面线程通信使用
    self.thread = [[LLYMachPortInputSourceThread alloc]init];
    self.thread.remotePort = self.localPort;
    [self.thread start];
    
    NSLog(@"current thread = %@",[NSThread currentThread]);
    
    //主线程创建一个timer source 用来唤醒子线程
    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(wakeupRunloop) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)wakeupRunloop{
    
    [self sendPortMessage];
    
}

- (void)sendPortMessage{
    
    //向子线的port发送消息 唤醒子线程 这里直接给端口发送消息 不用像custom input source那样做标记。
    [self.thread.localPort sendBeforeDate:[NSDate date]
                         msgid:kMsg2
                    components:nil
                          from:self.localPort
                      reserved:0];
    
}
- (void)handlePortMessage:(NSMessagePort*)message{
    
    NSLog(@"接到子线程传递的消息！%@",message);
    
//    //1. 消息id
//    NSUInteger msgId = [[message valueForKeyPath:@"msgid"] integerValue];
//
//    //2. 当前主线程的port
//    NSPort *localPort = [message valueForKeyPath:@"localPort"];
//
//    //3. 接收到消息的port（来自其他线程）
//    NSPort *remotePort = [message valueForKeyPath:@"remotePort"];
//
////    if (msgId == kMsg1)
////    {
////        //向子线的port发送消息
////        [remotePort sendBeforeDate:[NSDate date]
////                             msgid:kMsg2
////                        components:nil
////                              from:localPort
////                          reserved:0];
////
////    }
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
