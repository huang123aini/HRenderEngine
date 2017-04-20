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

@interface HRenderObject : HNode

#pragma mark  render
@property(nonatomic,strong)HTexture* texture;
@property(nonatomic,strong)HGLModel*   model;
@property(nonatomic,strong)HProgram* program;

-(void)setupTexture:(HTexture*)texture;
-(void)setupModel:(HGLModel*)model;
-(void)setupProgram:(HProgram*)program;

@end
