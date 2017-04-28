//
//  HMacros.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#ifndef HMacros_h
#define HMacros_h

typedef NS_ENUM(NSInteger,HTextureFilter)
{
    H_NEAREST,
    H_LINEAR,
    H_NEAREST_MIPMAP_NEAREST,
    H_LINEAR_MIPMAP_NEAREST,
    H_NEAREST_MIPMAP_LINEAR,
    H_LINEAR_MIPMAP_LINEAR,
};


typedef struct _HRect
{
    float width;
    float height;
}HRect;

static inline HRect HRectMake(float width,float height)
{
    HRect v;
    v.width = width;
    v.height = height;
    return v;
}

#endif /* HMacros_h */
