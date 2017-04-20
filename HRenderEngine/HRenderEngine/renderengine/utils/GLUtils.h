//
//  GLUtils.h
//  HEngine_3DVR
//
//  Created by 黄世平 on 17/4/12.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMacros.h"

@interface GLUtils : NSObject

//shader method
+ (GLuint)loadShader:(GLenum)type withFilepath:(NSString *)shaderFilepath;

+ (GLuint)compileShaders:(NSString *)shaderVertex shaderFragment:(NSString *)shaderFragment;

void swapt(float* width, float *height);

//about texture
+ (GLuint)setupTextureWithImage:(UIImage *)image TextureFilter:(HTextureFilter) textureFilter;


@end
