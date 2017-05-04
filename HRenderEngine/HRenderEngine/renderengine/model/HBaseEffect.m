//
//  HBaseEffect.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/3.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HBaseEffect.h"

@implementation HBaseEffect
{
    GLuint _program;
    GLuint _uModelViewMatrix;
    GLuint _uProjectionMatrix;
    GLuint _uSampler;
    GLuint _uLightColor;
    GLuint _uLightAmbientIntensity;
    GLuint _uLightDiffuseIntensity;
    GLuint _uLightDirection;
    GLuint _uMatSpecularIntensity;
    GLuint _uShininess;
    
}

- (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType
{
    NSString* shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:nil];
    NSError* error;
    NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    if (!shaderString)
    {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    
    GLuint shaderHandle = glCreateShader(shaderType);
    
    const char * shaderStringUTF8 = [shaderString UTF8String];
    int shaderStringLength =(int)[shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    
    glCompileShader(shaderHandle);
    
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE)
    {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    return shaderHandle;
}

- (void)compileVertexShader:(NSString *)vertexShader
             fragmentShader:(NSString *)fragmentShader
{
    GLuint vertexShaderName = [self compileShader:vertexShader
                                         withType:GL_VERTEX_SHADER];
    GLuint fragmentShaderName = [self compileShader:fragmentShader
                                           withType:GL_FRAGMENT_SHADER];
    
    _program = glCreateProgram();
    glAttachShader(_program, vertexShaderName);
    glAttachShader(_program, fragmentShaderName);
    
    glBindAttribLocation(_program, GLKVertexAttribPosition,  "aPosition");
    glBindAttribLocation(_program, GLKVertexAttribColor,     "aColor");
    glBindAttribLocation(_program, GLKVertexAttribTexCoord0, "aTexCoord");
    glBindAttribLocation(_program, GLKVertexAttribNormal,    "aNormal");
    
    glLinkProgram(_program);
    
    self.modelViewMatrix = GLKMatrix4Identity;
    
    _uModelViewMatrix        = glGetUniformLocation(_program, "uModelViewMatrix");
    _uProjectionMatrix       = glGetUniformLocation(_program, "uProjectionMatrix");
    _uSampler                = glGetUniformLocation(_program, "uSampler");
    
    _uLightColor             = glGetUniformLocation(_program, "u_Light.Color");
    _uLightAmbientIntensity  = glGetUniformLocation(_program, "u_Light.AmbientIntensity");
    _uLightDiffuseIntensity  = glGetUniformLocation(_program, "u_Light.DiffuseIntensity");
    _uLightDirection         = glGetUniformLocation(_program, "u_Light.Direction");
    _uMatSpecularIntensity   = glGetUniformLocation(_program, "u_MatSpecularIntensity");
    _uShininess              = glGetUniformLocation(_program, "u_Shininess");
    
    GLint linkSuccess;
    glGetProgramiv(_program, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE)
    {
        GLchar messages[256];
        glGetProgramInfoLog(_program, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
}

- (void)prepareToDraw
{
    
    glUseProgram(_program);
    glUniformMatrix4fv(_uModelViewMatrix, 1, 0, self.modelViewMatrix.m);
    glUniformMatrix4fv(_uProjectionMatrix, 1, 0, self.projectionMatrix.m);
    
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, self.texture);
    glUniform1i(_uSampler, 1);
    
    glUniform3f(_uLightColor, self.lightColor.x,self.lightColor.y,self.lightColor.z);
    glUniform1f(_uLightAmbientIntensity, self.lightIntensity);
    
    glUniform3f(_uLightDirection, self.lightDirection.x, self.lightDirection.y, self.lightDirection.z);
    glUniform1f(_uLightDiffuseIntensity, self.lightDiffuseIntensity);
    
    glUniform1f(_uMatSpecularIntensity, self.MatSpecularIntensity);
    glUniform1f(_uShininess, self.Shininess);
    
}

- (instancetype)initWithVertexS:(NSString *)vertexShader fragmentS:
(NSString *)fragmentShader
{
    if ((self = [super init]))
    {
        [self compileVertexShader:vertexShader fragmentShader:fragmentShader];
       
        self.lightColor = GLKVector3Make(1, 1, 1);
        self.lightIntensity = 1.0;
        
        self.lightDirection = GLKVector3Normalize(GLKVector3Make(0, 1, -1));
        self.lightDiffuseIntensity = 1.0;
        
        self.MatSpecularIntensity = 1.0;
        self.Shininess = 128.0;
    }
    return self;
}

@end
