//
//  HGLKViewController.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/18.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "HDistortionRender.h"

#import "HGLNormalModel.h"
#import "HGLVRModel.h"
#import "HVideoTexture.h"


#import "HCameraMatrix.h"


#import "HTexture.h"
#import "HObjectProgram.h"



typedef NS_ENUM(NSUInteger,HVideoType)
{
    HVideoTypeNormal,
    HVideoTypeVR,
};

typedef NS_ENUM(NSUInteger,HDisplayMode)
{
    HDisplayModeNormal,
    HDisplayModeGlass,
};


@interface HGLKViewController : GLKViewController

@property(nonatomic, assign)int fps;

@property(nonatomic,strong)HDistortionRender *distortionRender;

@property(nonatomic,strong)HGLNormalModel* normalModel;

@property(nonatomic,strong)HVideoTexture* videoTexture;


@property(nonatomic,strong)HCameraMatrix* vrMatrix;


@property(nonatomic,strong)HObjectProgram* objectProgram;
@property(nonatomic,strong)HTexture* objectTexture;


@end
































