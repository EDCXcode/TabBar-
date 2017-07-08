//
//  ViewController.m
//  TabBar左滑
//
//  Created by edc on 2017/6/28.
//  Copyright © 2017年 edc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)NSMutableArray *TabAry;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initFrame];
}


- (void)initFrame{
    
    _TabAry=[NSMutableArray arrayWithObjects:@"one",@"two",@"tree",@"four",@"five", nil];
    
    
    self.view.backgroundColor=[UIColor blackColor];
    
    UITableView *MYTabView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    MYTabView.dataSource=self;
    MYTabView.delegate=self;
    MYTabView.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:MYTabView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _TabAry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.text=_TabAry[indexPath.row];
    cell.textLabel.textColor=[UIColor greenColor];
    
    return cell;
}




//让tableView可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}




//左滑返回按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *deleteRowAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"Delete");
        //删除数据源
        [_TabAry removeObjectAtIndex:indexPath.row];
        //删除表格Cell
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    
    UITableViewRowAction *topRowAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Top" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"top");
        
        // 2. 更新UI
        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
        
    }];
    topRowAction.backgroundColor=[UIColor greenColor];
    
    
    
    UITableViewRowAction *moreRowAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"More" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"More");
        
    }];
    moreRowAction.backgroundColor=[UIColor blueColor];
    
    

    //返回按钮放到数组中
    return @[moreRowAction,deleteRowAction, topRowAction];
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}




















@end
