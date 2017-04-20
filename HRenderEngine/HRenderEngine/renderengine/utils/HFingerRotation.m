//
//  HFingerRotation.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HFingerRotation.h"

@implementation HFingerRotation
+ (instancetype)fingerRotation
{
    return [[self alloc] init];
}

+ (CGFloat)degress
{
    return 60.0;
}

- (void)clean
{
    self.x = 0;
    self.y = 0;
}

@end
