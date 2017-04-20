//
//  HTexture.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HTexture.h"

@implementation HTexture

- (void)setupTextureWithImage:(UIImage *)image TextureFilter:(HTextureFilter)textureFilter
{
    self.textureId = [GLUtils setupTextureWithImage:image TextureFilter:textureFilter];
}

-(void)bindTexture
{
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, self.textureId);
    
}
-(void)dealloc
{
    if (_textureId)
    {
        glDeleteTextures(1, &(_textureId));
    }
}


@end
