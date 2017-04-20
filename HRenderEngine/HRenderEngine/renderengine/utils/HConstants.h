//
//  HConstants.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#ifndef HConstants_h
#define HConstants_h

#include <Availability.h>

// __OBJC__这个宏,在所有的.m和.mm文件中默认就定义了这个宏
#ifdef __OBJC__
// 如果这个全局的头文件或者宏只需要在.m或者.mm文件中使用,
// 请把该头文件或宏写到#ifdef __OBJC__ 中
#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import <Foundation/Foundation.h>

#import "Singleton.h"  //实现单例文件
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>


//自定义打印
#ifdef DEBUG // 处于开发节点
#define HLog(...) NSLog(__VA_ARGS__)
#else  // 处于发布节点
#define HLog(...)
#endif


#endif


#endif /* HConstants_h */
