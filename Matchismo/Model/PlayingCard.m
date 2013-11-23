//
//  PlayingCard.m
//  Matchismo
//
//  Created by Peter DeVito on 11/10/13.
//  Copyright (c) 2013 Peter DeVito. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    int tempScore = 0;
    NSMutableArray *searchCards = [[NSMutableArray alloc] init]; // hold temp array of Cards to compare
    NSArray *cards = [otherCards arrayByAddingObject:self];
    for (PlayingCard *card in cards) {
        [searchCards setArray:cards];
        [searchCards removeObject:card];
        int tempRankScore = 0;
        int tempSuitScore = 0;
        for (PlayingCard *matchCard in searchCards) {
            if (matchCard.rank == card.rank) {
                tempRankScore += 4;
            }
            if ([matchCard.suit isEqualToString:card.suit]) {
                tempSuitScore += 1;
            }
        }
        tempScore = (tempRankScore > tempSuitScore) ? tempRankScore : tempSuitScore;
        score = (score < tempScore) ? tempScore : score;
    }
    return score;
}

- (NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;   // because we provide setter and getter

+ (NSArray *)validSuits
{
    return @[@"♠",@"♣",@"♥",@"♦"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
