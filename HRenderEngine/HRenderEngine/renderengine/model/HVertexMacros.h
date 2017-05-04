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



typedef struct 
{
    GLfloat Position[3];
}Vertex;

typedef struct
{
    GLfloat Position[3];
    GLfloat Color[4];
} VertexColor;

typedef struct
{
    GLfloat Position[3];
    GLfloat Color[4];
    GLfloat TextureCoordinate[2];
} VertexTexture;


typedef struct
{
    GLfloat Position[3];
    GLfloat TextureCoordinate[2];
    
}VertexTexCoord;

typedef struct
{
    GLfloat Position[3];
    GLfloat Color[4];
    GLfloat TextureCoordinate[2];
    GLfloat Normal[3];
} VertexTextureNorm;

#endif /* HVertexMacros_h */
