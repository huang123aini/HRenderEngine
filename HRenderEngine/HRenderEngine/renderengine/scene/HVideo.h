//
//  HVideo.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/5.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HRenderObject.h"

#import "VIMVideoPlayer.h"

@class HVideo;

@protocol HVideoDelegate <NSObject>
- (void)errorToLoadVideo:(HVideo *)video;
@end

@interface HVideo : HRenderObject

@property(nonatomic , assign)NSURL *url;
@property(nonatomic , weak)AVPlayerItem *playerItem;
@property(nonatomic , weak)id <HVideoDelegate> delegate;

@property(nonatomic , strong)VIMVideoPlayer *avPlayer;

-(instancetype)initWithImage:(UIImage*)image;

-(instancetype)initAVPlayerWithURL:(NSURL *)url;
-(instancetype)initAVPlayerWithItem:(AVPlayerItem *)playerItem;

-(void)setPrepareToPlay:(BOOL)isPlay;

@end
