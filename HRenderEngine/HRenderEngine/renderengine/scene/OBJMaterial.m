//
//  OBJMaterial.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/4.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "OBJMaterial.h"

@implementation OBJSubMaterial

-(instancetype) init
{
    if(self = [super init])
    {
     self.mDiffuseColor = GLKVector3Make(1.0, 1.0, 1.0);
     self.mAmbientColor = GLKVector3Make(.0, .0, .0);
     self.mSpecularColor = GLKVector3Make(.0, .0, .0);
     self.mAlpha = 1.0;
    
     self.mAmbientOn = NO;
     self.mHighlightOn = NO;
     self.mReflectionRayTraceOn = NO;
     self.mGlassRayTraceOn = NO;
     self.mFresnelRayTraceOn = NO;
     self.mRefractionOnFresnelOffRayTraceOn = NO;
     self.mRefractionFresnelRayTraceOn = NO;
     self.mReflectionOnRayTraceOff = NO;
     self.mGlassOnRayTraceOff = NO;
     self.mInvisibleSurfaceShadowOn = NO;
    
     self.mTexAmbient = nil; //  map_Ka
     self.mTexDiffuse = nil; //  map_Kd
     self.mTexSpecularColor = nil;//  map_Ks
     self.mTexSpecularHighlight = nil;//  map_Ns
     self.mTexAlpha = nil;   //  map_d
     self.mTexBump = nil;    //  map_bump bump
     self.mTexDisplacement = nil;    //  disp
     self.mTexStencilDecal = nil;    //  decal
    }
    return self;
}

@end

@implementation OBJMaterial

-(instancetype) init: (NSString*) filename
{
    if (self = [super init])
    {
        self.filename = filename;
        _mSubMaterials = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(OBJSubMaterial*) getSubMaterial: (NSString*) matName
{
    return nil;
}

-(void) setSubMaterial:(NSString*) matName :(OBJSubMaterial*) subMaterial
{
    _mSubMaterials[matName] = subMaterial;
}
@end


@implementation OBJMaterialLoader

+(OBJMaterialLoader *)sharedInstance
{
    static OBJMaterialLoader * sharedSingleton = nil;
    
    @synchronized([OBJMaterialLoader class])
    {
        if(sharedSingleton == nil)
        {
            sharedSingleton = [[self alloc] init];
        }
    }
    return sharedSingleton;
}

-(instancetype) init
{
    
    
    if (self = [super init])
    {
        _mHandlers = [[NSMutableDictionary alloc] init];
        
        [self setInvok:self sel:@selector(_hndVector3Type: :) key:@"Ka"];
        [self setInvok:self sel:@selector(_hndVector3Type: :) key:@"Kd"];
        [self setInvok:self sel:@selector(_hndVector3Type: :) key:@"Ks"];
        [self setInvok:self sel:@selector(_hndFloatType: :) key:@"Ns"];
        [self setInvok:self sel:@selector(_hndFloatType: :) key:@"d"];
        [self setInvok:self sel:@selector(_hndFloatType: :) key:@"Tr"];
        [self setInvok:self sel:@selector(_hndIllumType: :) key:@"illum"];
        
        [self setInvok:self sel:@selector(_hndTexAmbient: :) key:@"map_Ka"];
        [self setInvok:self sel:@selector(_hndTexDiffuse: material:) key:@"map_Kd"];
        [self setInvok:self sel:@selector(_hndTexSpecularColor: material:) key:@"map_Ks"];
        [self setInvok:self sel:@selector(_hndTexSpecularHighlight: material:) key:@"map_Ns"];
        [self setInvok:self sel:@selector(_hndTexAlpha: material:) key:@"map_d"];
        [self setInvok:self sel:@selector(_hndTexBump: material:) key:@"map_bump"];
        [self setInvok:self sel:@selector(_hndTexBump: material:) key:@"bump"];
        [self setInvok:self sel:@selector(_hndTexDisplacement: material:) key:@"disp"];
        [self setInvok:self sel:@selector(_hndTexStencilDecal: material:) key:@"decal"];
        

    }
    return self;
}

-(OBJMaterial*) loadMaterial: (NSString*) filename
{
    NSString* text = [NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [text componentsSeparatedByString:@"\n"];
    
    OBJMaterial   * material = [[OBJMaterial alloc] init: filename];
    OBJSubMaterial* curSubMaterial;
    
    for (NSString* str in lines)
    {
        NSString * _str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSArray* _tmpItems = [_str componentsSeparatedByString:@" "];
        NSMutableArray* listItems = [[NSMutableArray alloc] init];
        for (NSString* item in _tmpItems)
        {
            if (![item isEqualToString: @""])
            {
                [listItems addObject:item];
            }
        }
        if ([listItems count] <= 1) continue;
        NSString* prefix = listItems[0];
        //newmtl Material__52
        if ([prefix isEqualToString: @"newmtl"])
        {
            curSubMaterial = [[OBJSubMaterial alloc] init];
            NSString* key = listItems[1];
            [material setSubMaterial:key : curSubMaterial];
            continue;
        }
        
        NSInvocation* invocation = [self getInvok: prefix];
        if (invocation != nil)
        {
            [invocation setArgument:&listItems atIndex:2];
            [invocation setArgument:&curSubMaterial  atIndex:3];
            [invocation invoke];
        }
        
    }
    return material;
}

-(void)setInvok:(id)target sel:(SEL)sel key:(id)key
{
    if(!target) return;
    NSMethodSignature *sig = [[target class] instanceMethodSignatureForSelector: sel];
    NSInvocation *invo=[NSInvocation invocationWithMethodSignature:sig];
    [invo setTarget:target];
    [invo setSelector:sel];
    [_mHandlers setValue:invo forKey:key];//以key的形式保存invo
}

-(NSInvocation*) getInvok: (NSString*) hndName
{
    return [_mHandlers objectForKey:hndName];
}

-(void) _hndVector3Type: (NSMutableArray*) args :(OBJSubMaterial*) material
{
    if ([args[0] isEqualToString: @"Ka"])
    {
        material.mAmbientColor = GLKVector3Make([args[1] floatValue], [args[2] floatValue], [args[3] floatValue]);
    }
    else if ([args[0] isEqualToString: @"Kd"])
    {
        material.mDiffuseColor = GLKVector3Make([args[1] floatValue], [args[2] floatValue], [args[3] floatValue]);
    }
    else if ([args[0] isEqualToString: @"Ks"])
    {
        material.mSpecularColor = GLKVector3Make([args[1] floatValue], [args[2] floatValue], [args[3] floatValue]);
    }
    else
    {
        NSLog(@"undefined key %@!!!!!!!!!!!!!", args[0]);
    }
}

-(void) _hndFloatType: (NSMutableArray*) args :(OBJSubMaterial*) material
{
    if ([args[0] isEqualToString: @"d"] || [args[0] isEqualToString: @"Tr"])
    {
        material.mAlpha = [args[1] floatValue];
    }
    else if ([args[0] isEqualToString: @"Ns"])
    {
        material.mSpecularIntensity = [args[1] floatValue];
    }
    else
    {
        NSLog(@"undefined key %@!!!!!!!!!!!!!", args[0]);
    }
}

-(void) _hndIllumType: (NSMutableArray*) args :(OBJSubMaterial*) material
{
    GLuint illumType = [args[1] intValue];
    switch(illumType)
    {
        case 0:
            material.mAmbientOff = YES; break;
        case 1:
            material.mAmbientOn = YES; break;
        case 2:
            material.mHighlightOn = YES; break;
        case 3:
            material.mReflectionRayTraceOn = YES; break;
        case 4:
            material.mReflectionOnRayTraceOff = YES; break;
        case 5:
            material.mFresnelRayTraceOn = YES; break;
        case 6:
            material.mRefractionOnFresnelOffRayTraceOn = YES; break;
        case 7:
            material.mRefractionFresnelRayTraceOn = YES; break;
        case 8:
            material.mReflectionOnRayTraceOff = YES; break;
        case 9:
            material.mGlassOnRayTraceOff = YES; break;
        case 10:
            material.mInvisibleSurfaceShadowOn = YES; break;
    }
}

-(void) _hndTexAmbient: (NSMutableArray*) args  :(OBJSubMaterial*) material
{
    material.mTexAmbient = args[1];
}
-(void) _hndTexDiffuse: (NSMutableArray*) args material: (OBJSubMaterial*) material
{
    material.mTexDiffuse = args[1];
}
-(void) _hndTexSpecularColor: (NSMutableArray*) args  material: (OBJSubMaterial*) material
{
    material.mTexSpecularColor = args[1];
}
-(void) _hndTexSpecularHighlight: (NSMutableArray*) args  material: (OBJSubMaterial*) material
{
    material.mTexSpecularHighlight = args[1];
}
-(void) _hndTexAlpha: (NSMutableArray*) args material: (OBJSubMaterial*) material
{
    material.mTexAlpha = args[1];
}
-(void) _hndTexBump: (NSMutableArray*) args material: (OBJSubMaterial*) material
{
    material.mTexBump = args[1];
}
-(void) _hndTexDisplacement: (NSMutableArray*) args material: (OBJSubMaterial*) material
{
    material.mTexDisplacement = args[1];
}
-(void) _hndTexStencilDecal: (NSMutableArray*) args material: (OBJSubMaterial*) material
{
    material.mTexStencilDecal = args[1];
}

@end

