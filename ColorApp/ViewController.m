//
//  ViewController.m
//  ColorApp
//
//  Created by Martyn Chamberlin on 8/7/14.
//  Copyright (c) 2014 Martyn Chamberlin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *circle;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.circle.layer.cornerRadius = 81;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
