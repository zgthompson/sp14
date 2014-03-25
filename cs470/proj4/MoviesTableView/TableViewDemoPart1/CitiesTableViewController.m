//
//  CitiesTableViewController.m
//  TableViewDemoPart1
//
//  Created by student on 3/24/14.
//  Copyright (c) 2014 Ali Kooshesh. All rights reserved.
//

#import "CitiesTableViewController.h"
#import "SchemaDataSource.h"
#import "MoviesAtTheaterTableViewController.h"

@interface CitiesTableViewController ()

@property (nonatomic) SchemaDataSource *dataSource;
@property (nonatomic) CitiesDataSource *citiesDataSource;
@property (nonatomic) TheatersDataSource *theatersDataSource;
@property (nonatomic) MoviesAtTheatersDataSrouce *matDataSource;
@property (nonatomic) UIActivityIndicatorView *activityIndicator;

@end

static NSString *CellIdentifier = @"Cell";

@implementation CitiesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UIImage *tabImage = [UIImage imageNamed:@"cityTabBarImage.png"];
        self.tabBarItem.image = tabImage;
        self.title = @"City";
        [[SchemaDataSource sharedInstance] addObserver:self forKeyPath:@"dataSourceReady" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
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
    [self.activityIndicator setCenter:self.view.center];
    [self.view addSubview:self.activityIndicator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.citiesDataSource = [[SchemaDataSource sharedInstance] citiesDataSource];
    self.theatersDataSource = [[SchemaDataSource sharedInstance] theatersDataSource];
    self.matDataSource = [[SchemaDataSource sharedInstance] moviesAtTheatersDataSource];
    [self.tableView reloadData];
    [self.activityIndicator stopAnimating];
}

-(void) refreshTableView: (UIRefreshControl *) rControl
{
    if ( [self.dataSource dataSourceReady] ) {
        [self.tableView reloadData];
    }
    [rControl endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.citiesDataSource numberOfCities];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString* cityName = [[self.citiesDataSource cityAtIndex:section] cityName];
    return [self.theatersDataSource numberOfTheatersForCity:cityName];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if( section == 0 )
        return 100;
    return 0;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.citiesDataSource cityAtIndex:section] cityName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString* cityName = [[self.citiesDataSource cityAtIndex:[indexPath section]] cityName];
    Theater* theater = [self.theatersDataSource theaterAtIndex:[indexPath row] forCity:cityName];
    cell.textLabel.text = [theater theaterName];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cityName = [[self.citiesDataSource cityAtIndex:[indexPath section]] cityName];
    NSString* theaterName = [[self.theatersDataSource theaterAtIndex:[indexPath row] forCity:cityName] theaterName];
    
    NSArray* movies = [self.matDataSource moviesForTheater:theaterName inCity:cityName];
    
    MoviesAtTheaterTableViewController *matc = [[MoviesAtTheaterTableViewController alloc] initWithStyle:UITableViewStylePlain andMovies:movies];
    [self.navigationController pushViewController:matc animated:YES];
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
