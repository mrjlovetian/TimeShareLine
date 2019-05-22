//
//  ViewController.m
//  TimeShareLine
//
//  Created by MRJ on 2019/5/21.
//  Copyright © 2019 MRJ. All rights reserved.
//

#import "ViewController.h"
#import "GKListLoadViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}

- (void)click {
    GKListLoadViewController *vc = [GKListLoadViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
