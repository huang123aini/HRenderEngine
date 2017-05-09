//
//  HYUV420Program.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/9.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HYUV420Program.h"
#define YUV420_VERTEXSHADER    [[NSBundle mainBundle] pathForResource:@"yuv420Shader" ofType:@"vsh"]
#define YUV420_FRAGMENTSHADER  [[NSBundle mainBundle] pathForResource:@"yuv420Shader" ofType:@"fsh"]


@implementation HYUV420Program

-(instancetype)init
{
    if (self = [super init])
    {
        //1.
        [self loadShaders:YUV420_VERTEXSHADER FragShader:YUV420_FRAGMENTSHADER];
        //2.
        [self setupAttributesAndUniforms];
        //3.
        [self useProgram];
        //4.
        [self bindAttributesAndUniforms];
        
        return self;
    }else
    {
        return nil;
    }
}

-(void)setupAttributesAndUniforms
{
    self.aPosition = glGetAttribLocation(self.program, "aPosition");
    self.aTexCoord = glGetAttribLocation(self.program, "aTexCoord");
    
    self.uModelViewProjectionMatrix = glGetUniformLocation(self.program, "uModelViewProjectionMatrix");
    self.uSamplerY = glGetUniformLocation(self.program, "uSamplerY");
    self.uSamplerU = glGetUniformLocation(self.program, "uSamplerU");
    self.uSamplerV = glGetUniformLocation(self.program, "uSamplerV");
}
-(void)bindAttributesAndUniforms
{
    glEnableVertexAttribArray(self.aPosition);
    glEnableVertexAttribArray(self.aTexCoord);
    
    glUniform1i(self.uSamplerY, 0);
    glUniform1i(self.uSamplerU, 1);
    glUniform1i(self.uSamplerV, 2);
}

-(void)dealloc
{
    if (self.program)
    {
        glDeleteProgram(self.program);
        self.program = 0;
    }
    
}
@end
