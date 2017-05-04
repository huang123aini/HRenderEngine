//
//  OBJLoaderUtils.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/4.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HVertexMacros.h"

@interface NSVertex : NSObject
-(instancetype) init;
@property OBJVertex vertex;
@end

@interface Vec2 : NSObject

@property(nonatomic,assign)float x;
@property(nonatomic,assign)float y;

-(instancetype) initWithX:(float)x Y:(float)y;
@end

@interface Vec3 : Vec2

@property(nonatomic,assign)float z;
-(instancetype) initWithX:(float)x Y:(float)y Z:(float)z;
@end

@interface NSVector3Idx : NSObject
{
    int _data[3];
}
-(int *) data;
-(instancetype) initWithX:(int) x Y: (int)y Z: (int)z;
@end

@interface NSTriangleIdx : NSObject
@property (strong, nonatomic) NSVector3Idx* pos;
@property (strong, nonatomic) NSVector3Idx* tuv;
@property (strong, nonatomic) NSVector3Idx* nrm;

@property BOOL useUV;
@property BOOL useNrm;

-(instancetype) initWithPos:(NSVector3Idx* ) pos UV: (NSVector3Idx* ) tuv NRM: (NSVector3Idx* ) nrm;
@end

typedef struct
{
    unsigned int vertices[3];
}Face;

