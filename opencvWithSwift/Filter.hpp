//
//  Filter.hpp
//  opencvWithSwift
//
//  Created by Miguel Molero on 18/11/15.
//  Copyright © 2015 Miguel Molero. All rights reserved.
//

#ifndef Filter_hpp
#define Filter_hpp

#include <stdio.h>
#include <opencv2/opencv.hpp>

class Filter
{
public:
    void compute(cv::Mat  &src, cv::Mat &dst);
};




#endif /* Filter_hpp */
