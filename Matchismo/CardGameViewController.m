//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Peter DeVito on 11/10/13.
//  Copyright (c) 2013 Peter DeVito. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeSegment;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@end

@implementation CardGameViewController

- (CardMatchingGame *) game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
    NSLog(@"Creating Deck");
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    if (self.matchModeSegment.enabled) {
        self.game.matchMode = self.matchModeSegment.selectedSegmentIndex + 2; //convert index 0,1 to mode 2,3
        self.matchModeSegment.enabled = NO;
        NSLog(@"The current game mode is match %d.",self.game.matchMode);
    }
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)touchDealButton:(UIButton *)sender {
    self.matchModeSegment.enabled = YES;
    self.game = nil;
    [self updateUI];
    self.historyLabel.text = @"No card chosen";
    self.scoreLabel.text = @"Score: 0";
}

- (IBAction)sliderHistory:(UISlider *)sender {
    NSNumber *sliderIndex = [NSNumber numberWithFloat:sender.value];
    int historyIndex = sliderIndex.intValue;
    if (historyIndex < [self.game.history count]) {
        self.historyLabel.text = [self.game.history objectAtIndex:historyIndex];
    }
    self.historyLabel.alpha = (historyIndex == [self.game.history count] - 1) ? 1.0 : 0.5;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.historyLabel.text = [self.game.history lastObject];
    self.historyLabel.alpha = 1.0;
    self.historySlider.maximumValue = [self.game.history count] - 1;
    [self.historySlider setValue:[self.game.history count] animated:YES];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
