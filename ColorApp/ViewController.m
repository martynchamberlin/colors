//
//  ViewController.m
//  ColorApp
//
//  Created by Martyn Chamberlin on 8/7/14.
//  Copyright (c) 2014 Martyn Chamberlin. All rights reserved.
//

#import "ViewController.h"
#import "SliderView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *circle;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *circleControl1;
@property (weak, nonatomic) IBOutlet UIView *circleControl2;
@property (weak, nonatomic) IBOutlet UIView *circleControl3;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.circle.layer.cornerRadius = self.circle.layer.bounds.size.width / 2;
    
    self.circleControl1.layer.cornerRadius = self.circleControl1.layer.bounds.size.width / 2;
    self.circleControl2.layer.cornerRadius = self.circleControl2.layer.bounds.size.width / 2;
    self.circleControl3.layer.cornerRadius = self.circleControl3.layer.bounds.size.width / 2;
    //self.scrollView.bounces = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)isScrollViewToBounce:(BOOL)isBounce {
    self.scrollView.bounces = isBounce;
}

@end
