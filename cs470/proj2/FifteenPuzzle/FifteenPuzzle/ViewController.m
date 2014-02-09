//
//  ViewController.m
//  FifteenPuzzle
//
//  Created by student on 2/8/14.
//  Copyright (c) 2014 zgt. All rights reserved.
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

// board state representation
@property (nonatomic) NSMutableArray *board;
@property (nonatomic) NSArray *solutionBoard;

// current position of the blank piece
@property (nonatomic) int blankPos;

// swipe recognizers
@property (nonatomic) UISwipeGestureRecognizer *leftSwipe;
@property (nonatomic) UISwipeGestureRecognizer *rightSwipe;
@property (nonatomic) UISwipeGestureRecognizer *upSwipe;
@property (nonatomic) UISwipeGestureRecognizer *downSwipe;

@property (weak, nonatomic) IBOutlet UISlider *shuffleSlider;

@property (nonatomic) BOOL animating;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // prepare the game board to play
    [self setUpGame];
    
    // register the swipe event handlers
    [self setUpSwipe];
    
    [self setUpShuffle];
    
    
}

-(void) setUpShuffle
{
    srand(time(NULL));

}

-(void) setUpGame
{
    // initialize the solution board
    [self setSolutionBoard:[NSArray arrayWithObjects:self.button1, self.button2, self.button3, self.button4, self.button5, self.button6, self.button7, self.button8, self.button9, self.button10, self.button11, self.button12, self.button13, self.button14, self.button15, self.buttonBlank, nil]];
    
    // copy solution board to start board
    [self setBoard:[NSMutableArray arrayWithArray:self.solutionBoard]];
    
    // blank starts at position 15
    self.blankPos = 15;
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
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self leftMoveIfValid];
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self rightMoveIfValid];
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionUp) {
        [self upMoveIfValid];
    }
    else {
        [self downMoveIfValid];
    }
}

-(BOOL) leftMoveIfValid
{
    // if the blank is on the leftmost column
    if (self.blankPos % 4 == 3) {
        return NO;
    }
    
    [self moveBlankToPos:self.blankPos+1];
    return YES;
}

-(BOOL) rightMoveIfValid
{
    // if the blank is on the rightmost column
    if (self.blankPos % 4 == 0) {
        return NO;
    }
    
    [self moveBlankToPos:self.blankPos-1];
    return YES;
}

-(BOOL) upMoveIfValid
{
    // if the blank is on the bottom row
    if (self.blankPos / 4 == 3) {
        return NO;
    }
    
    [self moveBlankToPos:self.blankPos+4];
    return YES;
}

-(BOOL) downMoveIfValid
{
    // if the blank is on the top row
    if (self.blankPos / 4 == 0) {
        return NO;
    }
    
    [self moveBlankToPos:self.blankPos-4];
    return YES;
    
}

-(void) moveBlankToPos:(int) i
{
    [self moveBlankToPos:i withDuration:0.5];
}

-(void) moveBlankToPos:(int) i withDuration:(NSTimeInterval) duration
{
    
    UIButton* blankButton = [self.board objectAtIndex:self.blankPos];
    UIButton* buttonToMove = [self.board objectAtIndex:i];
    CGPoint blankCenter = blankButton.center;
    
    // swap button to move with blank, animate it
    [UIView animateWithDuration:duration animations:^{
        blankButton.center = buttonToMove.center;
        buttonToMove.center = blankCenter;
    }];
    
    // update the internal representation
    [self.board exchangeObjectAtIndex:self.blankPos withObjectAtIndex:i];
    self.blankPos = i;
}


- (IBAction)resetBoard:(UIButton *)sender
{
    CGPoint points[self.board.count];
    for (int i = 0; i < [self.board count]; i++) {
        points[i] = [[self.board objectAtIndex:i] center];
    }
    
    //start recording animation
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    
    //reset all centers to original values
    for (int i = 0; i < [self.solutionBoard count]; i++) {
        [[self.solutionBoard objectAtIndex:i] setCenter:points[i]];
    }
    
    // play animation
    [UIView commitAnimations];
    
    // reflect changes in game board
    [self setBoard:[NSMutableArray arrayWithArray:self.solutionBoard]];
    self.blankPos = 15;
}

- (IBAction)shuffleBoard:(UIButton *)sender {
    int movesLeft = (int) self.shuffleSlider.value;
    int randomNum;
    
    while ( movesLeft ) {
        randomNum = rand() % 4;
        
        if (
            (randomNum == 0 && [self leftMoveIfValid]) ||
            (randomNum == 1 && [self rightMoveIfValid]) ||
            (randomNum == 2 && [self upMoveIfValid]) ||
            (randomNum == 3 && [self downMoveIfValid])
            ) {
            movesLeft--;
        }
    }
}

@end

