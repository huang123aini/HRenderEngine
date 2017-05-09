//
//  HNv12Program.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/8.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HProgram.h"

@interface HNv12Program : HProgram

-(instancetype)init;

@property (nonatomic, assign) GLint uSamplerY;
@property (nonatomic, assign) GLint uSamplerUV;
@property (nonatomic, assign) GLint uColorConversionMatrix;

@end
