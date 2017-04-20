//
//  HModel.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HProgram.h"

@interface HGLModel : NSObject

@property(nonatomic,assign)GLuint vertexBuffer;
@property(nonatomic,assign)GLuint indexBuffer;
@property(nonatomic,assign)GLuint texCoordBuffer;

@property(nonatomic,assign)int vertexCount;
@property(nonatomic,assign)int indexCount;


+(instancetype)model;

-(void)setupModel;

-(void)setupGLData:(HProgram*)program;

@end
