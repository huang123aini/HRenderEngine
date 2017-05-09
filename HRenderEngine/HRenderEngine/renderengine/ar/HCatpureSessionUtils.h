//
//  HCatpureSessionUtils.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/9.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>

@import AVFoundation;
@protocol AVCaptureVideoDataOutputSampleBufferDelegate;

@interface HCatpureSessionUtils : NSObject


-(void)startRunning;

-(void)setSampleBufferDelegate:(id<AVCaptureVideoDataOutputSampleBufferDelegate>)bufferDelegate queue:(dispatch_queue_t) queue;

-(void)stopRunning;

-(void)swatchCamera;

@end
