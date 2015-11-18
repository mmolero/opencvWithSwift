//
//  ObjFilter.h
//  opencvWithSwift
//
//  Created by Miguel Molero on 18/11/15.
//  Copyright © 2015 Miguel Molero. All rights reserved.
//

#ifndef ObjFilter_h
#define ObjFilter_h

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#endif

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ObjFilter : NSObject

-(UIImage*)processImage: (UIImage*)img;

@end


#endif /* ObjFilter_h */
