//
//  HRect.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/19.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "HSize.h"
@interface HRect : NSObject

@property(nonatomic,assign)GLKVector2 origin;
@property(nonatomic,assign)HSize* size;

@end
