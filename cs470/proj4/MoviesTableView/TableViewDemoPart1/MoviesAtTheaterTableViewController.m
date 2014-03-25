//
//  MoviesAtTheaterTableViewController.m
//  TableViewDemoPart1
//
//  Created by student on 3/25/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "MoviesAtTheaterTableViewController.h"
#import "MovieAtTheater.h"
#import "SchemaDataSource.h"
#import "MoviesDataSource.h"
#import "ShowtimesDataSource.h"
#import "DetailedMovieViewController.h"

@interface MoviesAtTheaterTableViewController ()

@property (nonatomic) NSArray *movies;
@property (nonatomic) MoviesDataSource *moviesDataSource;
@property (nonatomic) ShowtimesDataSource *showtimesDataSource;

@end

static NSString *CellIdentifier = @"Cell";

@implementation MoviesAtTheaterTableViewController

- (id)initWithStyle:(UITableViewStyle)style andMovies:(NSArray *)movies
{
    self = [super initWithStyle:style];
    if (self) {
        self.movies = movies;
        SchemaDataSource *dataSource = [SchemaDataSource sharedInstance];
        self.moviesDataSource = [dataSource moviesDataSource];
        self.showtimesDataSource = [dataSource showtimesDataSource];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.movies count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    MovieAtTheater* curMat = [self.movies objectAtIndex:[indexPath row]];
    Movie* movie = [self.moviesDataSource movieWithTitle:[curMat movieName]];
    NSString *timeString = [self.showtimesDataSource showtimeStringForMovie:curMat.movieName atTheater:curMat.theaterName];
    
    UILabel *label = nil;
    if( cell.tag != 45 ) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 220, 60)];
        label.tag = 10;
        [label setNumberOfLines: 0];
        [label setAttributedText:[movie descriptionForListEntry]];
        
        [cell.contentView addSubview:label];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 300, 20)];
        timeLabel.tag = 15;
        [timeLabel setText:timeString];
        
        [cell.contentView addSubview:timeLabel];
        
        cell.tag = 45;
        UIImage *img = [movie imageForListEntry];
        UIImageView *iv = [[UIImageView alloc] initWithImage:img];
        iv.tag = 20;
        iv.frame = CGRectMake(10, 5, 50, 60);
        
        [cell.contentView addSubview:iv];
    } else {
        for( id object in cell.contentView.subviews ) {
            if( [object isKindOfClass:[UILabel class]] ) {
                label = (UILabel *) object;
                if ( label.tag == 10 ) {
                    [label setAttributedText:[movie descriptionForListEntry]];
                }
                else if ( label.tag == 15 ) {
                    [label setText:timeString];
                }
            }
            else if( [object isKindOfClass:[UIImageView class]] )
                [(UIImageView *) object setImage:[movie imageForListEntry]];
        }
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Did select row %d", [indexPath row] );
    MovieAtTheater* curMat = [self.movies objectAtIndex:[indexPath row]];
    Movie* movie = [self.moviesDataSource movieWithTitle:[curMat movieName]];
    DetailedMovieViewController *dc = [[DetailedMovieViewController alloc] initWithMovie: movie];
    [self.navigationController pushViewController:dc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
