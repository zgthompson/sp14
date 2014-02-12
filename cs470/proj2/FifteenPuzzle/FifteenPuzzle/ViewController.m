//
//  ViewController.m
//  FifteenPuzzle
//
//  Created by student on 2/8/14.
//  Copyright (c) 2014 Zachary Thompson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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

// board state representation
@property (nonatomic) NSMutableArray *board;
@property (nonatomic) NSArray *solutionBoard;

// current position of the blank piece
@property (nonatomic) int blankPos;
@property (nonatomic) int lastBlankPos;

// swipe recognizers
@property (nonatomic) UISwipeGestureRecognizer *leftSwipe;
@property (nonatomic) UISwipeGestureRecognizer *rightSwipe;
@property (nonatomic) UISwipeGestureRecognizer *upSwipe;
@property (nonatomic) UISwipeGestureRecognizer *downSwipe;

@property (weak, nonatomic) IBOutlet UISlider *shuffleSlider;

@property (nonatomic) int busy;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // prepare the game board to play
    [self setUpGame];
    
    // register the swipe event handlers
    [self setUpSwipe];
    
    // application is not busy so it will respond to swipes
    [self setBusy:NO];
    
    
}

-(void) setUpGame
{
    // initialize the solution board
    [self setSolutionBoard:[NSArray arrayWithObjects:self.button1, self.button2, self.button3, self.button4, self.button5, self.button6, self.button7, self.button8, self.button9, self.button10, self.button11, self.button12, self.button13, self.button14, self.button15, self.buttonBlank, nil]];
    
    // copy solution board to start board
    [self setBoard:[NSMutableArray arrayWithArray:self.solutionBoard]];
    
    // blank starts at position 15
    self.blankPos = 15;
    // no last blank pos
    self.lastBlankPos = -1;
}

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

-(void) handleSwipe:(UISwipeGestureRecognizer *) sender
{
    // app is busy so no response
    if (self.busy) {
        return;
    }

    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self makeLeftMoveIfValid];
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self makeRightMoveIfValid];
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionUp) {
        [self makeUpMoveIfValid];
    }
    else {
        [self makeDownMoveIfValid];
    }
}

-(int) leftMove
{
    // invalid move if blank is on leftmost column
    if (self.blankPos % 4 == 3) {
        return -1;
    }
    
    // the piece is one column to the right of blank
    return self.blankPos + 1;
}

-(void) makeLeftMoveIfValid
{
    int move = [self leftMove];
    if (move != -1) {
        [self moveBlankToPos:move];
    }
}

-(int) rightMove
{
    // invalid move if blank is on rightmost column
    if (self.blankPos % 4 == 0) {
        return -1;
    }
    
    // the piece is one column to the left of blank
    return self.blankPos - 1;
}

-(void) makeRightMoveIfValid
{
    int move = [self rightMove];
    if (move != -1) {
        [self moveBlankToPos:move];
    }
}

-(int) upMove
{
    // invalid move if blank is on bottom row
    if (self.blankPos / 4 == 3) {
        return -1;
    }
    
    // the piece is one row below blank
    return self.blankPos + 4;
}

-(void) makeUpMoveIfValid
{
    int move = [self upMove];
    if (move != -1) {
        [self moveBlankToPos:move];
    }
}

-(int) downMove
{
    // invalid move if blank is on top row
    if (self.blankPos / 4 == 0) {
        return -1;
    }
    
    // the piece is one row above blank
    return self.blankPos - 4;
}

-(void) makeDownMoveIfValid
{
    int move = [self downMove];
    if (move != -1) {
        [self moveBlankToPos:move];
    }
}


-(void) moveBlankToPos:(int) i
{
    // preparing to animate
    [self setBusy:YES];
    
    UIButton* blankButton = [self.board objectAtIndex:self.blankPos];
    UIButton* buttonToMove = [self.board objectAtIndex:i];
    CGPoint blankCenter = blankButton.center;
    
    [UIView animateWithDuration:.5 animations:^{
        
        // move button to blank area
        blankButton.center = buttonToMove.center;
        buttonToMove.center = blankCenter;
        
    } completion:^(BOOL finished) {
        
        // update the internal representation
        [self updateBoardAfterBlankToPos:i];

        // done animating, no longer busy
        [self setBusy:NO];
    }];
}

-(void) updateSolvedLabel
{
    if ([self isSolved]) {
        [[self labelSolved] setTextColor:[UIColor colorWithRed:0 green:130.0/255.0 blue:0 alpha:1.0]];
    }
    else {
        [[self labelSolved] setTextColor:[UIColor whiteColor]];
    }
}

-(BOOL) isSolved
{
    // check if the order of objects in board matches the solution board
    
    for (int i = 0; i < self.board.count; i++) {
        // one mismatch and we don't have a solved board
        if ([self.board objectAtIndex:i] != [self.solutionBoard objectAtIndex:i]) {
            return NO;
        }
    }
    
    return YES;
}

- (IBAction)resetBoard:(UIButton *)sender
{
    // preparing to animate
    [self setBusy:YES];

    NSMutableArray *points = [NSMutableArray arrayWithCapacity:16];
    
    // collect the centers for each position in order
    for (int i = 0; i < [self.board count]; i++) {
        
        CGPoint curPoint = [[self.board objectAtIndex:i] center];
        [points insertObject:[NSValue valueWithCGPoint:curPoint] atIndex:i];
        
    }
    
    [UIView animateWithDuration:2 animations:^{
        
        // go through each point in order, and set the center back to original value
        for (int i = 0; i < [self.solutionBoard count]; i++) {
            CGPoint newCenter = [[points objectAtIndex:i] CGPointValue];
            [[self.solutionBoard objectAtIndex:i] setCenter:newCenter];
            
        }
    } completion:^(BOOL finished) {
        
        // reflect changes in game board
        [self updateBoardAfterReset];
        
        // no longer busy
        [self setBusy:NO];
        
    }];
    
}

- (IBAction)shuffleBoard:(UIButton *)sender
{
    [self shuffleBoardHelper];
}

-(void)shuffleBoardHelper
{
    // continue shuffling until the slider is back at 0
    if ((int) self.shuffleSlider.value == 0) {
        return;
    }
    else {
        // add a task to the busy list
        self.busy++;
        
        int posToMove = [self posOfRandomNonBackwardsNeighborToBlank];

        UIButton* buttonToMove = [self.board objectAtIndex:posToMove];
        CGPoint blankCenter = self.buttonBlank.center;
        
        [UIView animateWithDuration:0.05 animations:^{
            
            //move button to blank position
            self.buttonBlank.center = buttonToMove.center;
            buttonToMove.center = blankCenter;

            self.shuffleSlider.value--;
            
        } completion:^(BOOL finished) {
            
            // update internal representation
            [self updateBoardAfterBlankToPos:posToMove];
            
            // task complete, remove from busy
            self.busy--;
            
            // animate the next move
            [self shuffleBoardHelper];
            
            
        }];
        
    }
}

-(void) updateBoardAfterReset
{
    [self setBoard:[NSMutableArray arrayWithArray:self.solutionBoard]];
    self.blankPos = 15;
    self.lastBlankPos = -1;
    [self updateSolvedLabel];
}

-(void) updateBoardAfterBlankToPos:(int) i
{
    [self.board exchangeObjectAtIndex:self.blankPos withObjectAtIndex:i];
    self.lastBlankPos = self.blankPos;
    self.blankPos = i;
    
    // display properly if board is now solved
    [self updateSolvedLabel];
}

-(int) posOfRandomNonBackwardsNeighborToBlank
{
    NSMutableArray *legalMoves = [NSMutableArray array];
    int move;
    
    // get the positions of each legal move and add to legalMoves array
    if ((move = [self leftMove]) != -1 && move != self.lastBlankPos) [legalMoves addObject:[NSNumber numberWithInt:move]];
    if ((move = [self rightMove]) != -1 && move != self.lastBlankPos) [legalMoves addObject:[NSNumber numberWithInt:move]];
    if ((move = [self upMove]) != -1 && move != self.lastBlankPos) [legalMoves addObject:[NSNumber numberWithInt:move]];
    if ((move = [self downMove]) != -1 && move != self.lastBlankPos) [legalMoves addObject:[NSNumber numberWithInt:move]];
    
    // return a random move from the legal moves
    return [[legalMoves objectAtIndex:arc4random_uniform(legalMoves.count)] integerValue];
}

@end

