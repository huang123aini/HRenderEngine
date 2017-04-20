//
//  HProgram.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HProgram.h"
#import "GLUtils.h"

@implementation HProgram


- (void)loadShaders:(NSString *)vertShader FragShader:(NSString *)fragShader
{
   self.program = [GLUtils compileShaders:vertShader shaderFragment:fragShader];
}

-(void)updateMVPMatrix:(GLKMatrix4)mvpMatrix
{
    glUniformMatrix4fv(self.uModelViewProjectionMatrix, 1, GL_FALSE, mvpMatrix.m);
}

-(void)setupAttributesAndUniforms
{

}

-(void)bindAttributesAndUniforms
{

}

- (void)useProgram
{
    glUseProgram(self.program);
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
