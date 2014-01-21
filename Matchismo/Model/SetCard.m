//
//  SetCard.m
//  Matchismo
//
//  Created by Peter DeVito on 1/19/14.
//  Copyright (c) 2014 Peter DeVito. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize color = _color;
@synthesize symbol = _symbol;
@synthesize shading = _shading;

static const int MAX_COUNT = 3;

- (int)match:(NSArray *)otherCards
{
    //Score on these conditions:
    //  ALL numbers match || don't
    //  ALL symbols match || don't
    //  ALL shadings match || don't
    //  ALL colors match || don't
    int score = 0;
    
    
    
    return score;
}

- (NSString *) contents
{
    //create a String with the format 'count:shape:color
    NSString *label = @"";
    return label;
}


- (void) setColor:(NSString *)color
{
    _color = color;
}

- (NSString *)color
{
    return _color;
}

- (void) setSymbol:(NSString *)symbol
{
    _symbol = symbol;
}

- (NSString *)symbol
{
    return _symbol;
}

- (void) setShading:(NSString *)shading
{
    _shading = shading;
}

- (NSString *)shading
{
    return _shading;
}

- (void) setCount:(NSUInteger)count
{
    _count = count;
}


#pragma MARK valid values

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validShapes
{
    return @[@"▲", @"●", @"◼︎"];
}

+ (NSArray *)validShadings
{
    return @[@"solid", @"striped", @"open"];
}


@end
