//
//  DetailedMovieViewController.m
//  CS470Feb27
//
//  Created by AAK on 3/6/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "DetailedMovieViewController.h"
#import "Movie.h"

@interface DetailedMovieViewController ()
@property(nonatomic) Movie *movie;
@end

@implementation DetailedMovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(instancetype) initWithMovie: (Movie *) movie
{
    if( (self = [super init]) == nil )
        return nil;
    
    self.movie = movie;
    return self;
}

- (void)viewDidLoad
{
    /*
     This is a quick (and to some extent hard-coded) demonstration of the use of a view-controller
     that gets pushed on the navigation stack as a result of having tapped a table-view cell.
     */
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSURL *url = [NSURL URLWithString: [self.movie imageNameForDetailedView]];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imageData];
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    CGRect frame = CGRectMake(50, 64,  appFrame.size.width - 100, 250);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = frame;
    [self.view addSubview:imageView];
    CGRect webFrame = CGRectMake(10, 320, appFrame.size.width - 20, 250);
    UIWebView *descWebView = [[UIWebView alloc] initWithFrame:webFrame];
    [descWebView loadHTMLString:[self.movie htmlDescriptionForDetailedView] baseURL:nil];
    [self.view addSubview:descWebView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
