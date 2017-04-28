//
//  HMathUtils.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/21.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HMathUtils.h"

@implementation HMathUtils
+ (void)getGLCoordsFromCGRect:(CGRect
                               )rect Coords:(GLfloat*)coords
{
    coords[0] = (GLfloat)rect.origin.x;
    coords[1] = (GLfloat)rect.origin.y;
    coords[2] = (GLfloat)(rect.origin.x + rect.size.width);
    coords[3] = (GLfloat)rect.origin.y;
    coords[4] = (GLfloat)(rect.origin.x + rect.size.width);
    coords[5] = (GLfloat)(rect.origin.y + rect.size.height);
    coords[6] = (GLfloat)rect.origin.x;
    coords[7] = (GLfloat)(rect.origin.y + rect.size.height);
}

@end
