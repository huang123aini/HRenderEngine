//
//  ViewController.m
//  HRenderEngine
//
//  Created by 黄世平 on 17/4/17.
//  Copyright © 2017年 黄世平. All rights reserved.
//

#import "ViewController.h"
#import "HGLKViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

   
    
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 150, 150)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"测试" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)playVideo
{
    
    HGLKViewController* viewC = [[HGLKViewController alloc] init];
    
    [self presentViewController:viewC animated:NO completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
