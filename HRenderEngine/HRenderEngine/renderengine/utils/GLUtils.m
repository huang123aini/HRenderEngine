//
//  GLUtils.m
//  HEngine_3DVR
//
//  Created by 黄世平 on 17/4/12.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "GLUtils.h"

@implementation GLUtils

void swapt(float* width, float *height)
{
    float temp = *width;
    if((*width)>(*height))
    {
        return;
    }else
    {
        (*width) = (*height);
        (*height) = temp;
    }
}

+ (GLuint)loadShader:(GLenum)type withFilepath:(NSString *)sharderFilepath
{
    NSError * error;
    
    NSString * sharderString = [NSString stringWithContentsOfFile:sharderFilepath encoding:NSUTF8StringEncoding error:&error];
    
    if (!sharderString)
    {
        HLog(@"Error: loading shader file: %@ %@", sharderFilepath, error.localizedDescription);
        
        return 0;
    }
    
    //1.create shader
    GLuint shader = glCreateShader(type);
    
    if (shader == 0)
    {
        HLog(@"Error:fail to create shader");
        return 0;
    }
    
    //2.load shader source
    const char * shaderStringUTF8 = [sharderString UTF8String];
    GLint shaderStringLength = (GLint)[sharderString length];
    glShaderSource(shader, 1, &shaderStringUTF8, &shaderStringLength);
    
    //3. compile shader
    glCompileShader(shader);
    
    //4. check compile state
    GLint compiled = 0;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &compiled);
    
    if (!compiled)
    {
        GLint infoLen = 0;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &infoLen);
        
        if (infoLen > 1)
        {
            char * infoLog = malloc(sizeof(char) *infoLen);
            glGetShaderInfoLog(shader, infoLen, NULL, infoLog);
            HLog(@"Error compiling shader:\n%s\n", infoLog);
            
            free(infoLog);
        }
        
        glDeleteShader(shader);
        
        return 0;
    }
    
    return shader;
}

+ (GLuint)compileShaders:(NSString *)shaderVertex shaderFragment:(NSString *)shaderFragment
{
    GLuint vertShader, fragShader;
    
    // Create and compile vertex shader.
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:shaderVertex])
    {
        HLog(@"Failed to compile vertex shader :Shader Name is:%@",shaderVertex);
        return NO;
    }
    
    // Create and compile fragment shader.
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:shaderFragment])
    {
        HLog(@"Failed to compile fragment shader");
        return NO;
    }
    
    // 连接vertex和fragment shader成一个完整的program
    
    GLuint _glProgram = glCreateProgram();
    glAttachShader(_glProgram, vertShader);
    glAttachShader(_glProgram, fragShader);
    
    // Link program.
    if (![self linkProgram:_glProgram])
    {
        HLog(@"Failed to link program: %d", _glProgram);
        
        if (vertShader)
        {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader)
        {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (_glProgram)
        {
            glDeleteProgram(_glProgram);
            _glProgram = 0;
        }
        
        return NO;
    }
    
    // Release vertex and fragment shaders.
    if (vertShader)
    {
        glDetachShader(_glProgram, vertShader);
        glDeleteShader(vertShader);
    }
    if (fragShader)
    {
        glDetachShader(_glProgram, fragShader);
        glDeleteShader(fragShader);
    }
    
    return _glProgram;
}

+ (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source)
    {
        HLog(@"Failed to load vertex shader");
        return NO;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        HLog(@"Shader compile log:\n%s", log);
        free(log);
    }
    
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0)
    {
        
        GLint logLength;
        glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
        if (logLength <= 0)
        {
            GLchar *log = (GLchar *)malloc(logLength);
            glGetShaderInfoLog(*shader, logLength, &logLength, log);
            HLog(@"Shader compile log:\n%s", log);
            free(log);
        }
        
        glDeleteShader(*shader);
        return NO;
    }
    
    return YES;
}

+ (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
    glLinkProgram(prog);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        HLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0)
    {
        return NO;
    }
    
    return YES;
}

#pragma mark ---------about texture--------
+ (GLuint)setupTextureWithImage:(UIImage *)image TextureFilter:(HTextureFilter) textureFilter
{
    CGImageRef cgImageRef = [image CGImage];
    if (!cgImageRef)
    {
        HLog(@"Fail to load image :%@",image);
        exit(1);
    }
    
    GLuint width = [self NextPot:(GLuint)CGImageGetWidth(cgImageRef)];
    GLuint height = [self NextPot:(GLuint)CGImageGetHeight(cgImageRef)];
    CGRect rect = CGRectMake(0, 0, width, height);
    
    GLubyte *imageData = (GLubyte *) calloc(width*height*4, sizeof(GLubyte));
    CGContextRef context = CGBitmapContextCreate(imageData, width, height, 8, width * 4, CGImageGetColorSpace(cgImageRef), kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextTranslateCTM(context, 0, height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextDrawImage(context, rect, cgImageRef);
    CGContextRelease(context);
    
    GLuint texture_id;
    glGenTextures(1, &texture_id);
    glBindTexture(GL_TEXTURE_2D, texture_id);
    
    [self setGLTextureMinFilter:textureFilter];
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
    glGenerateMipmap(GL_TEXTURE_2D);
    
    glBindTexture(GL_TEXTURE_2D, 0);
    
    free(imageData);
    
    return texture_id;

}

+ (void)setGLTextureMinFilter:(HTextureFilter)textureFilter
{
    textureFilter = H_LINEAR_MIPMAP_LINEAR;
    
    switch (textureFilter)
    {
        case H_LINEAR:
            glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
            break;
        case H_NEAREST:
            glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
            break;
        case H_LINEAR_MIPMAP_LINEAR:
            glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
            break;
        case H_LINEAR_MIPMAP_NEAREST:
            glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST);
            break;
        case H_NEAREST_MIPMAP_LINEAR:
            glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST_MIPMAP_LINEAR);
            break;
        case H_NEAREST_MIPMAP_NEAREST:
            glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST_MIPMAP_NEAREST);
            break;
        default:
            break;
    }
}

+ (int)NextPot:(int)n
{
    n--;
    n |= n >> 1; n |= n >> 2;
    n |= n >> 4; n |= n >> 8;
    n |= n >> 16;
    n++;
    
    return n;
}

@end
