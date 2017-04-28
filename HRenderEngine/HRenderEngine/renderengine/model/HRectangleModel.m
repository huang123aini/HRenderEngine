//
//  HRectangleModel.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/28.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HRectangleModel.h"

@implementation HRectangleModel

//-(instancetype)initWithRect:(HRect)rect program:(HProgram*)program
//{
//    self = [super initWithProgram:program];
//    if (self)
//    {
//        self.rect = rect;
//        [self calculateVertices];
//        
//        self.geometry.indices[0] = 0;
//        self.geometry.indices[0] = 1;
//        self.geometry.indices[0] = 2;
//        self.geometry.indices[0] = 0;
//        self.geometry.indices[0] = 2;
//        self.geometry.indices[0] = 3;
//    }
//    return self;
//}
//
//
//-(void) calculateVertices
//{
////    float lowerRightCornerX =  self->_width / 2.0;
////    float lowerRightCornerY = -self->_height / 2.0;
////    float upperRightCornerX = lowerRightCornerX;
////    float upperRightCornerY = self->_height / 2.0;
////    float upperLeftCornerX = -self->_width / 2.0;
////    float upperLeftCornerY = upperRightCornerY;
////    float lowerLeftCornerX = upperLeftCornerX;
////    float lowerLeftCornerY = lowerRightCornerY;
//
//    self.geometry.vertices[0].position = GLKVector3Make(-0.3, -0.3, 1.0);
//    self.geometry.vertices[0].texture = GLKVector2Make(0.0 , 1.0);
//    self.geometry.vertices[0].normal = GLKVector3Make(0.0, 1.0, 0.0);
//    self.geometry.vertices[0].color = GLKVector4Make(0.0f, 1.0f, 0.0f, 1.0f);
//    
//    
//    self.geometry.vertices[1].position = GLKVector3Make(0.3, -0.3, 1.0);
//    self.geometry.vertices[1].texture = GLKVector2Make(1.0, 1.0);
//    self.geometry.vertices[1].normal = GLKVector3Make(0.0, 1.0, 0.0);
//    self.geometry.vertices[1].color = GLKVector4Make(1.0f, 1.0f, 0.0f, 1.0f);
//    
//    self.geometry.vertices[2].position = GLKVector3Make(-0.3, 0.3, 1.0);
//    self.geometry.vertices[2].texture = GLKVector2Make(0.0, 0.0);
//    self.geometry.vertices[2].normal = GLKVector3Make(0.0, 1.0, 0.0);
//    self.geometry.vertices[2].color = GLKVector4Make(0.0f, 0.0f, 1.0f, 1.0f);
//    
//    
//    self.geometry.vertices[3].position = GLKVector3Make(0.3, 0.3, 1.0);
//    self.geometry.vertices[3].texture = GLKVector2Make(1.0, 0.0);
//    self.geometry.vertices[3].normal = GLKVector3Make(0.0, 1.0, 0.0);
//    self.geometry.vertices[3].color = GLKVector4Make(1.0f, 0.0f, 0.0f, 1.0f);
//    
//    
//}

@end
