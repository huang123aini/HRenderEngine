//
//  HDownLoadUtils.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/19.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HDownLoadUtils.h"
#import "HFileTools.h"

// get CECHES
#define CECHES [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

@implementation HDownLoadUtils

- (void)downloadWithUrl:(NSString *)urlPath
{
    NSURL *url = [NSURL URLWithString:urlPath];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}


//request is faild
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    HLog(@"failed to download files:%@",error);
    
    [HDownLoadUtils deleteFile:fileName];
}

//it will be called when receive the server's response
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //file path
    fileName = [[HFileTools createFilePathWithName:@"Downloaded"] stringByAppendingPathComponent:response.suggestedFilename];
    
    //create an empty file in sandbox
    NSFileManager* mgr = [NSFileManager defaultManager];
    [mgr createFileAtPath:fileName contents:nil attributes:nil];
    
    //create a file handle
    self.writeHandle = [NSFileHandle fileHandleForWritingAtPath:fileName];
    
    //get the total size of the file
    self.totalLength = response.expectedContentLength;
    
    //record the total size to the local file
    [self setTotalSizeToLocal];
}

- (void)setTotalSizeToLocal
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:self.totalLength forKey:[fileName lastPathComponent]];
    
    [userDefaults synchronize];
}

- (void)setCurrentSizeToLocal
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *tempName = [NSString stringWithFormat:@"%@Temp",[fileName lastPathComponent]];
    [userDefaults setInteger:self.currentLength forKey:tempName];
    
    [userDefaults synchronize];
}

+ (BOOL)checkFileNameIntegrated:(NSString *)fileName;
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int totalSize = [[userDefaults objectForKey:[fileName lastPathComponent]] intValue];
    
    NSString *tempName = [NSString stringWithFormat:@"%@Temp",fileName];
    int downLoadsize = [[userDefaults objectForKey:[tempName lastPathComponent]] intValue];
    
    if (totalSize == downLoadsize)
    {
        HLog(@"文件完整");
        return YES;
    }
    
    HLog(@"文件缺失");
    [userDefaults removeObjectForKey:[fileName lastPathComponent]];
    [userDefaults removeObjectForKey:[tempName lastPathComponent]];
    
    [userDefaults synchronize];
    
    return NO;
}

/**
 *  当接收到服务器返回的实体数据时调用（具体内容，这个方法可能会被调用多次）
 *
 *  @param data       这次返回的数据
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // 移动到文件的最后面
    [self.writeHandle seekToEndOfFile];
    // 将数据写入沙盒
    [self.writeHandle writeData:data];
    [self.writeHandle synchronizeFile];
    
    // 累计写入文件的长度
    self.currentLength += data.length;
    
    [self setCurrentSizeToLocal];
    // 下载进度
    HLog(@"-----------%f",(double)self.currentLength / self.totalLength);
}

/**
 *  加载完毕后调用（服务器的数据已经完全返回后）
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.currentLength = 0;
    self.totalLength = 0;
    
    // 关闭文件
    [self.writeHandle closeFile];
    self.writeHandle = nil;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        downloadblock(fileName);
    });
}

- (void)setDownloadBlockParam:(downloadBlockParam)block
{
    downloadblock = block;
}

- (void)isFileCompleted
{
    if ((double)self.currentLength / self.totalLength <= 1.0)
    {
        [HDownLoadUtils deleteFile:fileName];
    }
}

// 删除沙盒里的文件
+ (void)deleteFile:(NSString *)fileName
{
    NSFileManager* file = [NSFileManager defaultManager];
    
    //文件名
    BOOL blHave = [file fileExistsAtPath:fileName];
    if (!blHave)
    {
        HLog(@"no exist file!");
        return ;
    }else
    {
        BOOL blDele= [file removeItemAtPath:fileName error:nil];
        if (blDele)
        {
            HLog(@"dele success");
        }else
        {
            HLog(@"dele fail");
        }
    }
}

- (void)dealloc
{
    [self isFileCompleted];
}


@end
