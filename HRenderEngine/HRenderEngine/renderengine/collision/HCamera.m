//
//  HCamera.m
//  HEngine_3DVR
//
//  Created by 黄世平 on 17/4/12.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HCamera.h"
@interface HCamera()
{
    BOOL needUpdateProjectionMatrix;
}
@end

@implementation HCamera

SingletonM(HCamera)

-(id) initWithFov:(float)fov aspect:(float)aspect near:(float)near far:(float)far
{
    self = [super init];
    if(self)
    {
        self.projectionMatrix = GLKMatrix4Identity;
        self.cameraModelMatrix = GLKMatrix4Identity;
        
        self.fov = GLKMathDegreesToRadians(fov);
        self.aspect = aspect;
        self.near = near;
        self.far = far;
        
        [self updatePlanes];
    }
    return self;
}

-(id) initWithLeft:(float)left right:(float)right bottom:(float)bottom top:(float)top near:(float)near far:(float)far
{
    self = [super init];
    if (self)
    {
        self.projectionMatrix = GLKMatrix4Identity;
        self.cameraModelMatrix = GLKMatrix4Identity;
        
        self.top = top;
        self.bottom = bottom;
        self.right = right;
        self.left = left;
        self.near = near;
        self.far = far;
        self.aspect = self.right / self.top;
        self.fov = atan(self.top / self.near) * 2;
        
        needUpdateProjectionMatrix = YES;
    }
    return self;
}

-(GLKMatrix4) projectionMatrix
{
    if (needUpdateProjectionMatrix)
    {
        [self updateProjectionMatrix];
    }
    return self.projectionMatrix;
}

-(void) updateProjectionMatrix
{
    
    GLKMatrix4 projectionMatrix = GLKMatrix4MakeFrustum(self.left, self.right, self.bottom, self.top, self.near, self.far);
    self.projectionMatrix = GLKMatrix4Multiply(projectionMatrix, self.cameraModelMatrix);
   
    needUpdateProjectionMatrix = NO;
}

-(void)updatePlanes
{
    self.top = tan(self.fov / 2) * self.near;
    self.bottom = -self.top;
    self.right = self.top * self.aspect;
    self.left = -self.right;
    
    needUpdateProjectionMatrix = YES;
}

-(void)setFov:(float)fov
{
    self.fov = GLKMathDegreesToRadians(fov);
    [self updatePlanes];
}

-(void)setAspect:(float)aspect
{
    self.aspect = aspect;
    [self updatePlanes];
}

-(void)setNear:(float)near
{
    self.near = near;
    [self updatePlanes];
}

-(void)setFar:(float)far
{
    self.far = far;
    [self updatePlanes];
}
-(void)setCameraModelMatrix:(GLKMatrix4)cameraModelMatrix
{
    needUpdateProjectionMatrix = YES;
}

#pragma mark --- camera position and rotation----

-(void)updateCameraModelMatrix
{
    GLKMatrix4 newMatrix = GLKMatrix4TranslateWithVector3(GLKMatrix4Identity, self.position);
    
    newMatrix = GLKMatrix4RotateX(newMatrix, GLKMathDegreesToRadians(self.rotation.x));
    newMatrix = GLKMatrix4RotateY(newMatrix, GLKMathDegreesToRadians(self.rotation.y));
    newMatrix = GLKMatrix4RotateZ(newMatrix, GLKMathDegreesToRadians(self.rotation.z));
    
    self.cameraModelMatrix = newMatrix;
}

-(void)setPosition:(GLKVector3)position
{
    self.position = position;
    [self updateCameraModelMatrix];
}

-(void)setRotation:(GLKVector3)rotation
{
    self.rotation = rotation;
    [self updateCameraModelMatrix];
}

@end



















