//
//  TableVC.m
//  shadow_ios_oc
//
//  Created by shadowplus Thank on 2023/8/16.
//

#import "TableVC.h"

@interface TableVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray; // 数据源

@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataArray = [NSMutableArray arrayWithObjects:@"Item 1", @"Item 2", @"Item 3", nil];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    cell.textLabel.text = self.dataArray[indexPath.row];

    return cell;
}

#pragma mark - UITableViewDelegate

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建删除按钮
    UIContextualAction *deleteButton = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Delete" handler:^(UIContextualAction * _Nonnull action, UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        // 在此处显示确认删除提示，例如弹出UIAlertController
        [self showDeleteConfirmationAlertForIndexPath:indexPath];
        completionHandler(YES);
    }];

    deleteButton.backgroundColor = [UIColor redColor];

    // 将删除按钮添加到操作数组中
    UISwipeActionsConfiguration *configuration = [UISwipeActionsConfiguration configurationWithActions:@[deleteButton]];

    return configuration;
}

- (void)showDeleteConfirmationAlertForIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete Item" message:@"Are you sure you want to delete this item?" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        // 执行删除操作
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }];

    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 弹出底部弹窗
    [self showBottomPopupForIndexPath:indexPath];
}

- (void)showBottomPopupForIndexPath:(NSIndexPath *)indexPath {
    // 创建底部弹窗视图
    UIView *popupView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.bounds), CGRectGetWidth(self.view.bounds), 200)];
    popupView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:popupView];

    // 添加自定义内容，比如按钮、文本等
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmButton.frame = CGRectMake(20, 20, CGRectGetWidth(popupView.bounds) - 40, 44);
    [confirmButton setTitle:@"Confirm" forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [popupView addSubview:confirmButton];

    // 执行底部弹出动画
    [UIView animateWithDuration:0.3 animations:^{
        popupView.frame = CGRectMake(0, CGRectGetMaxY(self.view.bounds) - 200, CGRectGetWidth(self.view.bounds), 200);
    }];
}

- (void)confirmButtonTapped:(UIButton *)sender {
    // 执行确认操作，可以在这里删除数据等
    NSLog(@"Confirm button tapped");
    
    // 移除底部弹窗
    UIView *popupView = sender.superview;
    [UIView animateWithDuration:0.3 animations:^{
        popupView.frame = CGRectMake(0, CGRectGetMaxY(self.view.bounds), CGRectGetWidth(self.view.bounds), 200);
    } completion:^(BOOL finished) {
        [popupView removeFromSuperview];
    }];
}

@end
