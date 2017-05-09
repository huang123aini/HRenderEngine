//
//  HVideoTexture.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/19.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HVideoTexture.h"
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <CoreVideo/CVOpenGLESTextureCache.h>

#import "HVideoData.h"

@interface HVideoTexture()

@property (nonatomic, strong) NSMutableDictionary* mContextTextureMap;
@property (nonatomic, strong) HVideoData *mDataAdatper;

@end

@implementation HVideoTexture

-(instancetype)initWithAVPlayerItem:(AVPlayerItem*)playerItem
{
    if (self = [super init])
    {
        self.mDataAdatper = [[HVideoData alloc] initWithPlayerItem:playerItem];
        self.mContextTextureMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (CVOpenGLESTextureCacheRef)textureCache:(EAGLContext*)context
{
    NSValue* value = [self.mContextTextureMap objectForKey:context.description];
    
    CVOpenGLESTextureCacheRef texture = [value pointerValue];
    if (texture == NULL)
    {
        CVReturn err = CVOpenGLESTextureCacheCreate(kCFAllocatorDefault, NULL, (__bridge CVEAGLContext _Nonnull)((__bridge void *)context), NULL, &texture);
        if (err) NSAssert(NO, @"Error at CVOpenGLESTextureCacheCreate");
        
        [self.mContextTextureMap setObject:[NSValue valueWithPointer:texture] forKey:context.description];
    }
    
    return texture;
}

- (CVPixelBufferRef)updateVideoTexture:(EAGLContext *)context Handle:(GLuint)uSamplerLocal
{
    CVPixelBufferRef pixelBuffer;
    
    pixelBuffer = [self updateAVPlayerVideoTexture:context Handle:uSamplerLocal];
    
    return pixelBuffer;
}

- (CVPixelBufferRef)updateAVPlayerVideoTexture:(EAGLContext *)context Handle:(GLuint)uSamplerLocal
{
    CVPixelBufferRef pixelBuffer = [self.mDataAdatper copyPixelBuffer];
    
    if (pixelBuffer == NULL) return nil;
    
    glActiveTexture(GL_TEXTURE0);
    
    [self updateTextureBuffer:pixelBuffer Context:(EAGLContext *)context];
    
    glUniform1i(uSamplerLocal, 0);
    
    return pixelBuffer;
}

- (void)updateTextureBuffer:(CVPixelBufferRef)pixelBuffer Context:(EAGLContext *)context
{
    
    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    
    GLsizei bufferHeight = (GLsizei)CVPixelBufferGetHeight(pixelBuffer);
    GLsizei bufferWidth = (GLsizei)CVPixelBufferGetWidth(pixelBuffer);
    
    CVOpenGLESTextureCacheRef textureCache = [self textureCache:context];
    CVOpenGLESTextureRef texture = NULL;
    
    CVReturn err = CVOpenGLESTextureCacheCreateTextureFromImage(kCFAllocatorDefault, textureCache, pixelBuffer, NULL, GL_TEXTURE_2D, GL_RGBA, bufferWidth, bufferHeight, GL_BGRA, GL_UNSIGNED_BYTE, 0, &texture);
    
    if (texture == NULL || err)
    {
        NSAssert(NO, @"Error at CVOpenGLESTextureCacheCreateTextureFromImage:%d",err);
    }
    
    GLuint outputTexture = CVOpenGLESTextureGetName(texture);
    glBindTexture(GL_TEXTURE_2D, outputTexture);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
    
    // Do processing work on the texture data here
    CVOpenGLESTextureCacheFlush(textureCache, 0);
    
    CFRelease(texture);
}

- (void)destory
{
    if (self.mContextTextureMap == nil) return;
    for (NSString * key in self.mContextTextureMap)
    {
        NSValue * value = [self.mContextTextureMap objectForKey:key];
        CVOpenGLESTextureCacheRef ref = [value pointerValue];
        CFRelease(ref);
    }
    
    self.mContextTextureMap = nil;
}
- (void)dealloc
{
    [self destory];
    HLog(@"Video Texture dealloc");
}

@end
