//
//  SelectedFriendsTVC.m
//  BookClub
//
//  Created by Jamar Gibbs on 1/27/16.
//  Copyright © 2016 M1ndful M3d1a. All rights reserved.
//

#import "SelectedFriendsTVC.h"
#import "DatabaseFriendsTVC.h"
#import "Friends.h"
#import "Friends+CoreDataProperties.h"
#import "AppDelegate.h"

@interface SelectedFriendsTVC ()

@property NSMutableArray *selectedFriendsArray;
@property NSManagedObjectContext *moc;

@end

@implementation SelectedFriendsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedFriendsArray = [[NSMutableArray alloc]init];
    AppDelegate *appDelegate = [[UIApplication sharedApplication ]delegate];
    self.moc = appDelegate.managedObjectContext;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{

    

    [self loadFriend];
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectedFriendsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectedCell" forIndexPath:indexPath];
    cell.textLabel.text = [[self.selectedFriendsArray objectAtIndex:indexPath.row] name];
    return cell;
}

- (void)loadFriend{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Friends"];
    
    NSError *error;
    
    self.selectedFriendsArray = [[self.moc executeFetchRequest:request error:&error] mutableCopy];
    
    if (error == nil) {
        [self.tableView reloadData];
    } else {
        NSLog(@"AN ERROR OCCURRED");
    }
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
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    DatabaseFriendsTVC *dbfTVC = segue.destinationViewController;
    
}


@end
