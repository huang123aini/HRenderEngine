//
//  HDownLoadUtils.h
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/19.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^downloadBlockParam)(NSString *);

@interface HDownLoadUtils : NSObject<NSURLConnectionDataDelegate>
{
    downloadBlockParam downloadblock;
    NSString * fileName;
}


- (void)downloadWithUrl:(NSString *)urlPath;

//the download is completed callback
- (void)setDownloadBlockParam:(downloadBlockParam)block;

+ (void)deleteFile:(NSString *)fileName;

//check the integrity of the file 
+ (BOOL)checkFileNameIntegrated:(NSString *)fileName;

//the total length of the download file
@property (nonatomic, assign) NSInteger totalLength;

//the total length of download
@property (nonatomic, assign) NSInteger currentLength;

//file handle, used to implent the file storage
@property (nonatomic, strong) NSFileHandle *writeHandle;


@end
