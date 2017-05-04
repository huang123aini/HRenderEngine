//
//  OBJLoaderUtils.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/4.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "OBJLoaderUtils.h"

@implementation NSVertex
-(instancetype) init
{
    self = [super init];
    return self;
}
@end

@implementation Vec2

-(instancetype) initWithX:(float)x Y:(float)y
{
    if (self = [super init])
    {
        self.x = x;
        self.y = y;
    }
    return self;
}
@end

@implementation Vec3

-(instancetype)initWithX:(float)x Y:(float)y Z:(float)z
{
    if (self = [super initWithX:x Y:y])
    {
        self.z = z;
    }
    return self;
}
@end

@implementation NSVector3Idx

-(id)initWithX:(int) x Y: (int)y Z: (int)z
{
    if (self = [super init])
    {
        _data[0] = x;
        _data[1] = y;
        _data[2] = z;
    }
    return self;
}

-(int *) data
{
    return _data;
}

@end

@implementation NSTriangleIdx

-(instancetype) initWithPos:(NSVector3Idx* ) pos UV: (NSVector3Idx* ) tuv NRM: (NSVector3Idx* ) nrm
{
    if (self = [super init])
    {
        self.pos = pos;
        self.tuv = tuv;
        self.nrm = nrm;
        self.useNrm = YES;
        self.useUV = YES;
    }
    return self;
}
@end
