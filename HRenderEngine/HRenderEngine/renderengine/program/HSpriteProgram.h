//
//  HSpriteProgram.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/24.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HProgram.h"

@interface HSpriteProgram : HProgram

@property(nonatomic,assign)GLuint uSampler;

-(instancetype)init;
@end
