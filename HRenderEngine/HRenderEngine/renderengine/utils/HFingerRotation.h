//
//  HFingerRotation.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFingerRotation : NSObject

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

+ (instancetype)fingerRotation;
+ (CGFloat)degress;
- (void)clean;

@end
