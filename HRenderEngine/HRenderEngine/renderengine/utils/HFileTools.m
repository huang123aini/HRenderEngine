//
//  HFileTools.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/19.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HFileTools.h"

#import <ImageIO/ImageIO.h>

@implementation HFileTools

+ (void)copyFileToPath:(NSString *)fileName
{
    NSArray *storeFilePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *doucumentsDirectiory = [storeFilePath objectAtIndex:0];
    
    NSString *Path =[doucumentsDirectiory stringByAppendingPathComponent:fileName];
    NSFileManager *file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:Path])
    {
        HLog(@"exists file: %@",Path);
    }
    else //not in sandbox
    {
        NSError *error;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *bundle = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        [fileManager copyItemAtPath:bundle toPath:Path error:&error];
        
        HLog(@"write into:%d",[fileManager copyItemAtPath:bundle toPath:Path error:&error]);
    }
}

+ (void)checkBundleVersion:(void (^)(void))isEqual noEqual:(void (^)(void))noEqual
{
    // sandbox version  and current version
    //1. sandbox version
    NSString * lastVersion= [[NSUserDefaults standardUserDefaults] objectForKey:@"CFBundleVersion"];
    //2. read info.plist
    NSDictionary * info = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = info[@"CFBundleShortVersionString"];
    
    //3. is equal
    if ([currentVersion isEqualToString:lastVersion])
    {
        isEqual();
    }
    else
    {
        //write info into sandbox
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"CFBundleVersion"];
        //synchronize into sandbox
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        noEqual();
    }
}

+ (void)downloadFile:(NSString *)urlName block:(void (^)(NSString *))block
{
    __block NSString *fileName;
    dispatch_queue_t queue = dispatch_queue_create("DownLoad", NULL);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        fileName = [[self createFilePathWithName:@"Downloaded"] stringByAppendingPathComponent:[urlName lastPathComponent]];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:fileName])
        {
            
            HLog(@"file is exists ,read directly");
        }else
        {
            
            HLog(@"file is not exists,download from internet");
            
            NSURL *url = [NSURL URLWithString:urlName];
            NSData *data = [NSData dataWithContentsOfURL:url];
            
            // write nsdate object into file ，file name is fileName
            [data writeToFile:fileName atomically:YES];
        }
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        block(fileName);
    });
}


+ (NSMutableArray *)readPlistFromLocal:(NSString *)filePath
{
    NSMutableArray *array;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePath])
    {
        HLog(@"local is exist");
        array = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    else
    {
        HLog(@"local is not exist");
    }
    
    return array;
}

+ (NSString*)TimeformatFromSeconds:(int)seconds
{
    int totalm = seconds/(60);
    int h = totalm/(60);
    int m = totalm%(60);
    int s = seconds%(60);
    if (h == 0) {
        return  [NSString stringWithFormat:@"%02d:%02d", m, s];
    }
    return [NSString stringWithFormat:@"%02d:%02d:%02d", h, m, s];
}

+ (NSString *)createFilePathWithName:(NSString *)filePathName
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath = [NSString stringWithFormat:@"%@/%@", pathDocuments,filePathName];
    
    //check the file is exist,if not,create
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath])
    {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
        return createPath;
    } else
    {
        NSLog(@"FileDir is exists.");
        return createPath;
    }
}

+ (NSMutableArray *)decodeGifWithGifPath:(NSString *)path
{
    NSMutableArray * data = [NSMutableArray array];
    
    CFURLRef _url = (__bridge CFURLRef) [NSURL fileURLWithPath: path];
    NSMutableArray *gifImagesArr = [NSMutableArray array];
    NSMutableArray *frameDelayTimes = [NSMutableArray array];
    
    //get the gif sources
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL(_url, NULL);
    size_t frameCount = CGImageSourceGetCount(gifSource);
    
    for (size_t i = 0; i < frameCount; i++)
    {
        CGImageRef cgimg = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        UIImage *uiimg = [UIImage imageWithCGImage:cgimg];
        [gifImagesArr addObject:uiimg];
        CGImageRelease(cgimg);
        
        NSDictionary *dict = (NSDictionary*)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(gifSource, i, NULL));
        NSDictionary *gifDict = [dict valueForKey:(NSString*)kCGImagePropertyGIFDictionary];
        [frameDelayTimes addObject:[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime]];
    }
    
    [data addObject:gifImagesArr];
    [data addObject:frameDelayTimes];
    
    if (gifSource)
    {
        CFRelease(gifSource);
    }
    
    if (gifImagesArr.count == 0)
    {
        return nil;
    }
    
    return data;
}

@end
