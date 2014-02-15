//
//  ViewController.m
//  FifteenPuzzle
//
//  Created by student on 2/8/14.
//  Copyright (c) 2014 Zachary Thompson. All rights reserved.
//

#import "ViewController.h"
#import "PuzzleModel.h"

@interface ViewController ()

@property (nonatomic) PuzzleModel *puzzleModel;

// all the buttons
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;
@property (weak, nonatomic) IBOutlet UIButton *button10;
@property (weak, nonatomic) IBOutlet UIButton *button11;
@property (weak, nonatomic) IBOutlet UIButton *button12;
@property (weak, nonatomic) IBOutlet UIButton *button13;
@property (weak, nonatomic) IBOutlet UIButton *button14;
@property (weak, nonatomic) IBOutlet UIButton *button15;
@property (weak, nonatomic) IBOutlet UIButton *buttonBlank;

// solved label
@property (weak, nonatomic) IBOutlet UILabel *labelSolved;

// swipe recognizers
@property (nonatomic) UISwipeGestureRecognizer *leftSwipe;
@property (nonatomic) UISwipeGestureRecognizer *rightSwipe;
@property (nonatomic) UISwipeGestureRecognizer *upSwipe;
@property (nonatomic) UISwipeGestureRecognizer *downSwipe;

@property (weak, nonatomic) IBOutlet UISlider *shuffleSlider;

@property (nonatomic) BOOL busy;

@property (nonatomic) NSArray* animationSequence;
@property (nonatomic) int animationPos;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.puzzleModel = [[PuzzleModel alloc] initWithBoard:[NSArray arrayWithObjects:self.button1, self.button2, self.button3, self.button4, self.button5, self.button6, self.button7, self.button8, self.button9, self.button10, self.button11, self.button12, self.button13, self.button14, self.button15, self.buttonBlank, nil]];
    
    [self setUpSwipe];
    
    [self setBusy:NO];
    
    
}


#pragma mark - Swipe methods


// Registers all the swipe handlers
-(void) setUpSwipe
{
    self.leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [self.leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:self.leftSwipe];
    
    self.rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [self.rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:self.rightSwipe];
    
    self.upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [self.upSwipe setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:self.upSwipe];
    
    self.downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [self.downSwipe setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:self.downSwipe];
}

// Based on the swipe direction calls the appropriate model method to make the move. If the move is legal, it calls a method to animate that move
-(void) handleSwipe:(UISwipeGestureRecognizer *) sender
{
    // app is busy so no response
    if (self.busy) {
        return;
    }
    
    NSArray *swapTiles;

    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        swapTiles = [self.puzzleModel makeLeftMoveIfValid];
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        swapTiles = [self.puzzleModel makeRightMoveIfValid];
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionUp) {
        swapTiles = [self.puzzleModel makeUpMoveIfValid];
    }
    else {
        swapTiles = [self.puzzleModel makeDownMoveIfValid];
    }
    
    if (swapTiles) {
        [self setAnimationSequence:@[swapTiles]];
        [self setAnimationPos:0];
        [self setBusy:YES];
        [self animateNextMoveWithDuration:.5];
    }
}


#pragma mark - Display changing methods


// Animates a move in the animationSequence array based on the value of animationPos. The duration parameter specifies how long an individual animation should take
-(void) animateNextMoveWithDuration:(float)duration
{
    NSArray* swapTiles = self.animationSequence[self.animationPos++];
    CGPoint firstCenter = [swapTiles[0] center];
    
    [UIView animateWithDuration:duration animations:^{
        
        [swapTiles[0] setCenter:[swapTiles[1] center]];
        [swapTiles[1] setCenter:firstCenter];
        
    } completion:^(BOOL finished) {
        if (self.animationPos < self.animationSequence.count) {
            [self animateNextMoveWithDuration:duration];
        }
        else {
            [self setAnimationPos:-1];
            [self setAnimationSequence:nil];
            [self updateSolvedLabel];
            [self setBusy:NO];
        }
    }];
}

// Updates the label to display "Solved" if the board is in a solved state and shows no display otherwise
-(void) updateSolvedLabel
{
    if ([self.puzzleModel isSolved]) {
        [[self labelSolved] setTextColor:[UIColor colorWithRed:0 green:130.0/255.0 blue:0 alpha:1.0]];
    }
    else {
        [[self labelSolved] setTextColor:[UIColor whiteColor]];
    }
}


#pragma mark - Button click handlers


// Brings the board back to its original state
- (IBAction)onResetClick:(UIButton *)sender
{
    [self setBusy:YES];
    
    if ([self.puzzleModel isSolved]) {
        [self setBusy:NO];
        return;
    }
    
    NSArray *moveSequence = [self.puzzleModel resetBoard];
    
    [self setAnimationSequence:moveSequence];
    [self setAnimationPos:0];
    [self animateNextMoveWithDuration:.35];
}

// Shuffles the board based on the the amount specified by the slider
- (IBAction)onShuffleClick:(UIButton *)sender
{
    [self setBusy:YES];
    
    int shuffleAmount = (int) self.shuffleSlider.value;
    
    if (shuffleAmount == 0) {
        [self setBusy:NO];
        return;
    }
    
    NSArray *moveSequence = [self.puzzleModel shuffleBoard:shuffleAmount];
    
    [self setAnimationSequence:moveSequence];
    [self setAnimationPos:0];
    [self animateNextMoveWithDuration:.1];
}

@end

