//
//  HSensors.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSensors : NSObject

@property (nonatomic, assign, readonly, getter=isReady) BOOL ready;

- (void)start;
- (void)stop;
- (GLKMatrix4)modelView;

@end
