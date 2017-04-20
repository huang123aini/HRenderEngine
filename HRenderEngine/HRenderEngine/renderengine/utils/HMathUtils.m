//
//  HMathUtils.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/19.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HMathUtils.h"
#import <GLKit/GLKit.h>
#import "HGLManager.h"

@implementation HMathUtils
+(float)contentScaleFactor:(GLKView*)view
{
   return view.contentScaleFactor;
}


+(HRect*) rectPointsToPixels:(HRect*)rect
{
    float scale = [HMathUtils contentScaleFactor:[HGLManager sharedHGLManager].renderView];
    
    HRect* rectResult = [[HRect alloc] init];
    
    GLKVector2 vec2 = GLKVector2Make(rect.origin.x * scale, rect.origin.y * scale);
    rectResult.origin = vec2;
    
    rectResult.size.width = rect.size.width * scale;
    rectResult.size.height = rect.size.height * scale;
    return rectResult;
}

+(HRect*)rectPixelsToPoints:(HRect*)rect
{
    float scale = [HMathUtils contentScaleFactor:[HGLManager sharedHGLManager].renderView];
    
    HRect* rectResult = [[HRect alloc] init];
    
    GLKVector2 vec2 = GLKVector2Make(rect.origin.x / scale, rect.origin.y / scale);
    rectResult.origin = vec2;
    
    rectResult.size.width = rect.size.width / scale;
    rectResult.size.height = rect.size.height / scale;
    return rectResult;
}

@end
