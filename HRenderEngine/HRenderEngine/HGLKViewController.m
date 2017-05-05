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
#import "HCubeT.h"

#import "HCubeNorm.h"
#import "HOBJNode.h"


#import "HSpriteProgram.h"

@interface HGLKViewController ()


@property (nonatomic, strong) NSLock * openGLLock;
@property(nonatomic,strong)EAGLContext* glContext;
@property (nonatomic, assign) CGRect viewport;


@property(nonatomic,strong)HSprite* sprite;
@property(nonatomic,strong)HCubeT* cube;
@property(nonatomic,strong)HCubeNorm* cubeNorm;
@property(nonatomic,strong)HOBJNode* objNode;



@property(nonatomic,strong)HSprite3D* sprite3d;

@property(nonatomic,strong)HScene* scene;

@end

@implementation HGLKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    [HGLManager sharedHGLManager].renderView = (GLKView*)self.view;
    
    
    [self setupOpenGL];
    
    self.fps = 30;
   
    
}

-(void)setupOpenGL
{
    //1.
    [self setupContext];
    //2.
    [self setupGLKView];
    
    self.distortionRender = [HDistortionRender distortionRenderer]; //设置畸变渲染
    
//    CGFloat scale = [UIScreen mainScreen].scale;
//    GLKView * glView = (GLKView*)self.view;
//    self.distortionRender.viewportSize = CGSizeMake(CGRectGetWidth(glView.bounds) * scale, CGRectGetHeight(glView.bounds) * scale);
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
   
    _cube = [[HCubeT alloc] init];
    _cube.scale = GLKVector3Make(0.5, 0.5, 0.5);
    [self.scene addChild:_cube];
    

    
      _sprite = [[HSprite alloc] initWithImage:[UIImage imageNamed:@"6.jpg"] Rect:HRectMake(0.5, 0.5)];
    
      _sprite.scale = GLKVector3Make(0.2, 0.2, 1);
      [self.scene addChild:_sprite];
    
    
    _objNode = [[HOBJNode alloc] initWithOBJFile:@"pyramid"];
    _objNode.scale = GLKVector3Make(0.01, 0.01, 0.01);
    _objNode.position =GLKVector3Make(0.5,-0.5,0);
    
    [self.scene addChild:_objNode];
    

    self.vrMatrix = [[HCameraMatrix alloc] init];
}

- (void)setFps:(int)fps
{
    _fps = fps;
    self.preferredFramesPerSecond = fps;
}

-(void)update
{
   
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
    
//    glEnable(GL_DEPTH_TEST);
//    glEnable(GL_CULL_FACE);
//    glEnable(GL_BLEND);
//    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
////    
//    
    
    //1.bind fbo
    [self.distortionRender beforDrawFrame];
    
    
    
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
    
    
    [view bindDrawable];
    
    //3.DRAW  FBO
    
    [self.distortionRender afterDrawFrame];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat scale = [UIScreen mainScreen].scale;
    
    GLKView * glView = (GLKView*)self.view;
    
    self.distortionRender.viewportSize = CGSizeMake(CGRectGetWidth(glView.bounds) * scale, CGRectGetHeight(glView.bounds) * scale);
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





























