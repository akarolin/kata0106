//
//  anagrams.m
//  SupermarketPricing
//
//  Created by Andy Karolin on 5/18/15.
//  Copyright (c) 2015 Andy Karolin. All rights reserved.
//
#import "anagrams.h"

@interface Anagrams ()



@end

@implementation Anagrams

- (id)init
{
    if( self = [super init] )
    {
        NSError *error;
        NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
        NSString *file = [[NSBundle mainBundle] pathForResource:@"wordlist" ofType:@"txt"];
        NSString* fileContents = [NSString stringWithContentsOfFile:file
                                                           encoding:NSUTF8StringEncoding
                                                              error:&error];
        if (!fileContents) {
            NSLog(@"File read error: %@.",[error localizedDescription]);
        }
        _wordList = [fileContents componentsSeparatedByCharactersInSet:newlineCharSet];
    
        _anagramDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}


- (NSString *)makeKey:(NSString*)word {
    
    // key is created by sorting letters into alphabetical order and removing apostrophe
    
    NSMutableArray *theLetters = [NSMutableArray arrayWithCapacity:20];
    for ( NSUInteger i = 0 ; i < [word length]; ++i )
    {
        NSString *letter = [word substringWithRange:NSMakeRange(i, 1)];
        if (![letter isEqualToString:@"'"]) {
            [theLetters addObject: letter];
        }
    }
    
    NSArray *sortedLetters = [theLetters
                              sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSString *sortedString = [sortedLetters componentsJoinedByString:@""];
    return sortedString;
}

- (BOOL)addToAnagramDictionary:(NSString *)word withKey:(NSString *)sortedString
{
    BOOL wasAdded = true;
    
    NSMutableArray *anagrams = [_anagramDictionary objectForKey:sortedString];
    if (!anagrams) {  // if not in dictionary add
        NSMutableArray* value = [[NSMutableArray alloc] initWithObjects:word, nil];
        [_anagramDictionary setObject:value forKey:sortedString];
        
    } else { // found, add word to anagram array
        
        int i; // look for duplicates
        for (i = 0; i < [anagrams count]; i++) {
            NSString *test = anagrams[i];
            if ([test isEqualToString:word]) {
                break;
            }
        }
        
        // do not add if already on list
        if (i == [anagrams count]) {
            [anagrams addObject:word];
            if ([anagrams count] == 2) {
                _anagramCount++;
            }
        } else {
            wasAdded = false;
        }
        
    }
    return wasAdded;
}

- (int) loadDictionary
{
    int count = 0;
    int dupes = 0;
    
    for (int i=0; i < [_wordList count]; i++) {
        NSString *word = _wordList[i];
        NSString *key = [self makeKey:word];
        if ([self addToAnagramDictionary:word withKey:key]) {
            count++;
        } else {
            dupes++;
        }
    }
    return count + dupes;
}

- (NSArray *)getAnagramListByWord:(NSString *)word
{
    NSString *key = [self makeKey:word];
    return [_anagramDictionary objectForKey:key];
}

- (NSArray *)getAnagramListByPosition:(int)number
{
    int position = 0;
    for(id key in _anagramDictionary) {
        NSArray *anagrams = [_anagramDictionary objectForKey:key];
        if ([anagrams count] > 1) {
            if (number == position)
                return anagrams;
            else
                position++;
        }
    }
    return nil;
}

- (void)printAnagramLists
{
    for(id key in _anagramDictionary) {
        NSArray *anagrams = [_anagramDictionary objectForKey:key];
        if ([anagrams count] > 1) {
            NSLog(@"%@",anagrams);
        }
    }
}



@end
