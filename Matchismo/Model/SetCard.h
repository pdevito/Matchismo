//
//  SetCard.h
//  Matchismo
//
//  Created by Peter DeVito on 1/19/14.
//  Copyright (c) 2014 Peter DeVito. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger count;

+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSArray *)validShadings;

//- (NSUInteger) maxCount;

@end






//  For the future::
//  This implementation will allow 1,2,3 shapes per card.
//  There will be 3 shadings: solid, striped, open.
//  For color and shape, we will init with those as arrays.
