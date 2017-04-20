//
//  HSpriteFrame.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/19.
//  Copyright © 2017年 黄世平. All rights reserved.
//

/**
 *@Note:set sprite Frame 
 */

#import "HSpriteFrame.h"
#import "HMathUtils.h"

@implementation HSpriteFrame

-(void)setPointsRect:(HRect*)rect
{
    _rectInPoints = rect;
    _rectInPixels = [HMathUtils rectPointsToPixels:rect];
}
-(void)setPixelsRect:(HRect*)rect
{
    _rectInPixels = rect;
    _rectInPoints = [HMathUtils rectPixelsToPoints:rect];
}
@end
