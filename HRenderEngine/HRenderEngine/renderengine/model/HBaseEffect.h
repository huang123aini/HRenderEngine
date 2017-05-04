//
//  HBaseEffect.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/3.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HVertexMacros.h"

#import <OpenGLES/ES2/glext.h>
@import GLKit;

@interface HBaseEffect : NSObject

@property (nonatomic,assign) GLuint     program;
@property (nonatomic,assign) GLKMatrix4 modelViewMatrix;
@property (nonatomic,assign) GLKMatrix4 projectionMatrix;


//Ambient
@property (nonatomic,assign) GLKVector3 lightColor;
@property (nonatomic,assign) float      lightIntensity;

//Diffuse
@property (nonatomic,assign) GLKVector3 lightDirection;
@property (nonatomic,assign) float      lightDiffuseIntensity;

//Specular
@property (nonatomic,assign) float      MatSpecularIntensity;
@property (nonatomic,assign) float      Shininess;

//Texture
@property (nonatomic,assign) GLuint     texture;

- (id)initWithVertexS:(NSString *)vertexShader
            fragmentS:(NSString *)fragmentShader;
- (void)prepareToDraw;

@end
