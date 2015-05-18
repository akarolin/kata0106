//
//  CentsRounder.h
//  SupermarketPricing
//
//  Created by Andy Karolin on 5/16/15.
//  Copyright (c) 2015 Andy Karolin. All rights reserved.
//

// purpose of this class is to round floating point numbers to two decimal digits

#import <Foundation/Foundation.h>

@interface CentsRounder : NSObject

+ (double)roundUp:(double)input;
+ (double)roundNear:(double)input;
+ (double)roundDown:(double)input;

@end

