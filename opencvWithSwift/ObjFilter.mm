//
//  ObjFilter.m
//  opencvWithSwift
//
//  Created by Miguel Molero on 18/11/15.
//  Copyright © 2015 Miguel Molero. All rights reserved.
//

#import "ObjFilter.h"
#import "Filter.hpp"
#include  <vector>
#include  <iostream>

@implementation ObjFilter

NSMutableArray *_channels;

Filter filter;

-(UIImage*)processImage:(UIImage *)img {
    
    cv::Mat _imageInput;
    cv::Mat _imageOutput;
    
    UIImageToMat(img, _imageInput, true);
    
    filter.compute(_imageInput, _imageOutput);
    
    return MatToUIImage(_imageOutput);
    
}




void UIImageToMat(const UIImage* image, cv::Mat& m,
                  bool alphaExist)
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.
                                                      CGImage);
    CGFloat cols = image.size.width, rows = image.size.height;
    CGContextRef contextRef;
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedLast;
    if (CGColorSpaceGetModel(colorSpace) == 0)
    {
        m.create(rows, cols, CV_8UC1);
        //8 bits per component, 1 channel
        bitmapInfo = kCGImageAlphaNone;
        if (!alphaExist)
            bitmapInfo = kCGImageAlphaNone;
        contextRef = CGBitmapContextCreate(m.data, m.cols, m.rows,
                                           8,
                                           m.step[0], colorSpace,
                                           bitmapInfo);
    }
    else
    {
        m.create(rows, cols, CV_8UC4); // 8 bits per component, 4
        if (!alphaExist)
            bitmapInfo = kCGImageAlphaNoneSkipLast |
            kCGBitmapByteOrderDefault;
        contextRef = CGBitmapContextCreate(m.data, m.cols, m.rows,
                                           8,
                                           m.step[0], colorSpace,
                                           bitmapInfo);
    }
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows),
                       image.CGImage);
    CGContextRelease(contextRef);
}


UIImage* MatToUIImage(const cv::Mat& image)
{
    NSData *data = [NSData dataWithBytes:image.data length:image.
                    elemSize()*image.total()];
    
    CGColorSpaceRef colorSpace;
    
    if (image.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(image.cols,   //width
                                        
                                        image.rows,   //height
                                        8,            //bits percomponent
                                        8*image.elemSize(),//bits
                                        
                                        image.step.p[0],   //
                                        
                                        colorSpace,   //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,//
                                        provider,     //
                                        //CGDataProviderRef
                                        NULL,         //decode
                                        false,        //should
                                        //interpolate
                                        kCGRenderingIntentDefault
                                        //intent
                                        );
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}



@end

