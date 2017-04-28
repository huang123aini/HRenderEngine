//
//  HNode.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HNode.h"

@implementation HNode

-(instancetype)initWithContext:(EAGLContext*)context
{
    self = [super init];
    if (self != nil)
    {
        self.context = context;
        
        self.parent    = nil;
        self.children  = [NSMutableArray new];
        
        self.position  = GLKVector3Make(0.0f, 0.0f, 0.0f);
        self.rotation  = GLKVector3Make(0.0f, 0.0f, 0.0f);
        self.scale     = GLKVector3Make(1.0f, 1.0f, 1.0f);
        self.isVisible = NO;
        
        return self;
    }else
    {
        return nil;
    }

}

-(void)addChild:(HNode*)node
{
    if (node != nil)
    {
        [node setParent:self];
        [self.children addObject:node];
    }else
    {
        NSLog(@"child is nil");
    }
}
-(void)removeChild:(HNode*)node
{
    if (node != nil && self.children != nil)
    {
        [self.children removeObject:node];
    }
}

-(void)update:(float)dt
{
    for (HNode* node in self.children)
    {
        [node update:dt];
    }
}
-(void)draw
{
    for (HNode* node in self.children)
    {
        [node draw];
    }
}

-(void)draw:(GLKMatrix4)projectionMatrix
{
    for (HNode* node in self.children)
    {
        [node draw:projectionMatrix];
    }
}

-(void)dealloc
{
    if (self.children != nil)
    {
        self.children = nil;
    }
}

@end













