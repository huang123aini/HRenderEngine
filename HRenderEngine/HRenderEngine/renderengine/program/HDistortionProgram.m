//
//  HDistortionProgram.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/18.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HDistortionProgram.h"

#define DISTORTION_VERTEXSHADER    [[NSBundle mainBundle] pathForResource:@"distortionShader" ofType:@"vsh"]
#define DISTORTION_FRAGMENTSHADER  [[NSBundle mainBundle] pathForResource:@"distortionShader" ofType:@"fsh"]


@interface HDistortionProgram()
{
  
}
@end

@implementation HDistortionProgram
-(instancetype)init
{
    if (self = [super init])
    {
        
        //1.
        [self loadShaders:DISTORTION_VERTEXSHADER FragShader:DISTORTION_FRAGMENTSHADER];
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
    self.aVignette = glGetAttribLocation(self.program, "aVignette");
    
    
    if (self.aPosition == -1 || self.aVignette == -1)
    {
        [NSException raise:@"DistortionRenderer" format:@"Could not get attrib location for aPosition or aVignette"];
    }
    
    
    if (YES)
    {
        self.aRedTextureCoord   = glGetAttribLocation(self.program, "aRedTextureCoord");
        self.aGreenTextureCoord = glGetAttribLocation(self.program, "aGreenTextureCoord");
        self.aBlueTextureCoord  = glGetAttribLocation(self.program, "aBlueTextureCoord");
        
        if (self.aRedTextureCoord == -1 || self.aGreenTextureCoord == -1 || self.aBlueTextureCoord == -1)
        {
            [NSException raise:@"DistortionRenderer" format:@"Could not get attrib location for aRedTextureCoord or aGreenTextureCoord or aBlueTextureCoord"];
        }
    }
    
    {
        self.uTextureCoordScale = glGetUniformLocation(self.program, "uTextureCoordScale");
       
        self.uSampler = glGetUniformLocation(self.program, "uSampler");
        if (self.uTextureCoordScale == -1 || self.uSampler == -1)
        {
            [NSException raise:@"DistortionRenderer" format:@"Could not get attrib location for uTextureCoordScale or uSampler"];
        }

    }
    
}

-(void)bindAttributesAndUniforms
{
    glEnableVertexAttribArray(self.aPosition);
    glEnableVertexAttribArray(self.aVignette);
    glEnableVertexAttribArray(self.aRedTextureCoord);
    glEnableVertexAttribArray(self.aGreenTextureCoord);
    glEnableVertexAttribArray(self.aBlueTextureCoord);

    glUniform1f(self.uTextureCoordScale, 1.0f);
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
























