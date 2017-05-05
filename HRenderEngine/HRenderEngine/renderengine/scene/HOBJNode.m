//
//  HOBJNode.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/4.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HOBJNode.h"


@interface HOBJNode()
{
    OBJModelData* _data;
}

@end

@implementation HOBJNode

-(instancetype)initWithOBJFile:(NSString*)objFile
{
  NSString* objFilename = [[NSBundle mainBundle] pathForResource:objFile ofType:@"obj"];
  _data = [[ObjLoader sharedInstance] loadObj:objFilename];
    
    HBaseEffect* shader = [[HBaseEffect alloc] initWithVertexS:@"spriteShader.vsh" fragmentS:@"spriteShader.fsh"];
    
    if((self = [super initWithShader:shader objData:_data]))
    {
        [self loadTexture:[UIImage imageNamed:@"EyesWhite.jpg"]];
    }
    return self;
}

-(void)update:(float)dt
{
 self.rotationY += M_PI *dt/6;
}

@end
