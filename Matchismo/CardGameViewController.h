//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Peter DeVito on 11/10/13.
//  Copyright (c) 2013 Peter DeVito. All rights reserved.
//
// Abstract class. Must implement abstract methods below.

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

// protected for subclasses
- (Deck *)createDeck; // abstract

@end
