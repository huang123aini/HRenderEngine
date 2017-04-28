//
//  HNormalModel.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HGLNormalModel.h"

static GLKVector3 vertexBufferData[] =
{
    {-1, 1, 0.0},
    {1,  1, 0.0},
    {1, -1, 0.0},
    {-1, -1, 0.0},
    
//    {-0.5, 0.5, 0.0},
//    {0.5,  0.5, 0.0},
//    {0.5, -0.5, 0.0},
//    {-0.5, -0.5, 0.0},
};

static GLushort indexBufferData[] =
{
    0, 1, 2, 0, 2, 3
};

static GLKVector2 textureBufferData[] =
{
    {0.0, 0.0},
    {1.0, 0.0},
    {1.0, 1.0},
    {0.0, 1.0},
};

static GLuint vertexBuffer = 0;
static GLuint textureBuffer = 0;
static GLuint indexBuffer = 0;

static int const indexCount = 6;
static int const vertexCount = 4;

@implementation HGLNormalModel

void setupNormal()
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        glGenBuffers(1, &vertexBuffer);
        glGenBuffers(1, &textureBuffer);
        glGenBuffers(1, &indexBuffer);
    });
}

-(void)setupModel
{
    setupNormal();
    
    self.indexCount = indexCount;
    self.vertexCount = vertexCount;
    
    self.vertexBuffer = vertexBuffer;
    self.texCoordBuffer = textureBuffer;
    self.indexBuffer = indexBuffer;
}

-(void)setupGLData:(HProgram *)program
{
    //1.vertex
    glBindBuffer(GL_ARRAY_BUFFER, self.vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, self.vertexCount * 3 * sizeof(GLfloat), vertexBufferData, GL_STATIC_DRAW);
    glEnableVertexAttribArray(program.aPosition);
    glVertexAttribPointer(program.aPosition, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(GLfloat), NULL);
    
    //2.texture coord
    glBindBuffer(GL_ARRAY_BUFFER, self.texCoordBuffer);
    glBufferData(GL_ARRAY_BUFFER, self.vertexCount * 2 * sizeof(GLfloat), textureBufferData, GL_DYNAMIC_DRAW);
    glEnableVertexAttribArray(program.aTexCoord);
    glVertexAttribPointer(program.aTexCoord, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat)*2, NULL);
    
    //3.index
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, self.indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, self.indexCount * sizeof(GLushort), indexBufferData, GL_STATIC_DRAW);
    
}

@end


























