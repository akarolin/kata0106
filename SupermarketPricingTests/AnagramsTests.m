//
//  AnagramsTests.m
//  SupermarketPricing
//
//  Created by Andy Karolin on 5/18/15.
//  Copyright (c) 2015 Andy Karolin. All rights reserved.
//

#import "anagrams.h"
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface AnagramsTests : XCTestCase
@property (nonatomic) Anagrams *anagrams;
@end

@implementation AnagramsTests

- (void)setUp {
    [super setUp];
    self.anagrams = [[Anagrams alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitialize {
    XCTAssertTrue([self.anagrams.wordList count] > 0);
}

- (void)testMakeKey {
    NSString *word = @"edcba";
    NSString *desired = @"abcde";
    NSString *test = [self.anagrams makeKey:word];
    XCTAssertTrue([desired isEqualToString:test]);
    
    // remove appostraphe
    word = @"test's";
    desired = @"esstt";
    test = [self.anagrams makeKey:word];
    XCTAssertTrue([desired isEqualToString:test]);
}

- (void)testAddKeyToDictionary {
    
    /* item, time, mite, emit */
    NSString *key = @"eimt";

    // add new entry
    [self.anagrams addToAnagramDictionary:@"item" withKey:key];
    XCTAssertTrue([self.anagrams.anagramDictionary objectForKey:key]);
    
    // add multiple entry
    [self.anagrams addToAnagramDictionary:@"time" withKey:key];
    NSArray *result = [self.anagrams.anagramDictionary objectForKey:key];
    XCTAssertTrue([result count] == 2);

    // no duplicate entry
    [self.anagrams addToAnagramDictionary:@"time" withKey:key];
    result = [self.anagrams.anagramDictionary objectForKey:key];
    XCTAssertTrue([result count] == 2);

}

- (void)testLoadDictionary
{
    int loaded = [self.anagrams loadDictionary];
    XCTAssertEqual(loaded, [self.anagrams.wordList count]);
    XCTAssertTrue([self.anagrams.anagramDictionary objectForKey:@"AAA"]);
    XCTAssertTrue([self.anagrams.anagramDictionary objectForKey:@"ZZZ"]);
    NSLog(@"Total anagram sets: %d", self.anagrams.anagramCount);
}

- (void)testGetAnagramListByNumber {
    [self.anagrams loadDictionary];
    NSArray *anagramList = [self.anagrams getAnagramListByPosition:5];
    XCTAssertEqual([anagramList count], 2);
//    NSLog(@"Anagrams: %@",anagramList);
}

- (void)testGetAnagramListByWord {
    [self.anagrams loadDictionary];
    NSArray *anagramList = [self.anagrams getAnagramListByWord:@"time"];
    XCTAssertEqual([anagramList count], 4);
}

@end
