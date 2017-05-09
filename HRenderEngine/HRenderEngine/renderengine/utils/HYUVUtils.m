//
//  HYUVUtils.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/5/8.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HYUVUtils.h"

//#import "swscale.h"
//#import "imgutils.h"
//#import "avformat.h"
//#import "frame.h"
//
//
//int HYUVChannelFilterNeedSize(int linesize, int width, int height, int channel_count)
//{
//    width = MIN(linesize, width);
//    return width * height * channel_count;
//}
//
//void HYUVChannelFilter(UInt8 * src, int linesize, int width, int height, UInt8 * dst, size_t dstsize, int channel_count)
//{
//    width = MIN(linesize, width);
//    UInt8 * temp = dst;
//    memset(dst, 0, dstsize);
//    for (int i = 0; i < height; i++)
//    {
//        memcpy(temp, src, width * channel_count);
//        temp += (width * channel_count);
//        src += linesize;
//    }
//}
//
//HImage * SGYUVConvertToImage(UInt8 * src_data[], int src_linesize[], int width, int height, enum AVPixelFormat pixelFormat)
//{
//    struct SwsContext * sws_context = NULL;
//    sws_context = sws_getCachedContext(sws_context,
//                                       width,
//                                       height,
//                                       pixelFormat,
//                                       width,
//                                       height,
//                                       AV_PIX_FMT_RGB24,
//                                       SWS_FAST_BILINEAR,
//                                       NULL, NULL, NULL);
//    if (!sws_context) return nil;
//    
//    uint8_t * data[AV_NUM_DATA_POINTERS];
//    int linesize[AV_NUM_DATA_POINTERS];
//    
//    int result = av_image_alloc(data, linesize, width, height, AV_PIX_FMT_RGB24, 1);
//    if (result < 0)
//    {
//        if (sws_context)
//        {
//            sws_freeContext(sws_context);
//        }
//        return nil;
//    }
//    
//    result = sws_scale(sws_context, (const uint8_t **)src_data, src_linesize, 0, height, data, linesize);
//    if (sws_context)
//    {
//        sws_freeContext(sws_context);
//    }
//    if (result < 0) return nil;
//    if (linesize[0] <= 0 || data[0] == NULL) return nil;
//    
//    HImage * image = HImageWithRGBData(data[0], linesize[0], width, height);
//    av_freep(&data[0]);
//    
//    return image;
//}
