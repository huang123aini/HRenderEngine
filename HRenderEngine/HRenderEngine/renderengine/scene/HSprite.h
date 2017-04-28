//
//  HSprite.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HRenderObject.h"


typedef NS_ENUM(NSUInteger, HGLBlendMode)
{
    HGLBlendModeNormal = 0,   // GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA
    HGLBlendModeMultiply,     // GL_DST_COLOR, GL_ONE_MINUS_SRC_ALPHA
    HGLBlendModeAdd,          // GL_SRC_ALPHA, GL_ONE
    HGLBlendModeScreen        // GL_SRC_ALPHA, GL_ONE_MINUS_SRC_COLOR
};

@interface HSprite : HRenderObject

-(instancetype)initWithImage:(UIImage*)image;

-(void)setSpriteRect:(HRect)rect;

@end
