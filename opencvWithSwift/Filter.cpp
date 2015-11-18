//
//  Filter.cpp
//  opencvWithSwift
//
//  Created by Miguel Molero on 18/11/15.
//  Copyright © 2015 Miguel Molero. All rights reserved.
//

#include "Filter.hpp"

void Filter::compute(cv::Mat  &src, cv::Mat &dst){
    
    int lowThreshold=0;
    int ratio = 3;
    int kernel_size = 3;
    
    cv::Mat detected_edges;
    cv::Mat gray;
    
    // RGB to grayscale
    cv::cvtColor(src, gray, CV_RGB2GRAY);
    // Blur filter
    cv::blur(gray, detected_edges, cv::Size(3,3));
    
    
    /// Canny detector
    Canny(detected_edges, detected_edges, lowThreshold, lowThreshold*ratio, kernel_size );
    
    /// Using Canny's output as a mask, we display our result
    
    
    dst = cv::Scalar::all(0);
    src.copyTo(dst, detected_edges);

        
}