//
//  CentsRounder.m
//  SupermarketPricing
//
//  Created by Andy Karolin on 5/16/15.
//  Copyright (c) 2015 Andy Karolin. All rights reserved.
//

#import "CentsRounder.h"

@interface CentsRounder ()

@end

@implementation CentsRounder

+ (double)roundUp:(double)input {  // round up float to two decimal digits
    return (int)ceilf(input * 100) / 100.0;
}

+ (double)roundNear:(double)input { // round float to closest two decimal digits
    return (int)floorf(input * 100 + 0.5) / 100.0;
}

+ (double)roundDown:(double)input { // round down float to two decimal digits
    return (int)floorf(input * 100) / 100.0;
}

@end