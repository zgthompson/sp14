//
//  PentagoSubBoardViewController.m
//  PentagoStudentVersion
//
//  Created by AAK on 2/17/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "PentagoSubBoardViewController.h"
#import "PentagoBrain.h"

const int BORDER_WIDTH = 10;
const int TOP_MARGIN = 50;

@interface PentagoSubBoardViewController () {
    int subsquareNumber;
    int widthOfSubsquare;
}

@property (nonatomic, strong) PentagoBrain *pBrain;
@property (nonatomic, strong) UIImageView *gridImageView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGest;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipe;

@property (nonatomic) float curOrientation;

-(void) didTapTheView: (UITapGestureRecognizer *) tapObject;

@end

@implementation PentagoSubBoardViewController

-(UISwipeGestureRecognizer *) leftSwipe
{
    if( !_leftSwipe) {
        _leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(madeSwipe:)];
        [_leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    }
    
    return _leftSwipe;
}

-(UISwipeGestureRecognizer *) rightSwipe
{
    if( !_rightSwipe) {
        _rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(madeSwipe:)];
        [_rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    }
    
    return _rightSwipe;
}

-(void) madeSwipe: (UISwipeGestureRecognizer *) swipeObject {
    CGPoint p = [swipeObject locationInView:self.view];
    
    if (p.y >= widthOfSubsquare || p.x >= widthOfSubsquare) return;
    
    if (swipeObject.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self doRotationInDirection:-1];
    }
    else if (swipeObject.direction == UISwipeGestureRecognizerDirectionRight) {
        [self doRotationInDirection:1];
    }
}

-(void) doRotationInDirection:(int) direction
{
    if ([self.pBrain makeRotationIfValidOnBoard:subsquareNumber inDirection:direction]) {
        CGAffineTransform curTransform = self.gridImageView.layer.affineTransform;
        [UIView animateWithDuration:1 animations:^{
            CGAffineTransform newTransform = CGAffineTransformConcat(curTransform, CGAffineTransformMakeRotation((direction * M_PI)/2));
            self.gridImageView.layer.affineTransform = newTransform;
        }];
        
        self.curOrientation -= (direction * M_PI) / 2;
    }
}


-(UITapGestureRecognizer *) tapGest
{
    if( ! _tapGest ) {
        _tapGest = [[UITapGestureRecognizer alloc]
                    initWithTarget:self action:@selector(didTapTheView:)];
        
        [_tapGest setNumberOfTapsRequired:1];
        [_tapGest setNumberOfTouchesRequired:1];
    }
    return _tapGest;
}

-(PentagoBrain *) pBrain
{
    if( ! _pBrain )
        _pBrain = [PentagoBrain sharedInstance];
    return _pBrain;
}

-(UIImageView *) gridImageView
{
    if( ! _gridImageView ) {
        _gridImageView = [[UIImageView alloc] initWithFrame: CGRectZero];
    }
    return _gridImageView;
}

-(id) initWithSubsquare: (int) position
{
    // 0 1
    // 2 3
    if( (self = [super init]) == nil )
        return nil;
    subsquareNumber = position;
    // appFrame is the frame of the entire screen so that appFrame.size.width
    // and appFrame.size.height contain the width and the height of the screen, respectively.
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    widthOfSubsquare = ( appFrame.size.width - 3 * BORDER_WIDTH ) / 2;
    return self;
}


-(void) didTapTheView: (UITapGestureRecognizer *) tapObject
{
    // p is the location of the tap in the coordinate system of this view-controller's view (not the view of the
    // the view-controller that includes the subboards.)
    
    CGPoint p = [tapObject locationInView:self.view];
    
    if (p.y >= widthOfSubsquare || p.x >= widthOfSubsquare) return;
    
    float squareWidth = widthOfSubsquare / 3.0;
    
    int row = p.y / squareWidth;
    int col = p.x / squareWidth;
    
    if ([self.pBrain makeMoveIfValidOnBoard:subsquareNumber atRow:row andCol:col]) {
    
        // The board is divided into nine equally sized squares and thus width = height.
        NSString *imageName = [self.pBrain isPlayer1Turn] ? @"redMarble.png" : @"greenMarble.png";
    
        UIImageView *iView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        iView.frame = CGRectMake(col * squareWidth,
                                 row * squareWidth,
                                 squareWidth - BORDER_WIDTH / 3,
                                 squareWidth - BORDER_WIDTH / 3);
        
        CALayer *ballLayer = [CALayer layer];
        [ballLayer addSublayer:iView.layer];
        [ballLayer setFrame:CGRectMake(0, 0, widthOfSubsquare, widthOfSubsquare)];
        [ballLayer setAffineTransform:CGAffineTransformMakeRotation(self.curOrientation)];
        
        [self.gridImageView.layer addSublayer:ballLayer];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect ivFrame = CGRectMake(0, 0, widthOfSubsquare, widthOfSubsquare);
    self.gridImageView.frame = ivFrame;
    UIImage *image = [UIImage imageNamed:@"grid.png"];
    [self.gridImageView setImage:image];
    [self.view addSubview:self.gridImageView];
    [self.view addGestureRecognizer: self.tapGest];
    [self.view addGestureRecognizer:self.leftSwipe];
    [self.view addGestureRecognizer:self.rightSwipe];
    [self.view setBackgroundColor:[UIColor blackColor]];

    CGRect viewFrame = CGRectMake( (BORDER_WIDTH + widthOfSubsquare) * (subsquareNumber % 2) + BORDER_WIDTH,
                                  (BORDER_WIDTH + widthOfSubsquare) * (subsquareNumber / 2) + BORDER_WIDTH + TOP_MARGIN,
                                  widthOfSubsquare, widthOfSubsquare);
    self.view.frame = viewFrame;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
