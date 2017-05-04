//
//  HOBJNode.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/4.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HRenderObject.h"
#import "OBJLoader.h"

@interface HOBJNode : HRenderObject

-(instancetype)initWithOBJFile:(NSString*)objFile;

@end
