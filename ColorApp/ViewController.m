//
//  ViewController.m
//  ColorApp
//
//  Created by Martyn Chamberlin on 8/7/14.
//  Copyright (c) 2014 Martyn Chamberlin. All rights reserved.
//

#import "ViewController.h"
#import "SliderView.h"

@interface ViewController () <SliderViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *circle;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.circle.layer.cornerRadius = self.circle.layer.bounds.size.width / 2;
    //self.scrollView.bounces = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)isScrollViewToBounce:(BOOL)isBounce {
    self.scrollView.bounces = isBounce;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [self isScrollViewToBounce];
//}


@end
