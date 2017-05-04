//
//  HSpriteProgram.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/24.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HSpriteProgram.h"
#define SPRITE_VERTEXSHADER    [[NSBundle mainBundle] pathForResource:@"spriteShader" ofType:@"vsh"]
#define SPRITE_FRAGMENTSHADER  [[NSBundle mainBundle] pathForResource:@"spriteShader" ofType:@"fsh"]

@implementation HSpriteProgram


-(instancetype)init
{
    if (self = [super init])
    {
        //1.
        [self loadShaders:SPRITE_VERTEXSHADER FragShader:SPRITE_FRAGMENTSHADER];
        //2.
        [self setupAttributesAndUniforms];
        //3.
        [self useProgram];
        //4.
        [self bindAttributesAndUniforms];
        
       
    }
    return self;
}

-(void)setupAttributesAndUniforms
{
    self.aPosition = glGetAttribLocation(self.program, "aPosition");
    self.aTexCoord = glGetAttribLocation(self.program, "aTexCoord");
    self.aNormal   = glGetAttribLocation(self.program, "aNormal");
    self.aColor    = glGetAttribLocation(self.program, "aColor");
    
    self.uModelViewProjectionMatrix = glGetUniformLocation(self.program, "uModelViewProjectionMatrix");
    self.uSampler = glGetUniformLocation(self.program, "uSampler");


}

-(void)bindAttributesAndUniforms
{
    glEnableVertexAttribArray(self.aPosition);
    glEnableVertexAttribArray(self.aTexCoord);
    glEnableVertexAttribArray(self.aNormal);
    glEnableVertexAttribArray(self.aColor);
  
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
