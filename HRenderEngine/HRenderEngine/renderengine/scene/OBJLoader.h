//
//  OBJLoader.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/4.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OBJLoaderUtils.h"

@interface ObjLoader : NSObject
{
    NSMutableDictionary * _mHandlers;
}

-(id) init;
+(ObjLoader*) sharedInstance;

-(OBJModelData*) loadObj: (NSString*) objFilename;
-(void) parseTrianglesFromListItems: (NSArray*) listItems triangles: (NSMutableArray*) triangles posPoints: (NSArray*) posPoints texPoints: (NSArray*) texPoints nrmPoints: (NSArray* )nrmPoints;
-(OBJModelData*) postProcess : (OBJModelData*) modelData shapes: (NSMutableArray*) shapes vertices: (NSMutableArray*) vertices texUVs: (NSMutableArray*) texUVs Nrms: (NSMutableArray*) Nrms;
-(NSVertex *) packVerticeData: (Vec3*) position uv:(Vec2*) uv nrm: (Vec3*) nrm;

-(Vec3*) _hndVector3: (NSArray *) listItems;
-(Vec2*) _hndVector2: (NSArray *) listItems;

@end
