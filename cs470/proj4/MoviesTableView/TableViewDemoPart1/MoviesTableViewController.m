//
//  MoviesTableViewController.m
//  CS470Feb27
//
//  Created by AAK on 2/27/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "MoviesTableViewController.h"
#import "SchemaDataSource.h"
#import "DetailedMovieViewController.h"

static BOOL _debug = NO;

@interface MoviesTableViewController ()

@property(nonatomic) SchemaDataSource *dataSource;
@property(nonatomic) MoviesDataSource *moviesDataSource;
@property(nonatomic) UIActivityIndicatorView *activityIndicator;


@end

static NSString *CellIdentifier = @"Cell";

@implementation MoviesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [[SchemaDataSource sharedInstance] addObserver: self
                                            forKeyPath: @"dataSourceReady"
                                               options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                                               context:nil];
        UIImage *tabImage = [UIImage imageNamed:@"movieTabBarImage.png"];
        self.tabBarItem.image = tabImage;
        self.title = @"Movies";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];

    
    self.dataSource = [SchemaDataSource sharedInstance];

    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.activityIndicator setCenter: self.view.center];
    [self.view addSubview: self.activityIndicator];

    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.moviesDataSource = [[SchemaDataSource sharedInstance] moviesDataSource];
    [self.tableView reloadData];
    if( _debug ) NSLog(@"Observer called.");
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
    if( ! [self.dataSource dataSourceReady] ) {
        [self.activityIndicator startAnimating];
        [self.activityIndicator setHidesWhenStopped: YES];
    }
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    // NSLog(@"Number of rows in the table: %d", [self.moviesDataSource numberOfMovies]);
    return [self.moviesDataSource numberOfMovies];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Movie *movie = [self.moviesDataSource movieAtIndex:[indexPath row]];
    // Configure the cell...
    cell.textLabel.text = [movie title];
    return cell;
}

-(void) refreshTableView: (UIRefreshControl *) sender
{
    [self.tableView reloadData];
    [sender endRefreshing];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.moviesDataSource deleteMovieAtIndex:[indexPath row]];
    [self.tableView deleteRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationAutomatic];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // deselect a selected row when it is tapped for the second time.
    if( [self.tableView cellForRowAtIndexPath:indexPath].selected ) {
        [self.tableView deselectRowAtIndexPath: indexPath animated:YES];
        return nil;
    }
    return indexPath;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Did select row %d", [indexPath row] );
    Movie *movie = [self.moviesDataSource movieAtIndex:[indexPath row]];
    DetailedMovieViewController *dc = [[DetailedMovieViewController alloc] initWithMovie: movie];
    [self.navigationController pushViewController:dc animated:YES];
}
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
