////
////  HImage.m
////  HRenderEngine
////
////  Created by 黄世平 on 17/5/8.
////  Copyright © 2017年 黄世平. All rights reserved.
////
//
//#import "HImage.h"
//
//CIImage * HImageCIImageWithCVPexelBuffer(CVPixelBufferRef pixelBuffer)
//{
//    CIImage * image = [CIImage imageWithCVPixelBuffer:pixelBuffer];
//    return image;
//}
//
//CGImageRef HImageCGImageWithCVPexelBuffer(CVPixelBufferRef pixelBuffer)
//{
//    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
//    
//    size_t count = CVPixelBufferGetPlaneCount(pixelBuffer);
//    if (count > 1)
//    {
//        CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
//        return nil;
//    }
//    
//    uint8_t * baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(pixelBuffer);
//    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer);
//    size_t width = CVPixelBufferGetWidth(pixelBuffer);
//    size_t height = CVPixelBufferGetHeight(pixelBuffer);
//    
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(baseAddress,
//                                                 width,
//                                                 height,
//                                                 8,
//                                                 bytesPerRow,
//                                                 colorSpace,
//                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
//    
//    CGImageRef imageRef = CGBitmapContextCreateImage(context);
//    
//    CGColorSpaceRelease(colorSpace);
//    CGContextRelease(context);
//    
//    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
//    
//    return imageRef;
//}
//
//HImage * HImageWithRGBData(UInt8 * rgb_data, int linesize, int width, int height)
//{
//    CGImageRef imageRef = HImageCGImageWithRGBData(rgb_data, linesize, width, height);
//    if (!imageRef) return nil;
//    HImage * image = HImageWithCGImage(imageRef);
//    CGImageRelease(imageRef);
//    return image;
//}
//
//CGImageRef HImageCGImageWithRGBData(UInt8 * rgb_data, int linesize, int width, int height)
//{
//    CFDataRef data = CFDataCreate(kCFAllocatorDefault, rgb_data, linesize * height);
//    CGDataProviderRef provider = CGDataProviderCreateWithCFData(data);
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGImageRef imageRef = CGImageCreate(width,
//                                        height,
//                                        8,
//                                        24,
//                                        linesize,
//                                        colorSpace,
//                                        kCGBitmapByteOrderDefault,
//                                        provider,
//                                        NULL,
//                                        NO,
//                                        kCGRenderingIntentDefault);
//    CGColorSpaceRelease(colorSpace);
//    CGDataProviderRelease(provider);
//    CFRelease(data);
//    
//    return imageRef;
//}
//
