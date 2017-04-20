//
//  HDistortionRender.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "HDistortionProgram.h"

@interface HDistortionRender : NSObject

+ (instancetype)distortionRenderer;

- (instancetype)initWithViewportSize:(CGSize)viewportSize;

@property (nonatomic, assign) CGSize viewportSize;

- (void)beforDrawFrame;

- (void)afterDrawFrame;

@end
