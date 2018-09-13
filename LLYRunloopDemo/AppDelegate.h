//
//  AppDelegate.h
//  LLYRunloopDemo
//
//  Created by lly on 2018/9/11.
//  Copyright © 2018年 lly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLYCustomInputSource.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(AppDelegate *)sharedAppDelegate;

@end

