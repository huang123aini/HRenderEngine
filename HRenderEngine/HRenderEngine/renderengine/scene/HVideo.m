//
//  HVideo.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/5.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HVideo.h"

#import "HGLVRModel.h"
#import "HObjectProgram.h"

#import "HVideoTexture.h"


@interface HVideo()<VIMVideoPlayerDelegate>
{
    HVideoTexture* _videoTexture;
    BOOL _isPrepareToPlay;
    
    NSTimer *_timer;
    BOOL _isSuccess;
    BOOL _isOnce;
    int _renderTime;
}

@property(nonatomic,strong)HGLVRModel* vrModel;
@property(nonatomic,strong)HObjectProgram* objectProgram;
@property(nonatomic,strong)HTexture* objectTexture;


@end

@implementation HVideo

-(instancetype)initWithImage:(UIImage*)image
{
    if (self = [super init])
    {
        
        self.texture = [[HTexture alloc] init];
        [self.texture setupTextureWithImage:image TextureFilter:H_LINEAR];
        
        self.model = [[HGLVRModel alloc] init];
        self.program = [[HObjectProgram alloc] init];
        
        return self;
    }
    return nil;
}

- (instancetype)initAVPlayerWithURL:(NSURL *)url
{
 
    
    if (self = [super init])
    {
        self.url = url;
        
        self.context = [EAGLContext currentContext];
        
        
        self.model = [[HGLVRModel alloc] init];
        self.program = [[HObjectProgram alloc] init];
        [self setupAVPlayer:url PlayerItem:nil];
    }
    
    return self;
}
- (instancetype)initAVPlayerWithItem:(AVPlayerItem *)playerItem
{
  
    if (self = [super init])
    {
        self.model = [[HGLVRModel alloc] init];
        self.program = [[HObjectProgram alloc] init];
        [self setupAVPlayer:nil PlayerItem:playerItem];
    }
    
    return self;
}

- (void)setupAVPlayer:(NSURL *)url PlayerItem:(AVPlayerItem *)item
{
    AVPlayerItem *playerItem = url?[[AVPlayerItem alloc] initWithURL:url]:item;
    self.playerItem = playerItem;
    
    self.avPlayer = [[VIMVideoPlayer alloc] init];
    self.avPlayer.delegate = self;
    [self.avPlayer setPlayerItem:playerItem];
    [self.avPlayer play];
    
    [self setupVideoPlayerItem:playerItem];
}

- (void)setupVideoPlayerItem:(AVPlayerItem *)playerItem
{

    _videoTexture = [[HVideoTexture alloc] initWithAVPlayerItem:playerItem];

}

- (void)setPrepareToPlay:(BOOL)isPlay
{
    _isPrepareToPlay = isPlay;
}

- (void)renderTexture
{

    CVPixelBufferRef pixelBufferRef = [_videoTexture updateVideoTexture:self.context Handle:self.program.uSampler];
    
    if (pixelBufferRef == nil)
    {
        if (!_isOnce)
        {
            _isOnce = true;
            _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(failedToLoadPlayer) userInfo:nil repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        }
    }else
    {
        _isSuccess = YES;
    }
}

- (void)videoPlayerIsReadyToPlayVideo:(VIMVideoPlayer *)videoPlayer
{
    
    [self setPrepareToPlay:YES];
}

- (void)failedToLoadPlayer
{
    if (!_isSuccess)
    {
        _isOnce = false;
        
        if (self.avPlayer)
        {
            HLog(@"failed to load playerItem, reload avPlayer!");
        }
        
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(errorToLoadVideo:)])
        {
            [self.delegate errorToLoadVideo:self];
        }
    }
    
    [_timer invalidate];
    _timer = nil;
}



-(void)update:(float)dt
{
    [self.model setupGLData:self.program];
}


-(void)draw:(GLKMatrix4)projectionMatrix
{
    if (self.model == nil || self.program == nil)
    {
        return;
    }
    
    if (!_isPrepareToPlay) return;
    _renderTime ++;
    if (_renderTime <= 15) return;
    
   
    
    [self.program useProgram];
    [self.program bindAttributesAndUniforms];
    
    [self renderTexture];
    if (!_isSuccess)
    {
        return;
    }
    
    
    [self.model setupGLData:self.program];
    
    [self.program updateMVPMatrix:projectionMatrix];
    
    glDrawElements(GL_TRIANGLES, self.model.indexCount, GL_UNSIGNED_SHORT, 0);
    
}

-(void)dealloc
{
    if (_videoTexture)
    {
        _videoTexture = nil;
    }
    
    if (self.program)
    {
        self.program = nil;
    }
    
    if (self.texture)
    {
        self.texture = nil;
    }
    
    if (self.vrModel)
    {
        self.vrModel = nil;
    }
    
    if (self.avPlayer)
    {
        self.avPlayer = nil;
    }
}
@end
