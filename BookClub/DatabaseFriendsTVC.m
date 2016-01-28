//
//  DatabaseFriendsTVC.m
//  BookClub
//
//  Created by Jamar Gibbs on 1/27/16.
//  Copyright © 2016 M1ndful M3d1a. All rights reserved.
//

#import "DatabaseFriendsTVC.h"
#import "Friends+CoreDataProperties.h"
#import "AppDelegate.h"
#import "Friends.h"

@interface DatabaseFriendsTVC ()
@property NSMutableArray *databaseFriendsArray;
@property NSMutableArray* dbSelectedFriends;
@property NSManagedObjectContext *moc;
@end

@implementation DatabaseFriendsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.databaseFriendsArray = [[NSMutableArray alloc]init];
    self.dbSelectedFriends = [[NSMutableArray alloc] init];
    [self grabData];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication ]delegate];
    self.moc = appDelegate.managedObjectContext;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{

//save to core data
    [self saveToCoreData];


}
-(void)saveToCoreData{
    

    for (int i = 0; i<self.dbSelectedFriends.count; i++) {
    
    Friends *friends = [NSEntityDescription insertNewObjectForEntityForName:@"Friends" inManagedObjectContext:self.moc];
    
        friends.name = [self.dbSelectedFriends objectAtIndex:i];
    
        
        NSError *error;
        
        if ([self.moc save:&error]) {
            
        } else {
            NSLog(@"%@",error);
        }
    }
    
    

    

    
    
}

-(void)grabData {
    NSString *urlString = [NSString stringWithFormat:@"https://s3.amazonaws.com/mmios8week/friends.json"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
        self.databaseFriendsArray = [NSJSONSerialization JSONObjectWithData:data options:0 error: nil];
        NSLog(@"%@",self.databaseFriendsArray[0]);
        [self.tableView reloadData];
    }];
    
    [task resume];



}




#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.databaseFriendsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DatabaseCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.databaseFriendsArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.backgroundColor == [UIColor greenColor]) {
        cell.backgroundColor = [UIColor whiteColor];
        [self.dbSelectedFriends removeObjectAtIndex:indexPath.row];
    }else{
        [self.dbSelectedFriends addObject:cell.textLabel.text];
        cell.backgroundColor = [UIColor greenColor];
    
    }

    
    NSLog(@"%@",cell.textLabel.text);
    NSLog(@"%lu",(unsigned long)self.dbSelectedFriends.count);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
