//
//  HModel.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HProgram.h"

#import "HGeometry.h"

@interface HGLModel : NSObject

@property(nonatomic,assign)GLuint vertexBuffer;
@property(nonatomic,assign)GLuint indexBuffer;
@property(nonatomic,assign)GLuint texCoordBuffer;

@property(nonatomic,assign)int vertexCount;
@property(nonatomic,assign)int indexCount;


@property(nonatomic,strong)HGeometry* geometry;
@property(nonatomic,assign) GLuint linesIndicesBuffer;
@property(nonatomic,assign) GLuint facesIndicesBuffer;

@property(nonatomic,assign)BOOL    isNeedUpdateVertices;

-(void)updateVertices;

+(instancetype)model;

-(void)setupModel;

-(void)setupGLData:(HProgram*)program;


#pragma mark --------------



@end
