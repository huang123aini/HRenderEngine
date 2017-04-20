//
//  HDemosVc.m
//  HEngine_VR
//
//  Created by 黄世平 on 17/3/21.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "HDemosVc.h"


@interface HDemosVc ()

@end

@implementation HDemosVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    demoArrays = [NSMutableArray new];
    
    NSString* demo1 = @"AVPlayer测试";
    [demoArrays addObject:demo1];
    
}

#pragma mark -------TableViewController-------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [demoArrays count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"CellTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             CellTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellTableIdentifier];
    }
    
    cell.textLabel.text = [demoArrays objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController* viewC;
    switch (indexPath.row)
    {
        case 0:
        {
            //viewC = [HAVPlayerTest new];
            break;
        }
      
        default:
            break;
    }
    [self presentViewController:viewC animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
