//
//  HProgram.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

/**
 *Note: attributes and uniforms keep the same names in shaders with the program
 *{aPosition  aTexCoord uModelViewProjectionMatrix}
 */

#import <Foundation/Foundation.h>

@interface HProgram : NSObject

@property(nonatomic,assign)GLuint program;
/*Base attributes and uniforms : vertex position ,texture coord, space matrix */
@property(nonatomic,assign)GLuint aPosition;
@property(nonatomic,assign)GLuint aVertexColor; //vertex Color
@property(nonatomic,assign)GLuint aTexCoord;
@property(nonatomic,assign)GLuint uModelViewProjectionMatrix;

- (void)loadShaders:(NSString *)vertShader FragShader:(NSString *)fragShader;
- (void)useProgram;

-(void)updateMVPMatrix:(GLKMatrix4)mvpMatrix; //update mvp matrix
-(void)setupAttributesAndUniforms;
-(void)bindAttributesAndUniforms;
@end
