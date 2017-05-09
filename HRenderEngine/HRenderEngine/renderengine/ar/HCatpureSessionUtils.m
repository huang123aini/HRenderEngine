//
//  HCatpureSessionUtils.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/9.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HCatpureSessionUtils.h"


@import AVFoundation;

@interface HCatpureSessionUtils()

@property(nonatomic,nullable,retain) AVCaptureSession *customCaptureSession;//

@property(nonatomic,nullable,retain) AVCaptureVideoDataOutput *videoDataOutput;//

@property(nonatomic,nullable,retain) AVCaptureDeviceInput *backVideoInput;//back  camera

@property(nonatomic,nullable,retain) AVCaptureDeviceInput *frontVideoInput;//front camera

@property(nonatomic,nullable,assign) AVCaptureDeviceInput *currentVideoInput;//current camera

@end


@implementation HCatpureSessionUtils

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
        [self commonInitialization];
        
    }
    return self;
}

-(void)commonInitialization
{
    
    AVCaptureSession *captureSession=[[AVCaptureSession alloc]init];
    
    captureSession.sessionPreset=AVCaptureSessionPreset640x480;
    
    AVCaptureVideoDataOutput *videoDataOutput=[[AVCaptureVideoDataOutput alloc]init];
    
    NSMutableDictionary *defaultSetting=[NSMutableDictionary dictionaryWithDictionary:[videoDataOutput recommendedVideoSettingsForAssetWriterWithOutputFileType:AVFileTypeMPEG4]];
    

    videoDataOutput.alwaysDiscardsLateVideoFrames=YES;
    
    BOOL supportsFullYUVRange=NO;
    
    NSArray *supportedPixelFormats = videoDataOutput.availableVideoCVPixelFormatTypes;
    
    for (NSNumber *currentPixelFormat in supportedPixelFormats)
    {
        if ([currentPixelFormat intValue] == kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)
        {
            supportsFullYUVRange = YES;
        }
    }
    
    if (supportsFullYUVRange)
    {
        [defaultSetting setObject:@(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange) forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    }
    else
    {
        [defaultSetting setObject:@(kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange) forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    }
    
    [videoDataOutput setVideoSettings:defaultSetting];
    
    [captureSession addOutput:videoDataOutput];
    
    for (AVCaptureDevice *device in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo])
    {
        
        switch (device.position)
        {
            case AVCaptureDevicePositionBack:
            {
                
                AVCaptureDeviceInput *videoInput=[AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
                self.backVideoInput=videoInput;
            }
            break;
            
            case AVCaptureDevicePositionFront:
            {
                
                AVCaptureDeviceInput *videoInput=[AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
                self.frontVideoInput=videoInput;
            }
            break;
            
            default:
            break;
        }
        
    }
    
    self.customCaptureSession=captureSession;
    self.videoDataOutput=videoDataOutput;
    
    [self setVideoInput:_frontVideoInput];
    
}

-(void)startRunning
{
    
    [self.customCaptureSession startRunning];
}

-(void)setSampleBufferDelegate:(id<AVCaptureVideoDataOutputSampleBufferDelegate>)bufferDelegate queue:(dispatch_queue_t)queue
{
    
    [self.videoDataOutput setSampleBufferDelegate:bufferDelegate queue:queue];
    
}

-(void)stopRunning
{
    
    [self.customCaptureSession stopRunning];
}


-(void)swatchCamera
{
    
    switch (_currentVideoInput.device.position)
    {
        case AVCaptureDevicePositionBack:
        
        [self setVideoInput:_frontVideoInput];
        
        break;
        case AVCaptureDevicePositionFront:
        [self setVideoInput:_backVideoInput];
        break;
        
        default:
        break;
    }
    
}

-(void)setVideoInput:(AVCaptureDeviceInput*)deviceInput
{
    
    [self.customCaptureSession beginConfiguration];
    
    [self.customCaptureSession removeInput:_currentVideoInput];
    
    switch (_currentVideoInput.device.position)
    {
        case AVCaptureDevicePositionFront:
        
        _currentVideoInput=_backVideoInput;
        break;
        case AVCaptureDevicePositionBack:
        
        _currentVideoInput=_frontVideoInput;
        
        break;
        
        default:
        break;
    }
    
    [self.customCaptureSession addInput:deviceInput];
    
    _currentVideoInput=deviceInput;
    
    [self.customCaptureSession commitConfiguration];
    
    AVCaptureConnection *videoConnection = [_videoDataOutput connectionWithMediaType:AVMediaTypeVideo];
    if (videoConnection)
    {
        
        BOOL mirror = _currentVideoInput==_frontVideoInput;
        
        if ([videoConnection isVideoMirroringSupported])
        {
            
            [videoConnection setVideoMirrored:mirror];
            [videoConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];
        }
        
    }
    
}


@end
