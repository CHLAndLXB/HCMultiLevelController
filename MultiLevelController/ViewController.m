//
//  ViewController.m
//  MultiLevelController
//
//  Created by changhailuo on 2018/2/23.
//  Copyright © 2018年 changhailuo. All rights reserved.
//

#import "ViewController.h"

#import "IOLevelView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    IOLevelView * view = [[IOLevelView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
