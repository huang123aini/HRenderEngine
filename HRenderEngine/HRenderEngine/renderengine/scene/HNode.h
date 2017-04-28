//
//  HNode.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTexture.h"
#import "HGLModel.h"
#import "HProgram.h"

@interface HNode : NSObject

#pragma mark gamescene

@property(nonatomic,strong)EAGLContext* context;

@property(nonatomic,assign)GLKVector3 position;
@property(nonatomic,assign)GLKVector3 rotation;
@property(nonatomic,assign)GLKVector3 scale;

@property(nonatomic,assign)BOOL       isVisible;
@property(nonatomic,strong)HNode*     parent; //父节点
@property(nonatomic,strong)NSMutableArray* children;

-(void)addChild:(HNode*)node;
-(void)removeChild:(HNode*)node;
-(void)update:(float)dt;
-(void)draw;

-(void)draw:(GLKMatrix4)projectionMatrix;

//init in current context
-(instancetype)initWithContext:(EAGLContext*)context;

@end
