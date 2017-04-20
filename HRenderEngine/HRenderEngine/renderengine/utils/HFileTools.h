//
//  HFileTools.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/19.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFileTools : NSObject

//copy files to the sandbox
+ (void)copyFileToPath:(NSString *)fileName;

//Asynchronous download file to the local path (for small file download)
+ (void)downloadFile:(NSString *)urlName block:(void (^)(NSString *))block;

//to determine whether a sandbox version and the version info is equal
+ (void)checkBundleVersion:(void (^)(void))isEqual noEqual:(void (^)(void))noEqual;

//read the local plist to array
+ (NSMutableArray *)readPlistFromLocal:(NSString *)filePath;

// int value to watch time
+ (NSString*)TimeformatFromSeconds:(int)seconds;

//create folder
+ (NSString *)createFilePathWithName:(NSString *)filePathName;

/**
 * 将gif解压成序列帧和帧间隔, 返回的一个数组里面包含两个数组
 * 1、序列帧 2、帧间隔
 */
+ (NSMutableArray *)decodeGifWithGifPath:(NSString *)path;

@end
