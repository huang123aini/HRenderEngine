//
//  HFrame.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/8.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HFrame.h"

@interface HFrame()

@property(nonatomic,assign)CVPixelBufferRef pixelBuffer;

@end

@implementation HFrame

+(instancetype)frame
{
    return [[self alloc] init];
}

@end
