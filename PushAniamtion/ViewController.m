//
//  ViewController.m
//  PushAniamtion
//
//  Created by 雷祥 on 2017/7/26.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "ViewController.h"
#import "PushedViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pushClick:(id)sender {
    PushedViewController *pushedVC = [[PushedViewController alloc] init];
    [self.navigationController pushViewController:pushedVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
