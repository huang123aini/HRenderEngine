//
//  HVideoData.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/5.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HVideoData.h"

@interface HVideoData()
{
    CMTime _lastTime;
}
@property (nonatomic, strong)AVPlayerItemVideoOutput* output;
@property (nonatomic, weak)AVPlayerItem* playerItem;

@end

@implementation HVideoData
- (instancetype)initWithPlayerItem:(AVPlayerItem*)playerItem
{
    self = [super init];
    if (self)
    {
        self.playerItem = playerItem;
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    NSDictionary *pixBuffAttributes = @{(id)kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_32BGRA)};
    self.output = [[AVPlayerItemVideoOutput alloc] initWithPixelBufferAttributes:pixBuffAttributes];
    
    [self.playerItem addOutput:self.output];
}

- (CVPixelBufferRef)copyPixelBuffer
{
    {
        if (self.output == nil) return nil;
        
        CMTime currentTime = [self.playerItem currentTime];
        CVPixelBufferRef pixelBuffer = [self.output copyPixelBufferForItemTime:currentTime itemTimeForDisplay:nil];
        
        if (pixelBuffer)
        {
            _lastTime = currentTime;
            
            return pixelBuffer;
        }else
        {
            if (CMTimeGetSeconds(_lastTime) > 0.0)
            {
                return [self.output copyPixelBufferForItemTime:_lastTime itemTimeForDisplay:nil];
            }else
            {
                return nil;
            }
        }
    }
    
    return nil;
}

-(void)dealloc
{
    if (self.playerItem != nil && self.output != nil)
    {
        [self.playerItem removeOutput:self.output];
        self.output = nil;
    }
}

@end
