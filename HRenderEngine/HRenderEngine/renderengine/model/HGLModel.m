//
//  HModel.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HGLModel.h"

@implementation HGLModel

+(instancetype)model
{
    return [[self alloc] init];
}

-(instancetype)init
{
    if (self = [super init])
    {
        [self setupModel];
    }
    return self;
}

-(void)setupModel
{
    
}


-(void)setupGLData:(HProgram*)program
{
    
}

-(void)dealloc
{
    
}

@end
