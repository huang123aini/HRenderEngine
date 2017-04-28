//
//  HGLKViewController.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/18.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HGLKViewController.h"
#import "HGLManager.h"
#import "HCamera.h"



#import "HScene.h"


#import "HSprite.h"
#import "HSprite3D.h"


@interface HGLKViewController ()

@property(nonatomic,strong)EAGLContext* glContext;

@property (nonatomic, assign) CGRect viewport;

@property(nonatomic,strong)HSprite* sprite;
@property(nonatomic,strong)HSprite* sprite2;
@property(nonatomic,strong)HSprite3D* sprite3d;

@property(nonatomic,strong)HScene* scene;

@end

@implementation HGLKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    [HGLManager sharedHGLManager].renderView = (GLKView*)self.view;
    
    self.fps = 30;
    //1.
    [self setupContext];
    
    //2.
    [self setupGLKView];
    
    //3.
    [self setupModelAndTexture];
    
}

-(void)setupContext
{
    _glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!_glContext)
    {
        HLog(@"Failed to create ES 2.0 context");
    }
    
    [EAGLContext setCurrentContext:_glContext];
}


- (void)setupGLKView
{
    GLKView *view = (GLKView *)self.view;
    view.context = _glContext;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    self.preferredFramesPerSecond = self.fps;
    view.contentScaleFactor = [UIScreen mainScreen].scale;
    
    self.distortionRender = [HDistortionRender distortionRenderer]; //设置畸变渲染
    
    self.viewport = view.bounds;
}

-(void)setupModelAndTexture
{
    self.avPlayerProgram = [[HAVPlayerProgram alloc] init];
    self.ijkPlayerProgram = [[HIJKPlayerProgram alloc] init];
    
 

    //生成的场景里元素都在当前上下文中
    self.scene = [[HScene alloc] initWithContext:self.glContext];
    
    _sprite3d = [[HSprite3D alloc] initWithImage:[UIImage imageNamed:@"6.jpg"]];
    [self.scene addChild:_sprite3d];
    

    
    _sprite = [[HSprite alloc] initWithImage:[UIImage imageNamed:@"zebra.png"]];
    
    [_sprite setSpriteRect:HRectMake(1.0, 1.0)];
    
     [self.scene addChild:_sprite];

    self.vrMatrix = [[HCameraMatrix alloc] init];
}

- (void)setFps:(int)fps
{
    _fps = fps;
    self.preferredFramesPerSecond = fps;
}

-(void)update
{
   // [_sprite update:self.timeSinceLastUpdate];
    
    [self.scene update:self.timeSinceLastUpdate];
  
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        return; //进入后台不播放
    }
    
    
    
    glClearColor(0, 0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    
    
    //1.bind fbo
  //  [self.distortionRender beforDrawFrame];
    
    
    
    //2.
    

    {
        GLKMatrix4 leftMatrix;
        GLfloat scale = [UIScreen mainScreen].scale;
        CGRect  rect = CGRectMake(0, 0,self.viewport.size.width * scale , self.viewport.size.height * scale);
        
        GLKMatrix4 rightMatrix;
        BOOL success = [self.vrMatrix doubleMatrixWithSize:rect.size leftMatrix:&leftMatrix rightMatrix:&rightMatrix];
        

        if (success)
        {
            glViewport(rect.origin.x, rect.origin.y, CGRectGetWidth(rect)/2, CGRectGetHeight(rect));
            
            [self.scene draw:leftMatrix];
          
            
            glViewport(CGRectGetWidth(rect)/2 + rect.origin.x, rect.origin.y, CGRectGetWidth(rect)/2, CGRectGetHeight(rect));
            
            [self.scene draw:rightMatrix];
            
        }
    }
    
    
   // [self.scene draw];
    
    //draw normal object
    {
        
//        [self.objectProgram useProgram];
//        [self.objectProgram bindAttributesAndUniforms];
//        [self.normalModel setupGLData:self.objectProgram];
//        
//        [self.objectTexture bindTexture];
//        
//        [self.objectProgram updateMVPMatrix:GLKMatrix4Identity];
//        glDrawElements(GL_TRIANGLES, self.normalModel.indexCount, GL_UNSIGNED_SHORT, 0);
    }
    

    
    //3.DRAW  FBO
    
//    [self.distortionRender afterDrawFrame];
}

#pragma mark 强制横屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end





























