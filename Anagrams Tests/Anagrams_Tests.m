//
//  Anagrams_Tests.m
//  Anagrams Tests
//
//  Created by Andy Karolin on 5/18/15.
//  Copyright (c) 2015 Andy Karolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "anagrams.h"

@interface Anagrams_Tests : XCTestCase


@end

@implementation Anagrams_Tests

- (void)setUp {
    [super setUp];
    Anagrams *anagrams = [[Anagrams alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitialization {
    XCTAssertTrue([anagrams.wordList count] > 0);
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
