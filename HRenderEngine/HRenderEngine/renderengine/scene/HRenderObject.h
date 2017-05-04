//
//  HRenderObject.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//
/**
 *@Note: 1.model 2.texture 3.program -> Draw
 */
#import "HNode.h"

#import "HBaseEffect.h"
#import "HVertexMacros.h"

@interface HRenderObject : HNode

#pragma mark  render
@property(nonatomic,strong)HTexture* texture;
@property(nonatomic,strong)HProgram* program;
@property(nonatomic,strong)HGLModel* model;

@property(nonatomic,strong)HBaseEffect* shader;

@property(nonatomic,assign)BOOL isObj;

-(instancetype)initWithShader:(HBaseEffect*)shader vertices:(VertexColor*)vertices vertexCount:(unsigned int)vertexCount indices:(GLubyte*) indices indexCount:(unsigned int)indexCount;


//for  texture
-(instancetype)initWithShader:(HBaseEffect*)shader verticesTexCoord:(VertexTexCoord*)vertices vertexCount:(unsigned int)vertexCount indices:(GLubyte*) indices indexCount:(unsigned int)indexCount;


-(instancetype)initWithShader:(HBaseEffect*)shader vertices:(VertexColor*)vertices vertexCount:(unsigned int)vertexCount;


-(instancetype)initWithModelShader:(HBaseEffect*)shader vertices:(VertexTextureNorm*)vertices vertexCount:(unsigned int)vertexCount;


-(instancetype)initWithShader:(HBaseEffect*)shader verticesTexture:(VertexTexture*)vertices vertexCount:(unsigned int)vertexCount indices:(GLubyte*) indices indexCount:(unsigned int)indexCount;


-(instancetype)initWithShader:(HBaseEffect*)shader verticesTextureNorm:(VertexTextureNorm*)vertices vertexCount:(unsigned int)vertexCount indices:(GLubyte*) indices indexCount:(unsigned int)indexCount;


-(instancetype)initWithShader:(HBaseEffect*)shader objData:(OBJModelData*)data;

-(void)render;
-(void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix;


-(void)loadTexture:(UIImage*)image;


@end
