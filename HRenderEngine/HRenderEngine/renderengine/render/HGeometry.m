//
//  HGeometry.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/28.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HGeometry.h"

@interface HGeometry()
{
    NSMutableData* verticesData;
    NSMutableData* indicesData;
}

@end

@implementation HGeometry

-(instancetype)initWithNumVertices:(int)numVertices Vertices:(GLfloat*)vertices IndicesCount:(int)indicesCount   Indices:(GLuint* )indices
{
    self = [super init];
    if (self)
    {
        self.numVertices  = numVertices;
        self.numIndices   = indicesCount;
        
        if(vertices && indices)
        {
            //赋值
        }
        
    }
    return self;

}

-(int)numVertices
{
    return self.numVertices;
}

-(int)numIndices
{
    return self.numIndices;
}

-(void)setVertices:(HVertex *)vertices
{
    for (int i = 0; i < self.numVertices; ++i)
    {
        self.vertices[i] = vertices[i];
    }
}

-(HVertex*)vertices
{
    if (self.vertices == nil)
    {
        verticesData = [NSMutableData dataWithLength:sizeof(HVertex)*self.numVertices];
        self.vertices = [verticesData mutableBytes];
    }
    return self.vertices;
}



-(void)setIndices:(GLuint *)indices
{
    for (int i = 0; i < self.numIndices; i++)
    {
        self.indices[i] = indices[i];
    }
}

-(GLuint*)indices
{
    if (self.indices == nil)
    {
        indicesData = [NSMutableData dataWithLength:sizeof(GLuint) * self.numIndices];
        
        self.indices = [indicesData mutableBytes];
    }
    return self.indices;
}


@end
