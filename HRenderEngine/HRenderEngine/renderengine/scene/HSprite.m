//
//  HSprite.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/2.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HSprite.h"

//face
const static VertexColor vertices[] =
{
    {{0.5,0.5,0},{1,0,0,1}},//A
    {{-0.5,0.5,0},{0,1,0,1}}, //B
    {{0.5,-0.5,0},{0,0,1,1}}, //C
    {{-0.5,-0.5,0},{1,1,0,1}}, //D
};

@interface HSprite()

@property(nonatomic,assign)VertexTexCoord* verticesT;
//@property(nonatomic,assign)GLubyte*        indicesT;

@end

@implementation HSprite

-(instancetype)init
{
    int VerticesSize = (sizeof vertices) / (sizeof vertices[0]);
    const int indicesSize =(VerticesSize-3)*3+3;
    GLubyte indices[indicesSize];
    indices[0] = 0;
    indices[1] = 1;
    indices[2] = 2;
    for (int i = 3; i < indicesSize; i+=3)
    {
        indices[i] = indices[i-2];
        indices[i+1] = indices[i-1];
        indices[i+2] = indices[i-1]+1;
    }
    
    HBaseEffect* shader = [[HBaseEffect alloc] initWithVertexS:@"spriteShader.vsh" fragmentS:@"spriteShader.fsh"];
    
    if((self = [super initWithShader:shader vertices:(VertexColor*) vertices vertexCount:VerticesSize indices:indices indexCount:indicesSize]))
    {
        
    }
    return self;
}

-(void)setRect:(HRect)rect
{
    float lowerRightCornerX =  rect.width / 2.0;
    float lowerRightCornerY = -rect.height / 2.0;
    float upperRightCornerX = lowerRightCornerX;
    
    float upperRightCornerY = rect.height / 2.0;
    float upperLeftCornerX  = rect.width / 2.0;
    float upperLeftCornerY  = upperRightCornerY;
    float lowerLeftCornerX  = upperLeftCornerX;
    float lowerLeftCornerY  = lowerRightCornerY;
    
    
    _verticesT[0].Position[0] = 1.0f;
    _verticesT[0].Position[1] = -1.0f;
    _verticesT[0].Position[2] = 0.f;
    _verticesT[0].TextureCoordinate[0] = 1.0f;
    _verticesT[0].TextureCoordinate[1] = 0.0f;
    
    _verticesT[1].Position[0] = 1.0f;
    _verticesT[1].Position[1] = 1.0f;
    _verticesT[1].Position[2] = 0.f;
    _verticesT[1].TextureCoordinate[0] = 1.f;
    _verticesT[1].TextureCoordinate[1] = 1.f;

    
    _verticesT[2].Position[0] = -1.f;
    _verticesT[2].Position[1] = 1.f;
    _verticesT[2].Position[2] = 0.f;
    _verticesT[2].TextureCoordinate[0] = 0.f;
    _verticesT[2].TextureCoordinate[1] = 1.f;

    
    _verticesT[3].Position[0] = -1.f;
    _verticesT[3].Position[1] = -1.f;
    _verticesT[3].Position[2] = 0.f;
    _verticesT[3].TextureCoordinate[0] = 0;
    _verticesT[3].TextureCoordinate[1] = 0;

    
    
}

-(instancetype)initWithImage:(UIImage*)image Rect:(HRect)rect
{
    
    
//    const static VertexTexCoord verticesT[] =
//    {
//        {{1,-1,0}, {1,0}},
//        {{1,1,0},  {1,1}},
//        {{-1,1,0}, {0,1}},
//        {{-1,-1,0},{0,0}}
//    };
//

    GLubyte indices[6];
    indices[0] = 0;
    indices[1] = 1;
    indices[2] = 2;
    
    indices[3] = 2;
    indices[4] = 3;
    indices[5] = 0;
    
    
    _verticesT = NULL;
   
    NSMutableData* verticesData = [NSMutableData dataWithLength:sizeof(VertexTexCoord) * 4];
    _verticesT = [verticesData mutableBytes];

    [self setRect:rect];
    
    HBaseEffect* shader = [[HBaseEffect alloc] initWithVertexS:@"spriteShader.vsh" fragmentS:@"spriteShader.fsh"];
    
    
    if((self = [super initWithShader:shader verticesTexCoord:(VertexTexCoord*) _verticesT vertexCount:4 indices:(GLubyte*)indices indexCount:6]))
    {
        [self loadTexture:[UIImage imageNamed:@"stone.jpg"]];
    }
    
    return self;
}

-(instancetype)initWithVerticesColor:(VertexColor *)Vertices verticesSize:(int)VerticesSize
{
    const int indicesSize =(VerticesSize-3)*3+3;
    GLubyte indices[indicesSize];
    indices[0] = 0;
    indices[1] = 1;
    indices[2] = 2;
    for (int i = 3; i < indicesSize; i+=3)
    {
        indices[i] = indices[i-2];
        indices[i+1] = indices[i-1];
        indices[i+2] = indices[i-1]+1;
    }
    
    HBaseEffect* shader = [[HBaseEffect alloc] initWithVertexS:@"spriteShader.vsh" fragmentS:@"spriteShader.fsh"];
    if((self = [super initWithShader:shader vertices:(VertexColor*) Vertices vertexCount:VerticesSize indices:indices indexCount:indicesSize]))
    {
        
    }
    return self;
}

-(instancetype)initWithVerticesColor:(VertexColor *)Vertices verticesSize:(int)VerticesSize indices:(GLubyte*)indices indicesSize:(int)indicesSize
{
    
    HBaseEffect* shader = [[HBaseEffect alloc] initWithVertexS:@"spriteShader.vsh" fragmentS:@"spriteShader.fsh"];
    
    if((self = [super initWithShader:shader vertices:(VertexColor*) Vertices vertexCount:VerticesSize indices:indices indexCount:indicesSize]))
    {
        
    }
    return self;
}

-(void)update:(float)dt
{
    self.rotationY += M_PI *dt/8;
}
@end
