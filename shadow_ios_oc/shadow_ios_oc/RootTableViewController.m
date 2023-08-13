//
//  RootTableViewController.m
//  shadow_ios_oc
//
//  Created by shadowplus Thank on 2023/8/12.
//

#import "RootTableViewController.h"

#import "GifViewController.h"
#import "CircularArcViewController.h"
#import "CircleArcVC2.h"

#define CellIndentifier @"CellIndentifier"

@interface RootTableViewController ()

@property (nonatomic) NSArray *children;

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // data
    GifViewController *gifVC = [[GifViewController alloc] init];
    CircularArcViewController *arcVC = [[CircularArcViewController alloc] init];
    CircleArcVC2 *arcVC2 = [[CircleArcVC2 alloc] init];
    self.children = @[
        @{@"name": @"gifVC",@"controller": gifVC},
        @{@"name": @"arcVC",@"controller": arcVC},
        @{@"name": @"arcVC2",@"controller": arcVC2},
    ];
    
    // cell register
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIndentifier];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.children count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.children[indexPath.row][@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:self.children[indexPath.row][@"controller"] animated:true];
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
