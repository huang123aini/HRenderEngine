//
//  HDistortionRender.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HDistortionRender.h"
#import "HDistortionModel.h"

@interface HDistortionRender()
{
    GLuint index_buffer_id;
    GLuint vertex_buffer_id;
    GLuint texture_buffer_id;

}

@property(nonatomic,assign)GLuint FBOHandle;
@property(nonatomic,assign)GLuint FBOTexture;
@property(nonatomic,assign)GLuint ColorRender;

@property(nonatomic,strong) HDistortionProgram* program;

@property(nonatomic, strong)HDistortionModel*   leftEye;
@property(nonatomic, strong)HDistortionModel*   rightEye;


@end

@implementation HDistortionRender

+ (instancetype)distortionRenderer
{
    return [[self alloc] initWithViewportSize:CGSizeZero];
}

- (instancetype)initWithViewportSize:(CGSize)viewportSize
{
    if (self = [super init])
    {
        self.viewportSize = viewportSize;
        
        [self setup];
    }
    return self;
}

- (void)setViewportSize:(CGSize)viewportSize
{
    if (!CGSizeEqualToSize(_viewportSize, viewportSize))
    {
        _viewportSize = viewportSize;
        [self resetFrameBufferSize];
    }
}

-(void)beforDrawFrame
{
  glBindFramebuffer(GL_FRAMEBUFFER, _FBOHandle);
}

- (void)afterDrawFrame
{
    glViewport(0, 0, self.viewportSize.width, self.viewportSize.height);
    
    glDisable(GL_CULL_FACE);
    glDisable(GL_SCISSOR_TEST);
    
    glClearColor(0, 0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glEnable(GL_SCISSOR_TEST);
    
    glScissor(0, 0, self.viewportSize.width / 2, self.viewportSize.height);
    [self draw:self.leftEye];
    
    glScissor(self.viewportSize.width / 2, 0, self.viewportSize.width / 2, self.viewportSize.height);
    [self draw:self.rightEye];
    
    glDisable(GL_SCISSOR_TEST);
}


- (HDistortionModel *)leftEye
{
    if (!_leftEye)
    {
        _leftEye = [HDistortionModel modelWithModelType:HDistortionModelTypeLeft];
    }
    return _leftEye;
}

- (HDistortionModel *)rightEye
{
    if (!_rightEye)
    {
        _rightEye = [HDistortionModel modelWithModelType:HDistortionModelTypeRight];
    }
    return _rightEye;
}


- (void)draw:(HDistortionModel *)eye
{
    [self.program useProgram];
    [self.program bindAttributesAndUniforms];
    
    glBindBuffer(GL_ARRAY_BUFFER, eye.vertexBuffer);
    
    glVertexAttribPointer(self.program.aPosition, 2, GL_FLOAT, GL_FALSE, 9 * sizeof(float), (void *)(0 * sizeof(float)));
   
   // glEnableVertexAttribArray(self.program.aPosition);
    
    glVertexAttribPointer(self.program.aVignette, 1, GL_FLOAT, GL_FALSE, 9 * sizeof(float), (void *)(2 * sizeof(float)));
   // glEnableVertexAttribArray(self.program.aVignette);
    
    
    glVertexAttribPointer(self.program.aBlueTextureCoord, 2, GL_FLOAT, GL_FALSE, 9 * sizeof(float), (void *)(7 * sizeof(float)));
    //glEnableVertexAttribArray(self.program.aBlueTextureCoord);
    
    if (YES)
    {
        glVertexAttribPointer(self.program.aRedTextureCoord, 2, GL_FLOAT, GL_FALSE, 9 * sizeof(float), (void *)(3 * sizeof(float)));
       // glEnableVertexAttribArray(self.program.aRedTextureCoord);
        
        glVertexAttribPointer(self.program.aGreenTextureCoord, 2, GL_FLOAT, GL_FALSE, 9 * sizeof(float), (void *)(5 * sizeof(float)));
       // glEnableVertexAttribArray(self.program.aGreenTextureCoord);
    }
    
    //绘制FBO
    {
      glActiveTexture(GL_TEXTURE0);
      glBindTexture(GL_TEXTURE_2D, _FBOTexture);
     // glUniform1i(self.program.uSampler, 0);
    }
    
    
   // float _resolutionScale = 1;
   // glUniform1f(self.program.uTextureCoordScale, _resolutionScale);
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, eye.indexBuffer);
    
    glDrawElements(GL_TRIANGLE_STRIP, eye.indexCount, GL_UNSIGNED_SHORT, 0);
}


- (void)setupFrameBuffer
{
    glGenTextures(1, &_FBOTexture);
    glBindTexture(GL_TEXTURE_2D, _FBOTexture);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    
    [self checkGLError];
    
    
    glGenRenderbuffers(1, &_ColorRender);
    glBindRenderbuffer(GL_RENDERBUFFER, _ColorRender);
    
    [self checkGLError];
    
    glGenFramebuffers(1, &_FBOHandle);
    glBindFramebuffer(GL_FRAMEBUFFER, _FBOHandle);
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, _FBOTexture, 0);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _ColorRender);
    
    [self checkGLError];
    
    
}


- (void)resetFrameBufferSize
{
    glBindTexture(GL_TEXTURE_2D, _FBOTexture);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, self.viewportSize.width, self.viewportSize.height, 0, GL_RGB, GL_UNSIGNED_BYTE, nil);
    
    glBindRenderbuffer(GL_RENDERBUFFER, _ColorRender);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, self.viewportSize.width, self.viewportSize.height);
}

- (void)setup
{
    
    [self setupFrameBuffer];
    self.program = [[HDistortionProgram alloc] init];
    [self resetFrameBufferSize];
    
    
}

- (void)checkGLError
{
    GLenum err = glGetError();
    if (err != GL_NO_ERROR)
    {
        HLog(@"glError: 0x%04X", err);
    }
}



@end




























