//
//  HTexture.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GLUtils.h"
#import "HMacros.h"

@interface HTexture : NSObject

@property(nonatomic, assign)GLuint textureId;


- (void)setupTextureWithImage:(UIImage *)image TextureFilter:(HTextureFilter)textureFilter;//设置纹理
 
-(void)bindTexture;

@end
