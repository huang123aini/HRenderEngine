//
//  HMathUtils.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/19.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRect.h"
#import <GLKit/GLKit.h>

@interface HMathUtils : NSObject

+(float)contentScaleFactor:(GLKView*)view;

//converts a rect in points to pixels
+(HRect*)rectPointsToPixels:(HRect*)rect;

//converts a rect in pixels to points

+(HRect*)rectPixelsToPoints:(HRect*)rect;

@end
