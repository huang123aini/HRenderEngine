//
//  HCamera.h
//  HEngine_3DVR
//
//  Created by 黄世平 on 17/4/12.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HNode.h"
#import <GLKit/GLKit.h>
#import "Singleton.h"

@interface HCamera : HNode

SingletonH(HCamera)

@property (nonatomic,assign) float fov;
@property (nonatomic,assign) float aspect;
@property (nonatomic,assign) float near;
@property (nonatomic,assign) float far;


@property (nonatomic, assign) float left;
@property (nonatomic, assign) float right;
@property (nonatomic, assign) float bottom;
@property (nonatomic, assign) float top;

@property(nonatomic,assign)GLKVector3 up;
@property(nonatomic,assign)GLKVector3 lookat;


@property(nonatomic,assign)GLKMatrix4 projectionMatrix;
//camera model matrix
@property(nonatomic,assign)GLKMatrix4 cameraModelMatrix;


-(id) initWithFov:(float)fov aspect:(float)aspect near:(float)near far:(float)far;

-(id) initWithLeft:(float)left right:(float)right bottom:(float)bottom top:(float)top near:(float)near far:(float)far;

@end
























