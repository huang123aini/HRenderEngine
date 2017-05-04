//
//  HCubeT.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/3.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HCubeT.h"

@implementation HCubeT

-(instancetype)init
{
    
    const static VertexTexture Vertices[] =
    {
        // Front
        {{1, -1, 1}, {1, 0, 0, 1}, {1, 0}}, // 0
        {{1, 1, 1}, {0, 1, 0, 1}, {1, 1}}, // 1
        {{-1, 1, 1}, {0, 0, 1, 1}, {0, 1}}, // 2
        {{-1, -1, 1}, {0, 0, 0, 1}, {0, 0}}, // 3
        
        // Back
        {{-1, -1, -1}, {0, 0, 1, 1}, {1, 0}}, // 4
        {{-1, 1, -1}, {0, 1, 0, 1}, {1, 1}}, // 5
        {{1, 1, -1}, {1, 0, 0, 1}, {0, 1}}, // 6
        {{1, -1, -1}, {0, 0, 0, 1}, {0, 0}}, // 7
        
        // Left
        {{-1, -1, 1}, {1, 0, 0, 1}, {1, 0}}, // 8
        {{-1, 1, 1}, {0, 1, 0, 1}, {1, 1}}, // 9
        {{-1, 1, -1}, {0, 0, 1, 1}, {0, 1}}, // 10
        {{-1, -1, -1}, {0, 0, 0, 1}, {0, 0}}, // 11
        
        // Right
        {{1, -1, -1}, {1, 0, 0, 1}, {1, 0}}, // 12
        {{1, 1, -1}, {0, 1, 0, 1}, {1, 1}}, // 13
        {{1, 1, 1}, {0, 0, 1, 1}, {0, 1}}, // 14
        {{1, -1, 1}, {0, 0, 0, 1}, {0, 0}}, // 15
        
        // Top
        {{1, 1, 1}, {1, 1, 1, 1}, {1, 0}}, // 16
        {{1, 1, -1}, {1, 1, 1, 1}, {1, 1}}, // 17
        {{-1, 1, -1}, {1, 1, 1, 1}, {0, 1}}, // 18
        {{-1, 1, 1}, {1, 1, 1, 1}, {0, 0}}, // 19
        
        // Bottom
        {{1, -1, -1}, {1, 0, 0, 1}, {1, 0}}, // 20
        {{1, -1, 1}, {0, 1, 0, 1}, {1, 1}}, // 21
        {{-1, -1, 1}, {0, 0, 1, 1}, {0, 1}}, // 22
        {{-1, -1, -1}, {0, 0, 0, 1}, {0, 0}}, // 23
    };
    
    const GLubyte indices[] =
    {
        // Front
        0, 1, 2,
        2, 3, 0,
        // Back
        4, 5, 6,
        6, 7, 4,
        // Left
        8, 9, 10,
        10, 11, 8,
        // Right
        12, 13, 14,
        14, 15, 12,
        // Top
        16, 17, 18,
        18, 19, 16,
        // Bottom
        20, 21, 22,
        22, 23, 20
    };
    
    HBaseEffect* shader = [[HBaseEffect alloc] initWithVertexS:@"spriteShader.vsh" fragmentS:@"spriteShader.fsh"];
    
    if((self = [super initWithShader:shader verticesTexture:(VertexTexture*) Vertices vertexCount:(sizeof Vertices)/(sizeof Vertices[0]) indices:(GLubyte*)indices indexCount:sizeof(indices)/sizeof(indices[0])]))
    {
      [self loadTexture:[UIImage imageNamed:@"lemur.png"]];
    }
    return self;
}

-(void)update:(float)dt
{
   self.rotationY += M_PI *dt/8;
}
@end
