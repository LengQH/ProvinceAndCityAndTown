//
//  ViewController.m
//  ProvinceAndCityAndTown
//
//  Created by 冷求慧 on 16/12/27.
//  Copyright © 2016年 冷求慧. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark 跳转操作
- (IBAction)pushAction:(UIButton *)sender {
    SecondViewController *secVC=[self.storyboard instantiateViewControllerWithIdentifier:@"secondVC"];
    [self presentViewController:secVC animated:YES completion:nil];
}

@end
