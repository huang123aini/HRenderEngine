//
//  HSpriteModel.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/24.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HGLModel.h"
#import "HGeometry.h"

@interface HSpriteModel : HGLModel

@property(nonatomic,assign)float  width;
@property(nonatomic,assign)float  height;

-(instancetype)init;


@end
