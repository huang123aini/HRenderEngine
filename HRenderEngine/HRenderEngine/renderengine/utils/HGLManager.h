//
//  HGLManager.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/19.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface HGLManager : NSObject

SingletonH(HGLManager)

@property(nonatomic,strong)GLKView* renderView; //Current render glview

@end
