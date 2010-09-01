//
//  RootViewController.m
//  GDD-Shiritori
//
//  Created by Tonny on 10/08/17.
//  Copyright genesix Inc. 2010. All rights reserved.
//

#import "RootViewController.h"
#import "AllData.h"
#import "WordTableViewController.h"


@implementation RootViewController

@synthesize dataArray;
@synthesize round;

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad{
    [super viewDidLoad];
    
    if (nil == dataArray) {
        // first round.
        // add computer's start point.
        WordObject *theStartWord = [[[AllData sharedAllData].headCharDict objectForKey:[[AllData sharedAllData].startWord substringToIndex:1]] objectAtIndex:0];
        theStartWord.used = YES;
        [[AllData sharedAllData].history addObject:theStartWord];
        round = 1;
        self.dataArray = [[AllData sharedAllData].headCharDict objectForKey:[theStartWord tailChar]];
    }
    
    if ((round % 2) == 0) {
        thePlayer = Player_GDD;
        self.tableView.backgroundColor = [UIColor lightGrayColor];
    }else {
        thePlayer = Player_You;
        self.tableView.backgroundColor = [UIColor whiteColor];
    }

    
    self.title = [NSString stringWithFormat:@"%@ Play(%d)", thePlayer==Player_You?@"You":@"GDD", round];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showHistory:)] autorelease];
    if (round == 1) {
        self.navigationItem.leftBarButtonItem = nil;
    }else {
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(goBack:)] autorelease];
    }

}

- (IBAction) popToRoot:(id)sender{
    while ([[AllData sharedAllData].history count] > 1) {
        WordObject *lastObj = [[AllData sharedAllData].history lastObject];
        lastObj.used = NO;
        [[AllData sharedAllData].history removeLastObject];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void) goBack:(id)sender{
    WordObject *lastWord = [[AllData sharedAllData].history lastObject];
    lastWord.used = NO;
    [[AllData sharedAllData].history removeLastObject];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) showHistory:(id)sender{
    WordTableViewController *historyView = [[WordTableViewController alloc] initWithNibName:@"WordTableViewController" bundle:nil];
    
//    historyView.dataArray = [AllData sharedAllData].history;
    historyView.round = self.round;
    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:historyView];
    
    [self presentModalViewController:navCon animated:YES];
    
    [historyView release];
    [navCon release];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

//- (void)viewWillDisappear:(BOOL)animated {
//	[super viewWillDisappear:animated];
//}

/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
    WordObject *aWord = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = aWord.word;
    if (aWord.used) {
        cell.textLabel.textColor = [UIColor grayColor];
    }else {
        cell.textLabel.textColor = [UIColor blackColor];
    }

    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", [[[AllData sharedAllData].headCharDict objectForKey:[aWord tailChar]] count]];
    if ([cell.detailTextLabel.text isEqualToString:@"0"]) {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }else {
        cell.detailTextLabel.textColor = [UIColor blueColor];
    }
    


    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WordObject *aWord = [dataArray objectAtIndex:indexPath.row];
    [[AllData sharedAllData].history addObject:aWord];
    aWord.used = YES;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.detailTextLabel.text isEqualToString:@"0"]) return;
    if (CGColorEqualToColor(cell.textLabel.textColor.CGColor, [UIColor grayColor].CGColor)) return;
    
    RootViewController *detailViewController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    detailViewController.dataArray = [[AllData sharedAllData].headCharDict objectForKey:[aWord tailChar]];
    detailViewController.round = self.round + 1;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [dataArray release];
    [super dealloc];
}


@end

