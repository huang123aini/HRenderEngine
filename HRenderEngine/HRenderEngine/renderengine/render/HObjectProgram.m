//
//  HObjectProgram.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/18.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HObjectProgram.h"
#define OBJECT_VERTEXSHADER    [[NSBundle mainBundle] pathForResource:@"objectShader" ofType:@"vsh"]
#define OBJECT_FRAGMENTSHADER  [[NSBundle mainBundle] pathForResource:@"objectShader" ofType:@"fsh"]

@implementation HObjectProgram

-(instancetype)init
{
    if (self = [super init])
    {
        //1.
        [self loadShaders:OBJECT_VERTEXSHADER FragShader:OBJECT_FRAGMENTSHADER];
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
    
    self.uSampler = glGetUniformLocation(self.program, "uSampler");
}

-(void)bindAttributesAndUniforms
{
    glEnableVertexAttribArray(self.aPosition);
    glEnableVertexAttribArray(self.aTexCoord);
    
    glUniform1i(self.uSampler, 0);
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
