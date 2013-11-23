//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Peter DeVito on 11/13/13.
//  Copyright (c) 2013 Peter DeVito. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)history
{
    if (!_history) _history = [[NSMutableArray alloc] init];
    return _history;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init]; // super's designated initializer
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (instancetype)init //do nothing since this initializer is illegal
{
    return nil;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
    NSString *currentMove = card.contents;
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            currentMove = [currentMove stringByAppendingString:@" flipped down."];
        }
        else { // match against other chosen cards
            // create an array of chosen cards to pass to match
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [chosenCards addObject:otherCard];
                }
            }
            // when we reach the number of cards to be matched
            if ([chosenCards count] == self.matchMode - 1) {
                int matchScore = [card match:chosenCards];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *otherCard in chosenCards) {
                        otherCard.matched = YES;
                        currentMove = [currentMove stringByAppendingString:otherCard.contents];
                    }
                    currentMove = [NSString stringWithFormat:@"Matched%@ for %d points.",currentMove,matchScore * MATCH_BONUS];
                }
                else {
                    self.score -= MISMATCH_PENALTY;
                    for (Card *otherCard in chosenCards) {
                        otherCard.chosen = NO;
                        currentMove = [currentMove stringByAppendingString:otherCard.contents];
                    }
                    currentMove = [NSString stringWithFormat:@"%@ don't match! %d point penalty!",currentMove,MISMATCH_PENALTY];
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    NSLog(@"%@",currentMove);
    [self.history addObject:currentMove];
}

@end
