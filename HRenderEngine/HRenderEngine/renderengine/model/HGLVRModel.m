//
//  HVRModel.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HGLVRModel.h"

static GLuint vertexBuffer = 0;
static GLuint texCoordBuffer = 0;
static GLuint indexBuffer = 0;


static GLfloat * vertexBufferData = NULL;
static GLfloat * texCoordBufferData = NULL;
static GLushort * indexBufferData = NULL;


static int const slicesCount = 200;
static int const parallelsCount = slicesCount / 2;

static int const indexCount = slicesCount * parallelsCount * 6;
static int const vertexCount = (slicesCount + 1) * (parallelsCount + 1);

@implementation HGLVRModel

void setupVR()
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        float const step = (2.0f * M_PI) / (float)slicesCount;
        float const radius = 1.0f;
        
        // model
        vertexBufferData = malloc(sizeof(GLfloat) * 3 * vertexCount);
        texCoordBufferData = malloc(sizeof(GLfloat) * 2 * vertexCount);
        indexBufferData = malloc(sizeof(GLushort) * indexCount);
        
        int runCount = 0;
        for (int i = 0; i < parallelsCount + 1; i++)
        {
            for (int j = 0; j < slicesCount + 1; j++)
            {
                int vertex = (i * (slicesCount + 1) + j) * 3;
                
                if (vertexBufferData)
                {
                    vertexBufferData[vertex + 0] = radius * sinf(step * (float)i) * cosf(step * (float)j);
                    vertexBufferData[vertex + 1] = radius * cosf(step * (float)i);
                    vertexBufferData[vertex + 2] = radius * sinf(step * (float)i) * sinf(step * (float)j);
                }
                
                if (texCoordBufferData)
                {
                    int textureIndex = (i * (slicesCount + 1) + j) * 2;
                    texCoordBufferData[textureIndex + 0] = (float)j / (float)slicesCount;
                    texCoordBufferData[textureIndex + 1] = ((float)i / (float)parallelsCount);
                }
                
                if (indexBufferData && i < parallelsCount && j < slicesCount)
                {
                    indexBufferData[runCount++] = i * (slicesCount + 1) + j;
                    indexBufferData[runCount++] = (i + 1) * (slicesCount + 1) + j;
                    indexBufferData[runCount++] = (i + 1) * (slicesCount + 1) + (j + 1);
                    
                    indexBufferData[runCount++] = i * (slicesCount + 1) + j;
                    indexBufferData[runCount++] = (i + 1) * (slicesCount + 1) + (j + 1);
                    indexBufferData[runCount++] = i * (slicesCount + 1) + (j + 1);
                }
            }
        }
        
        //generate buffer
        glGenBuffers(1, &vertexBuffer);
        glGenBuffers(1, &texCoordBuffer);
        glGenBuffers(1, &indexBuffer);
    });
    
}

-(void)setupModel
{
    
    setupVR();
    self.indexCount = indexCount;
    self.vertexCount = vertexCount;
    self.vertexBuffer = vertexBuffer;
    self.texCoordBuffer = texCoordBuffer;
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
    glBufferData(GL_ARRAY_BUFFER, self.vertexCount * 2 * sizeof(GLfloat), texCoordBufferData, GL_DYNAMIC_DRAW);
    glEnableVertexAttribArray(program.aTexCoord);
    glVertexAttribPointer(program.aTexCoord, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat)*2, NULL);
    
    //3.index
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, self.indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, self.indexCount * sizeof(GLushort), indexBufferData, GL_STATIC_DRAW);
    
}

@end
