//
//  HCameraMatrix.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HCameraMatrix.h"
#import "HSensors.h"
#import "HCamera.h"


@interface HCameraMatrix()

@property(nonatomic,strong)HSensors* sensors;

@end

@implementation HCameraMatrix

- (instancetype)init
{
    if (self = [super init])
    {
        [self setupSensors];
    }
    return self;
}

- (void)setupSensors
{
    self.sensors = [[HSensors alloc] init];
    [self.sensors start];
}

- (BOOL)singleMatrixWithSize:(CGSize)size matrix:(GLKMatrix4 *)matrix fingerRotation:(HFingerRotation *)fingerRotation
{

    if (!self.sensors.isReady) return NO;

    GLKMatrix4 modelViewMatrix = GLKMatrix4Identity;
    modelViewMatrix = GLKMatrix4RotateX(modelViewMatrix, -fingerRotation.x);
    
    modelViewMatrix = GLKMatrix4Multiply(modelViewMatrix, self.sensors.modelView);

    modelViewMatrix = GLKMatrix4RotateY(modelViewMatrix, fingerRotation.y);
    
    float aspect = fabs(size.width / size.height);
    
//    //摄像机类暂时提取出来
//    
//    float aspect = fabs(size.width / size.height);
//    HCamera* camera = [[HCamera alloc] initWithFov:[HFingerRotation degress] aspect:aspect near:0.1f far:400.f];
//    
//    camera.aspect = aspect;
//    camera.fov = [HFingerRotation degress];
//    camera.near = 0.1f;
//    camera.far = 400.f;
    
    
    
    
    GLKMatrix4 mvpMatrix = GLKMatrix4Identity;
    
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians([HFingerRotation degress]), aspect, 0.1f, 400.0f);
    
    GLKMatrix4 viewMatrix = GLKMatrix4MakeLookAt(0, 0, 0.0, 0, 0, -1000, 0, 1, 0);
    mvpMatrix = GLKMatrix4Multiply(projectionMatrix, viewMatrix);
    mvpMatrix = GLKMatrix4Multiply(mvpMatrix, modelViewMatrix);
    
    * matrix = mvpMatrix;
    
    return YES;
}

- (BOOL)doubleMatrixWithSize:(CGSize)size leftMatrix:(GLKMatrix4 *)leftMatrix rightMatrix:(GLKMatrix4 *)rightMatrix
{

    if (!self.sensors.isReady) return NO;
    
    GLKMatrix4 modelViewMatrix = self.sensors.modelView;
    

    float aspect = fabs(size.width / 2 / size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians([HFingerRotation degress]), aspect, 0.1f, 400.0f);
    
    CGFloat distance = 0.012;
    
    
    
//    //摄像机类暂时提取出来
//    HCamera* camera = [[HCamera alloc] initWithFov:[HFingerRotation degress] aspect:aspect near:0.1f far:400.f];
//    
//    camera.aspect = aspect;
//    camera.fov = [HFingerRotation degress];
//    camera.near = 0.1f;
//    camera.far = 400.f;
//    

    
    GLKMatrix4 leftViewMatrix  = GLKMatrix4MakeLookAt(-distance, 0, 0.0, 0, 0, -1000, 0, 1, 0);
    GLKMatrix4 rightViewMatrix = GLKMatrix4MakeLookAt(distance, 0, 0.0, 0, 0, -1000, 0, 1, 0);
    
    GLKMatrix4 leftMvpMatrix   = GLKMatrix4Multiply(projectionMatrix, leftViewMatrix);
    GLKMatrix4 rightMvpMatrix  = GLKMatrix4Multiply(projectionMatrix, rightViewMatrix);
    
    leftMvpMatrix  = GLKMatrix4Multiply(leftMvpMatrix, modelViewMatrix);
    rightMvpMatrix = GLKMatrix4Multiply(rightMvpMatrix, modelViewMatrix);
    
    *leftMatrix    = leftMvpMatrix;
    *rightMatrix   = rightMvpMatrix;
    
    return YES;
}



@end
