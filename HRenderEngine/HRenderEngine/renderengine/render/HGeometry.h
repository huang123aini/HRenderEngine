//
//  HGeometry.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/28.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HVertexMacros.h"
@interface HGeometry : NSObject

@property(nonatomic,assign)int      numVertices;
@property(nonatomic,assign)HVertex* vertices;

@property(nonatomic,assign)int      numIndices;
@property(nonatomic,assign)GLuint*  indices;

-(instancetype)initWithNumVertices:(int)numVertices Vertices:(GLfloat*)vertices IndicesCount:(int)indicesCount   Indices:(GLuint* )indices;

@end
