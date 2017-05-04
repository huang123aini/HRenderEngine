//
//  HSprite.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/2.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HRenderObject.h"

@interface HSprite : HRenderObject

-(instancetype)init;

-(instancetype)initWithImage:(UIImage*)image Rect:(HRect)rect;

-(void)setRect:(HRect)rect;

-(instancetype)initWithVerticesColor:(VertexColor *)Vertices verticesSize:(int)VerticesSize;

-(instancetype)initWithVerticesColor:(VertexColor *)Vertices verticesSize:(int)VerticesSize indices:(GLubyte*)indices indicesSize:(int)indicesSize;

@end
