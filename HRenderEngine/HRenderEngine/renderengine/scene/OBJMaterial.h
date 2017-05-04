//
//  OBJMaterial.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/4.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>


@interface OBJSubMaterial : NSObject

-(instancetype)init;

@property GLKVector3 mDiffuseColor;
@property GLKVector3 mAmbientColor;
@property GLKVector3 mSpecularColor;
@property GLfloat    mAlpha;
@property GLfloat    mSpecularIntensity;

@property BOOL       mAmbientOff;
@property BOOL       mAmbientOn;
@property BOOL       mHighlightOn;
@property BOOL       mReflectionRayTraceOn;
@property BOOL       mGlassRayTraceOn;
@property BOOL       mFresnelRayTraceOn;
@property BOOL       mRefractionOnFresnelOffRayTraceOn;
@property BOOL       mRefractionFresnelRayTraceOn;
@property BOOL       mReflectionOnRayTraceOff;
@property BOOL       mGlassOnRayTraceOff;
@property BOOL       mInvisibleSurfaceShadowOn;

@property(strong, nonatomic) NSString* mTexAmbient; //  map_Ka
@property(strong, nonatomic) NSString* mTexDiffuse; //  map_Kd
@property(strong, nonatomic) NSString* mTexSpecularColor;//  map_Ks
@property(strong, nonatomic) NSString* mTexSpecularHighlight;//  map_Ns
@property(strong, nonatomic) NSString* mTexAlpha;   //  map_d
@property(strong, nonatomic) NSString* mTexBump;    //  map_bump bump
@property(strong, nonatomic) NSString* mTexDisplacement;    //  disp
@property(strong, nonatomic) NSString* mTexStencilDecal;    //  decal

@end

@interface OBJMaterial : NSObject
{
    NSMutableDictionary * _mSubMaterials;
}
@property (strong, nonatomic) NSString * filename;

-(id) init:(NSString*) filename;
-(OBJSubMaterial*) getSubMaterial: (NSString*) matName;
-(void) setSubMaterial:(NSString*) matName :(OBJSubMaterial*) subMaterial;

@end


@interface OBJMaterialLoader : NSObject
{
    NSMutableDictionary * _mHandlers;
}

-(instancetype) init;
+(OBJMaterialLoader*) sharedInstance;

-(OBJMaterial*) loadMaterial: (NSString*) filename;
-(void)setInvok:(id)target sel:(SEL)sel key:(id)key;
-(NSInvocation*) getInvok: (NSString*) hndName;

-(void) _hndVector3Type: (NSMutableArray*) args :(OBJSubMaterial*) material;
-(void) _hndFloatType: (NSMutableArray*) args :(OBJSubMaterial*) material;
-(void) _hndIllumType: (NSMutableArray*) args :(OBJSubMaterial*) material;

-(void) _hndTexAmbient: (NSMutableArray*) args :(OBJSubMaterial*) material;
-(void) _hndTexDiffuse: (NSMutableArray*) args material: (OBJSubMaterial*) material;
-(void) _hndTexSpecularColor: (NSMutableArray*) args material: (OBJSubMaterial*) material;
-(void) _hndTexSpecularHighlight: (NSMutableArray*) args material: (OBJSubMaterial*) material;
-(void) _hndTexAlpha: (NSMutableArray*) args material: (OBJSubMaterial*) material;
-(void) _hndTexBump: (NSMutableArray*) args material: (OBJSubMaterial*) material;
-(void) _hndTexDisplacement: (NSMutableArray*) args material: (OBJSubMaterial*) material;
-(void) _hndTexStencilDecal: (NSMutableArray*) args material: (OBJSubMaterial*) material;

@end

