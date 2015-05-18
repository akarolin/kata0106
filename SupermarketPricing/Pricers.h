//
//  Pricers.h
//  SupermarketPricing
//
//  Created by Andy Karolin on 5/17/15.
//  Copyright (c) 2015 Andy Karolin. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface UnitPricer : NSObject

@property (nonatomic) double price;
@property (nonatomic) int units;

- (double)calculateUnitPrice;
- (double)calculateTotalPriceForDiscreteQuantity:(int)quantity;
- (double)calculateTotalPriceForFractionalQuantity:(double)quantity;

@end

@interface BuySomeGetSomePricer : NSObject

@property (nonatomic) double price;
@property (nonatomic) int buyUnits;
@property (nonatomic) int getUnits;

- (double)calculateUnitPrice;
- (double)calculateTotalPriceForQuantity:(int)quantity;

@end

