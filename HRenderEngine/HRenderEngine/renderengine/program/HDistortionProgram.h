//
//  HDistortionProgram.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/18.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HProgram.h"

@interface HDistortionProgram : HProgram

@property(nonatomic,assign)GLuint aVignette;
@property(nonatomic,assign)GLuint aRedTextureCoord;
@property(nonatomic,assign)GLuint aGreenTextureCoord;
@property(nonatomic,assign)GLuint aBlueTextureCoord;

@property(nonatomic,assign)GLuint uTextureCoordScale;
@property(nonatomic,assign)GLuint uSampler;


-(instancetype)init;

@end
