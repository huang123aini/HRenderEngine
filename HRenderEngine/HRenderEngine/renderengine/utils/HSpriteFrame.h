//
//  HSpriteFrame.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/19.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRect.h"

@interface HSpriteFrame : NSObject

@property(nonatomic,strong)HRect* rectInPoints;
@property(nonatomic,strong)HRect* rectInPixels;

-(void)setPointsRect:(HRect*)rect;
-(void)setPixelsRect:(HRect*)rect;

@end
