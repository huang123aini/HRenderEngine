//
//  HVertexMacros.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/20.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#ifndef HVertexMacros_h
#define HVertexMacros_h

#import <OpenGLES/ES2/gl.h>

struct Vertex
{
    //vertices
    GLKVector3 position;

    //texture coordinates
    GLKVector2 texture;
    
    //normals
    GLKVector3 normal;
    
    //color
    GLKVector4 color;
    
};
typedef struct Vertex HVertex;

struct FaceIndices
{
    //vertex indices
    GLushort a;
    GLushort b;
    GLushort c;
};
typedef struct FaceIndices HFaceIndices;

struct LineIndices
{
    //vertex indices
    GLushort a;
    GLushort b;
};
typedef struct LineIndices HLineIndices;


#endif /* HVertexMacros_h */
