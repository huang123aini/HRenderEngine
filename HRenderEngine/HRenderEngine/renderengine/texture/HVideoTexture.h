//
//  HVideoTexture.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/19.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HTexture.h"
#import <AVFoundation/AVFoundation.h>

@interface HVideoTexture : HTexture

-(instancetype)initWithAVPlayerItem:(AVPlayerItem*)playerItem;

- (CVPixelBufferRef)updateVideoTexture:(EAGLContext *)context Handle:(GLuint)uSamplerLocal;
@end
