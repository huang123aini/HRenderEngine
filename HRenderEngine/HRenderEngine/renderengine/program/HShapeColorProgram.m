//
//  HShapeColorProgram.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/21.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HShapeColorProgram.h"

#define SHAPECOLOR_VERTEXSHADER    [[NSBundle mainBundle] pathForResource:@"shapeColorShader" ofType:@"vsh"]
#define SHAPECOLOR_FRAGMENTSHADER  [[NSBundle mainBundle] pathForResource:@"shapeColorShader" ofType:@"fsh"]

@implementation HShapeColorProgram

-(instancetype)init
{
    if (self = [super init])
    {
        //1.
        [self loadShaders:SHAPECOLOR_VERTEXSHADER FragShader:SHAPECOLOR_FRAGMENTSHADER];
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
    
}

-(void)bindAttributesAndUniforms
{
    glEnableVertexAttribArray(self.aPosition);
    glEnableVertexAttribArray(self.aTexCoord);
  
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

