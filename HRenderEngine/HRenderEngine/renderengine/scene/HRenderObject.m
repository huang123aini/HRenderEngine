//
//  HRenderObject.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HRenderObject.h"

@implementation HRenderObject

-(void)setupTexture:(HTexture*)texture
{
    self.texture = texture;
}
-(void)setupModel:(HGLModel*)model
{
    self.model = model;
}
-(void)setupProgram:(HProgram*)program
{
    self.program = program;
}

-(void)dealloc
{
    if (self.texture != nil)
    {
        self.texture = nil;
    }
    if (self.model != nil)
    {
        self.model = nil;
    }
    if (self.program != nil)
    {
        self.program = nil;
    }
}

@end
