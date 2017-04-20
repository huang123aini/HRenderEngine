//
//  HDistortionModel.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

/**
 * modelType indexBuffer vertexBuffer  indexCount
 */

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, SGDistortionModelType)
{
    HDistortionModelTypeLeft,
    HDistortionModelTypeRight,
};

@interface HDistortionModel : NSObject

+ (instancetype)modelWithModelType:(SGDistortionModelType)modelType;

@property (nonatomic, assign, readonly) SGDistortionModelType modelType;
@property (nonatomic, assign) GLint indexBuffer;
@property (nonatomic, assign) GLint vertexBuffer;
@property (nonatomic, assign) int   indexCount;

@end
