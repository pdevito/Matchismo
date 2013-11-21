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
static const int ADDITIONAL_MATCH_BONUS = 2;

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

- (instancetype)init
{
    //do nothing since this initializer is illegal
    return nil;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSString *currentMove = card.contents;
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            currentMove = [currentMove stringByAppendingString:@" flipped down."];
        }
        else {
            // match against other chosen cards
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                        currentMove = [NSString stringWithFormat:@"Matched%@ %@ for %d points.",card.contents,otherCard.contents,self.score];
                    }
                    else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                        currentMove = [NSString stringWithFormat:@"%@ %@ don't match! %d point penalty!",card.contents,otherCard.contents,MISMATCH_PENALTY];
                    }
                    break; // can only choose 2 cards for now
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
