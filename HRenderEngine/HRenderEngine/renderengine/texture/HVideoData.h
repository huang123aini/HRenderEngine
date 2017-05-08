//
//  HVideoData.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/5.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface HVideoData : NSObject

- (instancetype)initWithPlayerItem:(AVPlayerItem*)playerItem;
-(CVPixelBufferRef)copyPixelBuffer;

@end
