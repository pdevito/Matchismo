//
//  SetCard.m
//  Matchismo
//
//  Created by Peter DeVito on 1/19/14.
//  Copyright (c) 2014 Peter DeVito. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    //Score on these conditions:
    //  ALL numbers match || don't
    //  ALL symbols match || don't
    //  ALL shadings match || don't
    //  ALL colors match || don't
    int score = 0;
    BOOL countCanScore, symbolsCanScore, shadingsCanScore, colorsCanScore;
    
    // There should only be three cards to check. Self, and two cards in otherCards
    if ([otherCards count] != 2) {
        NSLog(@"Something went wrong. %d cards being checked.", ([otherCards count] + 1));
        return -1;
    }
    
    SetCard *compareCard1 = otherCards[0];
    SetCard *compareCard2 = otherCards[1];
    
    // Check symbol count to see if set rules indicates a set
    if ((self.count == compareCard1.count) && (compareCard1.count == compareCard2.count))
        countCanScore = true;
    else if ((self.count != compareCard1.count) && (self.count != compareCard2.count) &&
               (compareCard1.count != compareCard2.count))
        countCanScore = true;
    else
        countCanScore = false;
    
    // Check symbols to see if rules indicates a set
    if ([self.symbol isEqualToString:compareCard1.symbol] && [compareCard1.symbol isEqualToString:compareCard2.symbol])
        symbolsCanScore = true;
    else if (![self.symbol isEqualToString:compareCard1.symbol] && ![self.symbol isEqualToString:compareCard2.symbol] &&
               ![compareCard1.symbol isEqualToString:compareCard2.symbol])
        symbolsCanScore = true;
    else
        symbolsCanScore = false;
    
    // Check shadings to see if rules indicates a set
    if ([self.shading isEqualToString:compareCard1.shading] && [compareCard1.shading isEqualToString:compareCard2.shading])
        shadingsCanScore = true;
    else if (![self.shading isEqualToString:compareCard1.shading] && ![self.shading isEqualToString:compareCard2.shading] &&
               ![compareCard1.shading isEqualToString:compareCard2.shading])
        shadingsCanScore = true;
    else
        shadingsCanScore = false;
    
    // Check colors to see if rules indicates a set
    if ([self.color isEqualToString:compareCard1.color] && [compareCard1.color isEqualToString:compareCard2.color])
        colorsCanScore = true;
    else if (![self.color isEqualToString:compareCard1.color] && ![self.color isEqualToString:compareCard2.color] &&
               ![compareCard1.color isEqualToString:compareCard2.color])
        colorsCanScore = true;
    else
        colorsCanScore = false;
    
    if (countCanScore && symbolsCanScore && shadingsCanScore && colorsCanScore)
        score = 1;
    else
        score = 0;
    
    return score;
}

- (NSString *) contents
{
    //create a String with the format 'count:shape:color:shade'
    NSString *label = [NSString stringWithFormat:@"%d:%@:%@:%@", self.count, self.symbol, self.color, self.shading];
    NSLog(@"%@",label);
    return label;
}

#pragma mark --Setters and Getters--

@synthesize color = _color;
@synthesize symbol = _symbol;
@synthesize shading = _shading;

- (void) setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color])
        _color = color;
}

- (NSString *)color
{
    return _color ? _color : @"?";
}

- (void) setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol])
        _symbol = symbol;
}

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

- (void) setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading])
        _shading = shading;
}

- (NSString *)shading
{
    return _shading ? _symbol : @"?";
}

- (void) setCount:(NSUInteger)count
{
    if (count <= MAX_COUNT)
        _count = count;
}


#pragma mark --Valid Values--

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validSymbols
{
    return @[@"▲", @"●", @"◼︎"];
}

+ (NSArray *)validShadings
{
    return @[@"solid", @"striped", @"open"];
}

- (NSUInteger) maxCount
{
    return MAX_COUNT;
}

@end
