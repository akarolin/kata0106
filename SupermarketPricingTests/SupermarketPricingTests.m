//
//  SupermarketPricingTests.m
//  SupermarketPricingTests
//
//  Created by Andy Karolin on 5/15/15.
//  Copyright (c) 2015 Andy Karolin. All rights reserved.
//

#import "ViewController.h"
#import "CentsRounder.h"
#import "Pricers.h"
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>


@interface SupermarketPricingTests : XCTestCase

@property (nonatomic) ViewController *vcToTest;

@end

@implementation SupermarketPricingTests

- (void)setUp {
    [super setUp];
    self.vcToTest = [[ViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRoundUp {
    
    XCTAssertEqual([CentsRounder roundUp:24.101],24.11); // test low
    XCTAssertEqual([CentsRounder roundUp:24.105],24.11); // test middle
    XCTAssertEqual([CentsRounder roundUp:24.109],24.11); // test high
    XCTAssertEqual([CentsRounder roundUp:24.11],24.11); // test equal
}

- (void)testRoundDown {
    XCTAssertEqual([CentsRounder roundDown:24.101],24.10); // test low
    XCTAssertEqual([CentsRounder roundDown:24.105],24.10); // test middle
    XCTAssertEqual([CentsRounder roundDown:24.109],24.10); // test high
    XCTAssertEqual([CentsRounder roundDown:24.11],24.11); // test equal
}

- (void)testRoundNear {
    XCTAssertEqual([CentsRounder roundNear:24.101],24.10); // test low
    XCTAssertEqual([CentsRounder roundNear:24.105],24.11); // test middle
    XCTAssertEqual([CentsRounder roundNear:24.109],24.11); // test high
    XCTAssertEqual([CentsRounder roundNear:24.11],24.11); // test equal
}

-(void)testUnitPricerCalculateUnitPrice {
    UnitPricer *pricer = [[UnitPricer alloc] init];
    
    XCTAssertEqual([pricer calculateUnitPrice],0.00); // default case
    
    pricer.price = -1.00; // price setter test
    XCTAssertEqual([pricer calculateUnitPrice],0.00);
    
    pricer.price = 10.00;
    pricer.units = 0; // price setter test
    XCTAssertEqual([pricer calculateUnitPrice],10.00);
    
    pricer.units = 10;
    XCTAssertEqual([pricer calculateUnitPrice],1.00);

    pricer.units = 12;
    double unitPrice = [CentsRounder roundNear:[pricer calculateUnitPrice]];
    XCTAssertEqual(unitPrice,0.83);
}

-(void)testUnitPricerTotalPriceForDiscreteQuantity {

    UnitPricer *pricer = [[UnitPricer alloc] init];
    pricer.price = 1.00;
    
    pricer.units = 1; // base case
    XCTAssertEqual([pricer calculateTotalPriceForDiscreteQuantity:0],0.00);
    XCTAssertEqual([pricer calculateTotalPriceForDiscreteQuantity:1],1.00);
    XCTAssertEqual([pricer calculateTotalPriceForDiscreteQuantity:10],10.00);
    XCTAssertEqual([pricer calculateTotalPriceForDiscreteQuantity:-10],-10.00);
    
    pricer.units = 10; // price for ten units => ten cents each
    XCTAssertEqual([pricer calculateTotalPriceForDiscreteQuantity:10],1.00);

    pricer.units = 12;
    double unitPrice = [CentsRounder roundNear:[pricer calculateTotalPriceForDiscreteQuantity:10]];
    XCTAssertEqual(unitPrice,0.83);
}

-(void)testUnitPricerTotalPriceForFractionalQuantity {
    UnitPricer *pricer = [[UnitPricer alloc] init];
    pricer.price = 1.00;
    pricer.units = 1; // base case e.g. dollar per pound
    
    XCTAssertEqual([pricer calculateTotalPriceForFractionalQuantity:1.51],1.51);
    XCTAssertEqual([pricer calculateTotalPriceForFractionalQuantity:0.49],0.49);
    XCTAssertEqual([pricer calculateTotalPriceForFractionalQuantity:0.00],0.00);
    XCTAssertEqual([pricer calculateTotalPriceForFractionalQuantity:-1.00],-1.00);
}

- (void)testBuySomeGetSomePricerUnitPrice
{
    BuySomeGetSomePricer *pricer = [[BuySomeGetSomePricer alloc] init];
    
    XCTAssertEqual([pricer calculateUnitPrice],0.00); // default case
    
    pricer.price = -1.00; // price setter test - becomes 0
    XCTAssertEqual([pricer calculateUnitPrice],0.00);
    
    pricer.price = 10.00;
    pricer.buyUnits = 0; // price setter test - becomes 1
    XCTAssertEqual([pricer calculateUnitPrice],10.00);
    
    pricer.getUnits = 9; // buy 1 get nine
    XCTAssertEqual([pricer calculateUnitPrice],1.00);
    
    pricer.getUnits = -9; // setter test - becomes 0
    XCTAssertEqual([pricer calculateUnitPrice],10.00);
}

- (void)testBuySomeGetSomePricerEqualBuyAndGet
{
    BuySomeGetSomePricer *pricer = [[BuySomeGetSomePricer alloc] init];
    pricer.price = 1.00;
    
    // buy one, get one
    pricer.buyUnits = pricer.getUnits = 1;
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:100],50.00);
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:101],51.00);
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:101],51.00);
    
    // buy ten, get ten
    pricer.buyUnits = pricer.getUnits = 10;
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:100],50.00);
    
    // buy six, get six
    pricer.buyUnits = pricer.getUnits = 6;
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:100],52.00);
}

- (void)testBuySomeGetSomePricerBuyGTGet
{
    BuySomeGetSomePricer *pricer = [[BuySomeGetSomePricer alloc] init];
    pricer.price = 1.00;
    
    // buy one, get none free
    pricer.buyUnits = 1;
    pricer.getUnits = 0;
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:100],100.00);
    
    // buy three, get two
    pricer.buyUnits = 3;
    pricer.getUnits = 2;
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:100],60.00);
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:101],61.00);
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:102],62.00);
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:103],63.00);
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:104],63.00);
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:105],63.00);
}

- (void)testBuySomeGetSomePricerBuyLTGet
{
    BuySomeGetSomePricer *pricer = [[BuySomeGetSomePricer alloc] init];
    pricer.price = 1.00;
    
    // buy three, get two
    pricer.buyUnits = 2;
    pricer.getUnits = 3;
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:100],40.00);
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:101],41.00);
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:102],42.00);
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:103],42.00);
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:104],42.00);
    XCTAssertEqual([pricer calculateTotalPriceForQuantity:105],42.00);
}


@end
