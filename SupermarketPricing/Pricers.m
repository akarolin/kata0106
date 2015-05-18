//
//  Pricers.m
//  SupermarketPricing
//
//  Created by Andy Karolin on 5/17/15.
//  Copyright (c) 2015 Andy Karolin. All rights reserved.
//

#import "Pricers.h"


@implementation UnitPricer

- (id)init
{
    if( self = [super init] )
    {
        _price = 0.00;
        _units = 1;
    }
    
    return self;
}

- (void)setPrice:(double)price
{
    if (price < 0.00) {
        price = 0.00;
    }
    _price = price;
}

- (void)setUnits:(int)units {
    
    if (units < 1) {
        units = 1;
    }
    _units = units;
}

- (double)calculateUnitPrice {
    return _price / _units;
}

- (double)calculateTotalPriceForDiscreteQuantity:(int)quantity {
    return quantity * [self calculateUnitPrice];
}

- (double)calculateTotalPriceForFractionalQuantity:(double)quantity {
    return quantity * [self calculateUnitPrice];
}

@end

@implementation BuySomeGetSomePricer

- (id)init
{
    if( self = [super init] )
    {
        _price = 0.00;
        _buyUnits = 1;
        _getUnits = 0;
    }
    
    return self;
}

- (void)setPrice:(double)price
{
    if (price < 0.00) {
        price = 0.00;
    }
    _price = price;
}

- (void)setBuyUnits:(int)buyUnits
{
    if (buyUnits < 1) {
        buyUnits = 1;
    }
    _buyUnits = buyUnits;
}

- (void)setGetUnits:(int)getUnits
{
    if (getUnits < 0) {
        getUnits = 0;
    }
    _getUnits = getUnits;
}

- (double)calculateUnitPrice {
    return _price / (_buyUnits + _getUnits);
}

- (double)calculateTotalPriceForQuantity:(int)quantity
{
    int setQuantity = (_buyUnits + _getUnits);
    int pricingSets = quantity / setQuantity;
    int freeCount = pricingSets * _getUnits;
    int leftOvers = quantity % setQuantity - _buyUnits;
    int freebies = leftOvers > 0 ? leftOvers : 0;
    double totalPrice = (quantity - freeCount - freebies) * _price;
    
    return totalPrice;
}

@end

