//
//  ViewController.m
//  TableViewDemoPart1
//
//  Created by AAK on 3/7/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"movieTheater.png"];
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    [self.viewOfController addSubview:iv];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
