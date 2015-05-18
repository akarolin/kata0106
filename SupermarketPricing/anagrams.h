//
//  anagrams.h
//  SupermarketPricing
//
//  Created by Andy Karolin on 5/18/15.
//  Copyright (c) 2015 Andy Karolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Anagrams : NSObject

@property NSArray* wordList;
@property NSMutableDictionary* anagramDictionary;
@property int anagramCount;

- (NSString *)makeKey:(NSString*)word;
- (BOOL)addToAnagramDictionary:(NSString *)word withKey:(NSString *)sortedString;
- (int) loadDictionary;
- (NSArray *)getAnagramListByWord:(NSString *)word;
- (NSArray *)getAnagramListByPosition:(int)number;

@end

