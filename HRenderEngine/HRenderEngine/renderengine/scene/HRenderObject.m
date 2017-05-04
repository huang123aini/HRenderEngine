//
//  HRenderObject.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HRenderObject.h"

@interface HRenderObject()
{
    GLuint        _verticesArrayBuffer;
    GLuint        _vertexBuffer;
    GLuint        _indexBuffer;
    unsigned int  _indexCount;
    unsigned int  _vertexCount;
    HBaseEffect*  _shader;
    enum PrimitiveType
    {
        TriangleList,TriangleStrip,Triangles
    }_primitiveType;
}

@end

@implementation HRenderObject


-(instancetype)initWithShader:(HBaseEffect*)shader vertices:(VertexColor*)vertices vertexCount:(unsigned int)vertexCount indices:(GLubyte*) indices indexCount:(unsigned int)indexCount
{
    
    if ((self = [super init]))
    {
        _vertexCount = vertexCount;
        _indexCount = indexCount;
        _shader = shader;
      
        glGenVertexArraysOES(1, &_verticesArrayBuffer);
        glBindVertexArrayOES(_verticesArrayBuffer);
        
        glGenBuffers(1, &_vertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBufferData(GL_ARRAY_BUFFER, vertexCount * sizeof(VertexColor), vertices, GL_STATIC_DRAW);
       
        glGenBuffers(1, &_indexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, indexCount * sizeof(GLubyte), indices, GL_STATIC_DRAW);
        
        
        glEnableVertexAttribArray(GLKVertexAttribPosition);
        glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(VertexColor), (const GLvoid*)offsetof(VertexColor, Position));
        glEnableVertexAttribArray(GLKVertexAttribColor);
        glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(VertexColor), (const GLvoid*)offsetof(VertexColor, Color));
        
        glBindVertexArrayOES(0);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
        
        _primitiveType = TriangleList;
    }
    return self;
}


-(instancetype)initWithShader:(HBaseEffect*)shader verticesTexCoord:(VertexTexCoord*)vertices vertexCount:(unsigned int)vertexCount indices:(GLubyte*) indices indexCount:(unsigned int)indexCount
{
    if ((self = [super init]))
    {
        _vertexCount = vertexCount;
        _indexCount = indexCount;
        _shader = shader;
        
        glGenVertexArraysOES(1, &_verticesArrayBuffer);
        glBindVertexArrayOES(_verticesArrayBuffer);
        
        
        glGenBuffers(1, &_vertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBufferData(GL_ARRAY_BUFFER, vertexCount * sizeof(VertexTexCoord), vertices, GL_STATIC_DRAW);
        
        glGenBuffers(1, &_indexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, indexCount * sizeof(GLubyte), indices, GL_STATIC_DRAW);
        
        
        glEnableVertexAttribArray(GLKVertexAttribPosition);
        glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(VertexTexCoord), (const GLvoid*)offsetof(VertexTextureNorm, Position));
        
        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
        glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(VertexTexCoord), (const GLvoid*)offsetof(VertexTexCoord, TextureCoordinate));
        
    
        glBindVertexArrayOES(0);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
        
        _primitiveType = TriangleList;
        
    }
    return self;

}



-(instancetype)initWithShader:(HBaseEffect*)shader vertices:(VertexColor*)vertices vertexCount:(unsigned int)vertexCount
{
    if ((self = [super init]))
    {
    
        _vertexCount = vertexCount;
        _shader = shader;
       
       
        glGenVertexArraysOES(1, &_verticesArrayBuffer);
        glBindVertexArrayOES(_verticesArrayBuffer);
        
        glGenBuffers(1, &_vertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBufferData(GL_ARRAY_BUFFER, vertexCount * sizeof(VertexColor), vertices, GL_STATIC_DRAW);//
        
        glEnableVertexAttribArray(GLKVertexAttribPosition);
        glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(VertexColor), (const GLvoid*)offsetof(VertexColor, Position));
        glEnableVertexAttribArray(GLKVertexAttribColor);
        glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(VertexColor), (const GLvoid*)offsetof(VertexColor, Color));
        
        glBindVertexArrayOES(0);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
        
        _primitiveType = TriangleStrip;
    }
    return self;
}

-(instancetype)initWithModelShader:(HBaseEffect*)shader vertices:(VertexTextureNorm*)vertices vertexCount:(unsigned int)vertexCount
{
    
    if ((self = [super init]))
    {
        
        _vertexCount = vertexCount;
        _shader = shader;
    
        glGenVertexArraysOES(1, &_verticesArrayBuffer);
        glBindVertexArrayOES(_verticesArrayBuffer);
        

        glGenBuffers(1, &_vertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBufferData(GL_ARRAY_BUFFER, vertexCount * sizeof(VertexTextureNorm), vertices, GL_STATIC_DRAW);
        
        glEnableVertexAttribArray(GLKVertexAttribPosition);
        glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(VertexTextureNorm), (const GLvoid*)offsetof(VertexTextureNorm, Position));
        
        glEnableVertexAttribArray(GLKVertexAttribColor);
        glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(VertexTextureNorm), (const GLvoid*)offsetof(VertexTextureNorm, Color));
        
        
        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
        glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(VertexTextureNorm), (const GLvoid*)offsetof(VertexTextureNorm, TextureCoordinate));
        
        glEnableVertexAttribArray(GLKVertexAttribNormal);
        glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(VertexTextureNorm), (const GLvoid*)offsetof(VertexTextureNorm, Normal));
        
        glBindVertexArrayOES(0);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
        
        _primitiveType = Triangles;
    }
    return self;
}

-(instancetype)initWithShader:(HBaseEffect*)shader verticesTexture:(VertexTexture*)vertices vertexCount:(unsigned int)vertexCount indices:(GLubyte*) indices indexCount:(unsigned int)indexCount
{
    if ((self = [super init]))
    {
        _vertexCount = vertexCount;
        _indexCount = indexCount;
        _shader = shader;
       
        glGenVertexArraysOES(1, &_verticesArrayBuffer);
        glBindVertexArrayOES(_verticesArrayBuffer);
        
        glGenBuffers(1, &_vertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBufferData(GL_ARRAY_BUFFER, vertexCount * sizeof(VertexTexture), vertices, GL_STATIC_DRAW);//
        
        glGenBuffers(1, &_indexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, indexCount * sizeof(GLubyte), indices, GL_STATIC_DRAW);
        
        glEnableVertexAttribArray(GLKVertexAttribPosition);
        glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(VertexTexture), (const GLvoid*)offsetof(VertexTexture, Position));
        glEnableVertexAttribArray(GLKVertexAttribColor);
        glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(VertexTexture), (const GLvoid*)offsetof(VertexTexture, Color));
        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
        glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(VertexTexture), (const GLvoid*)offsetof(VertexTexture, TextureCoordinate));
        
        glBindVertexArrayOES(0);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
        
        _primitiveType = TriangleList;
    }
    return self;
}

-(instancetype)initWithShader:(HBaseEffect*)shader verticesTextureNorm:(VertexTextureNorm*)vertices vertexCount:(unsigned int)vertexCount indices:(GLubyte*) indices indexCount:(unsigned int)indexCount
{
    if ((self = [super init]))
    {
        _vertexCount = vertexCount;
        _indexCount = indexCount;
        _shader = shader;
        
        glGenVertexArraysOES(1, &_verticesArrayBuffer);
        glBindVertexArrayOES(_verticesArrayBuffer);
        
       
        glGenBuffers(1, &_vertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBufferData(GL_ARRAY_BUFFER, vertexCount * sizeof(VertexTextureNorm), vertices, GL_STATIC_DRAW);
        
        glGenBuffers(1, &_indexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, indexCount * sizeof(GLubyte), indices, GL_STATIC_DRAW);
        
     
        glEnableVertexAttribArray(GLKVertexAttribPosition);
        glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(VertexTextureNorm), (const GLvoid*)offsetof(VertexTextureNorm, Position));
        glEnableVertexAttribArray(GLKVertexAttribColor);
        glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(VertexTextureNorm), (const GLvoid*)offsetof(VertexTextureNorm, Color));
        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
        glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(VertexTextureNorm), (const GLvoid*)offsetof(VertexTextureNorm, TextureCoordinate));
        
        glEnableVertexAttribArray(GLKVertexAttribNormal);
        glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(VertexTextureNorm), (const GLvoid*)offsetof(VertexTextureNorm, Normal));
        
        glBindVertexArrayOES(0);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
        
        _primitiveType = TriangleList;
    }
    return self;
}
-(GLKMatrix4)modelMatrix
{
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4TranslateWithVector3(modelMatrix, self.position);
    
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationX, 1, 0, 0);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationY, 0, 1, 0);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationZ, 0, 0, 1);
    
    
    modelMatrix = GLKMatrix4ScaleWithVector3(modelMatrix, self.scale);
    return modelMatrix;
}
-(void)draw:(GLKMatrix4)projectionMatrix
{
    _shader.modelViewMatrix = [self modelMatrix];
    _shader.modelViewMatrix = [self modelMatrix];
    _shader.projectionMatrix = GLKMatrix4Identity;
    [_shader prepareToDraw];
    _shader.texture = self.texture.textureId;
    
    
    glBindVertexArrayOES(_verticesArrayBuffer);
    switch (_primitiveType)
    {
        case TriangleList:
            glDrawElements(GL_TRIANGLES, _indexCount, GL_UNSIGNED_BYTE, 0);
            break;
        case TriangleStrip:
            glDrawArrays(GL_TRIANGLE_STRIP, 0, _vertexCount);
            break;
        case Triangles:
            glDrawArrays(GL_TRIANGLES, 0, _vertexCount);
            break;
        default:
            break;
    }
    glBindVertexArrayOES(0);
    
}


-(void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix
{
    GLKMatrix4 modelViewMatrix = GLKMatrix4Multiply(parentModelViewMatrix, [self modelMatrix]);
    _shader.modelViewMatrix = modelViewMatrix;
    _shader.texture = self.texture.textureId;
    [_shader prepareToDraw];
    glBindVertexArrayOES(_verticesArrayBuffer);
    switch (_primitiveType)
    {
        case TriangleList:
            glDrawElements(GL_TRIANGLES, _indexCount, GL_UNSIGNED_BYTE, 0);
            break;
        case TriangleStrip:
            glDrawArrays(GL_TRIANGLE_STRIP, 0, _vertexCount);
            break;
        case Triangles:
            glDrawArrays(GL_TRIANGLES, 0, _vertexCount);
            break;
        default:
            break;
    }
    glBindVertexArrayOES(0);
}

-(void)loadTexture:(UIImage*)image
{
    self.texture = [[HTexture alloc] init];
    
    self.texture.textureId = [GLUtils setupTextureWithImage:image TextureFilter:H_LINEAR];


}

@end
