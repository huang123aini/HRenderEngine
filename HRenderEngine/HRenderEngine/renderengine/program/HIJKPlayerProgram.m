//
//  HIJKPlayerProgram.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/18.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HIJKPlayerProgram.h"

#define IJKPLAYER_VERTEXSHADER    [[NSBundle mainBundle] pathForResource:@"ijkplayerShader" ofType:@"vsh"]
#define IJKPLAYER_FRAGMENTSHADER  [[NSBundle mainBundle] pathForResource:@"ijkplayerShader" ofType:@"fsh"]


@implementation HIJKPlayerProgram

-(instancetype)init
{
    if (self = [super init])
    {
        //1.
        [self loadShaders:IJKPLAYER_VERTEXSHADER FragShader:IJKPLAYER_FRAGMENTSHADER];
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
