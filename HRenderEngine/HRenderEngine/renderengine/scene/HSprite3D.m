//
//  HSprite3D.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HSprite3D.h"
#import "HGLVRModel.h"
#import "HObjectProgram.h"


@interface HSprite3D()


@property(nonatomic,strong)HGLVRModel* vrModel;
@property(nonatomic,strong)HObjectProgram* objectProgram;
@property(nonatomic,strong)HTexture* objectTexture;


@end

@implementation HSprite3D

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

-(void)update:(float)dt
{
    [self.model setupGLData:self.program];
}


-(void)draw:(GLKMatrix4)projectionMatrix
{
    if (self.model == nil || self.texture == nil || self.program == nil)
    {
        return;
    }
    
    [self.program useProgram];
    
    [self.texture bindTexture];
    
    [self.program bindAttributesAndUniforms];
    
    [self.model setupGLData:self.program];
    
    [self.program updateMVPMatrix:projectionMatrix];
    
    glDrawElements(GL_TRIANGLES, self.model.indexCount, GL_UNSIGNED_SHORT, 0);
    
}

-(void)dealloc
{
    if(self.program)
    {
        self.program = nil;
    }
    
    if (self.texture)
    {
        self.texture = nil;
    }
    
    if (self.model)
    {
        self.model = nil;
    }
}

@end
