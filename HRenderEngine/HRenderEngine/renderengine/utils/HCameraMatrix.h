//
//  HCameraMatrix.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

/**
 *Note: to update camera matrix
 */

#import <Foundation/Foundation.h>

#import "HFingerRotation.h"

@interface HCameraMatrix : NSObject

- (BOOL)singleMatrixWithSize:(CGSize)size matrix:(GLKMatrix4 *)matrix fingerRotation:(HFingerRotation *)fingerRotation;

- (BOOL)doubleMatrixWithSize:(CGSize)size leftMatrix:(GLKMatrix4 *)leftMatrix rightMatrix:(GLKMatrix4 *)rightMatrix;

@end
