//
//  HSpriteModel.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/24.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HSpriteModel.h"

static GLKVector3 vertexBufferDataSprite[] =
{
    //    {-1, 1, 0.0},
    //    {1,  1, 0.0},
    //    {1, -1, 0.0},
    //    {-1, -1, 0.0},
    
    {-0.5, 0.5, 0.0},
    {0.5,  0.5, 0.0},
    {0.5, -0.5, 0.0},
    {-0.5, -0.5, 0.0},
};

static GLushort indexBufferDataSprite[] =
{
    0, 1, 2, 0, 2, 3
};

static GLKVector2 textureBufferDataSprite[] =
{
    {0.0, 0.0},
    {1.0, 0.0},
    {1.0, 1.0},
    {0.0, 1.0},
};

static GLuint vertexBufferSprite = 0;
static GLuint textureBufferSprite = 0;
static GLuint indexBufferSprite = 0;

static int const indexCountSprite = 6;
static int const vertexCountSprite = 4;



@interface HSpriteModel()

@property(nonatomic,assign)GLfloat *vertexBufferDataSprite;

//-(void)calculateVertices;

@end

@implementation HSpriteModel

@synthesize height = _height;
@synthesize width = _width;


void setupSprite()
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        glGenBuffers(1, &vertexBufferSprite);
        glGenBuffers(1, &textureBufferSprite);
        glGenBuffers(1, &indexBufferSprite);
    });
}

-(void)setupModel
{
    setupSprite();
    
    self.indexCount = indexCountSprite;
    self.vertexCount = vertexCountSprite;
    
    self.vertexBuffer = vertexBufferSprite;
    self.texCoordBuffer = textureBufferSprite;
    self.indexBuffer = indexBufferSprite;
}

-(void)setupGLData:(HProgram *)program
{
    //1.vertex
    glBindBuffer(GL_ARRAY_BUFFER, self.vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, self.vertexCount * 3 * sizeof(GLfloat), vertexBufferDataSprite, GL_STATIC_DRAW);
    glEnableVertexAttribArray(program.aPosition);
    glVertexAttribPointer(program.aPosition, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(GLfloat), NULL);
    
    //2.texture coord
    glBindBuffer(GL_ARRAY_BUFFER, self.texCoordBuffer);
    glBufferData(GL_ARRAY_BUFFER, self.vertexCount * 2 * sizeof(GLfloat), textureBufferDataSprite, GL_DYNAMIC_DRAW);
    glEnableVertexAttribArray(program.aTexCoord);
    glVertexAttribPointer(program.aTexCoord, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat)*2, NULL);
    
    //3.index
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, self.indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, self.indexCount * sizeof(GLushort), indexBufferDataSprite, GL_STATIC_DRAW);
    
}


-(instancetype)init
{
    self = [super init];
    if (self)
    {
        
        [self setupModel];
        
        NSMutableData* verticesData = [NSMutableData dataWithLength:sizeof(GLKVector3) * 4];
        _vertexBufferDataSprite = [verticesData mutableBytes];
               
        self->_width  = 1.0f;
        self->_height = 1.0f;
        
       [self calculateVertices];
        
       return self;
    }
    return nil;
}

-(void) calculateVertices
{

    _vertexBufferDataSprite[0] = -1;
    _vertexBufferDataSprite[0] = 1;
    _vertexBufferDataSprite[0] = 0;
    
    
    _vertexBufferDataSprite[0] = 1;
    _vertexBufferDataSprite[0] = 1;
    _vertexBufferDataSprite[0] = 0;
    
    _vertexBufferDataSprite[0] = 1;
    _vertexBufferDataSprite[0] = -1;
    _vertexBufferDataSprite[0] = 0;
    
    _vertexBufferDataSprite[0] = -1;
    _vertexBufferDataSprite[0] = -1;
    _vertexBufferDataSprite[0] = 0;
    
   

}

-(void) setWidth:(float)width
{
    self->_width = width;
    [self calculateVertices];
}

-(void) setHeight:(float)height
{
    self->_height = height;
    [self calculateVertices];
}



-(void)dealloc
{
   
}

@end
