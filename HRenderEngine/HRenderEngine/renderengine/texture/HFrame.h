//
//  HFrame.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/8.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSUInteger, HFrameType)
{
    HFrameTypeNV12,
    HFrameTypeYUV420,
};
@interface HFrame : NSObject

@end
