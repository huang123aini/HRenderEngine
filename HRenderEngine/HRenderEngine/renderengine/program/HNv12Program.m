//
//  HNv12Program.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/8.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HNv12Program.h"

#define Nv12_VERTEXSHADER    [[NSBundle mainBundle] pathForResource:@"nv12Shader" ofType:@"vsh"]
#define Nv12_FRAGMENTSHADER  [[NSBundle mainBundle] pathForResource:@"nv12Shader" ofType:@"fsh"]


@implementation HNv12Program

-(instancetype)init
{
    
    if (self = [super init])
    {
        //1.
        [self loadShaders:Nv12_VERTEXSHADER FragShader:Nv12_FRAGMENTSHADER];
        
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

- (void)setupAttributesAndUniforms
{
    self.aPosition = glGetAttribLocation(self.program, "aPosition");
    self.aTexCoord = glGetAttribLocation(self.program, "aTexCoord");
    
    
    self.uModelViewProjectionMatrix = glGetUniformLocation(self.uModelViewProjectionMatrix, "uModelViewProjectionMatrix");
    self.uSamplerY = glGetUniformLocation(self.program, "uSamplerY");
    self.uSamplerUV = glGetUniformLocation(self.program, "uSamplerUV");
    self.uColorConversionMatrix = glGetUniformLocation(self.program, "uColorConversionMatrix");
}

- (void)bindAttributesAndUniforms
{
    glEnableVertexAttribArray(self.aPosition);
    glEnableVertexAttribArray(self.aTexCoord);
    
    static GLfloat colorConversion709[] =
    {
        1.164,    1.164,     1.164,
        0.0,      -0.213,    2.112,
        1.793,    -0.533,    0.0,
    };
    
    glUniformMatrix3fv(self.uColorConversionMatrix, 1, GL_FALSE, colorConversion709);
    glUniform1i(self.uSamplerY, 0);
    glUniform1i(self.uSamplerUV, 1);
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
