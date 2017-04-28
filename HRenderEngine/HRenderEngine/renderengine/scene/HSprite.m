//
//  HSprite.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HSprite.h"
#import "HSpriteModel.h"
#import "HSpriteProgram.h"

@interface HSprite()
{
 
}
@end

@implementation HSprite

-(instancetype)initWithImage:(UIImage*)image
{
    if (self = [super init])
    {
       
        self.texture = [[HTexture alloc] init];
        [self.texture setupTextureWithImage:image TextureFilter:H_LINEAR];
        
        self.model = [[HSpriteModel alloc] init];
        self.program = [[HSpriteProgram alloc] init];
        
        return self;
    }
    return nil;
}

-(void)update:(float)dt
{
    [self.model setupGLData:self.program];
}

-(void)setSpriteRect:(HRect)rect
{
  //  [self.model setSpriteRect:rect];
}

-(void)draw
{
    if (self.model == nil || self.texture == nil || self.program == nil)
    {
        return;
    }
    
    [self.program useProgram];
    
    [self.texture bindTexture];
    
    [self.program bindAttributesAndUniforms];
    
    [self.model setupGLData:self.program];
    
    [self.program updateMVPMatrix:GLKMatrix4Identity];
    
    glDrawElements(GL_TRIANGLES, self.model.indexCount, GL_UNSIGNED_SHORT, 0);
    
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    
    glDisableVertexAttribArray(self.program.aPosition);
    glDisableVertexAttribArray(self.program.aTexCoord);
    glDisableVertexAttribArray(self.program.aVertexColor);
    
    
}

-(void)draw:(GLKMatrix4)projectionMatrix
{
    if (self.model == nil || self.texture == nil || self.program == nil)
    {
        return;
    }
    
    [self.program useProgram];
    
    [self.texture bindTexture];
    
    [self.program bindAttributesAndUniforms];
    
    [self.model setupGLData:self.program];
    
    [self.program updateMVPMatrix:projectionMatrix];
    
    glDrawElements(GL_TRIANGLES, self.model.indexCount, GL_UNSIGNED_SHORT, 0);
    
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    
    glDisableVertexAttribArray(self.program.aPosition);
    glDisableVertexAttribArray(self.program.aTexCoord);
    glDisableVertexAttribArray(self.program.aVertexColor);
    
    
}

@end
