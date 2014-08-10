//
//  ViewController.m
//  ColorApp
//
//  Created by Martyn Chamberlin on 8/7/14.
//  Copyright (c) 2014 Martyn Chamberlin. All rights reserved.
//

#import "ViewController.h"
#import "SliderView.h"
#import "SliderView.h"

@interface ViewController () <SliderViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *circle;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *circleControl1;
@property (weak, nonatomic) IBOutlet UIView *circleControl2;
@property (weak, nonatomic) IBOutlet UIView *circleControl3;
@property (weak, nonatomic) IBOutlet SliderView *sliderControl1;
@property (weak, nonatomic) IBOutlet SliderView *sliderControl2;
@property (weak, nonatomic) IBOutlet SliderView *sliderControl3;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.sliderControl1 setSliderViewDelegate:self];
    
    self.circle.layer.cornerRadius = self.circle.layer.bounds.size.width / 2;
    self.circle.backgroundColor = [[UIColor alloc] initWithRed:.5 green:.5 blue:.5 alpha:1.0];
    
    self.circleControl1.layer.cornerRadius = self.circleControl1.layer.bounds.size.width / 2;
    self.circleControl2.layer.cornerRadius = self.circleControl2.layer.bounds.size.width / 2;
    self.circleControl3.layer.cornerRadius = self.circleControl3.layer.bounds.size.width / 2;
    //self.scrollView.bounces = NO;
//    
    [self updateRedControl];
    [self updateGreenControl];
    [self updateBlueControl];
    //[self changeStuff];
}

- (void)changeStuff
{
    self.sliderControl1.backgroundColor = [UIColor redColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)isScrollViewToBounce:(BOOL)isBounce {
    self.scrollView.bounces = isBounce;
}

- (void)updateRedControl
{
    [self updateBox:self.sliderControl1
             startR:0
             startG:.5
             startB:.5
            finishR:1
            finishG:.5
            finishB:.5 ];
}
- (void) updateGreenControl
{
    [self updateBox:self.sliderControl2
             startR:.5
             startG:0
             startB:.5
            finishR:.5
            finishG:1
            finishB:.5 ];
}
- (void)updateBlueControl
{
    
    [self updateBox:self.sliderControl3
             startR:.5
             startG:.5
             startB:0
            finishR:.5
            finishG:.5
            finishB:1];
}

- (void)updateBox:(UIView *)view startR:(float)startR startG:(float)startG startB:(float)startB finishR:(float)finishR finishG:(float)finishG finishB:(float)finishB
{
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    gradientLayer.startPoint = CGPointMake(.1, 0);
    gradientLayer.endPoint = CGPointMake(.9, 0);
    
    UIColor *startColor = [UIColor colorWithRed:startR
                                          green:startG
                                           blue:startB
                                          alpha:1.0];
    UIColor *finishColor = [UIColor colorWithRed:finishR
                                           green:finishG
                                            blue:finishB
                                           alpha:1.0];
    gradientLayer.colors = [NSArray arrayWithObjects: (id)[startColor CGColor],(id)[finishColor CGColor], nil];
    CALayer *circle = [view.subviews.firstObject layer];
    // Annoying this code kills the app at runtime, because without it, I'm convinced this is the reason it hogs up
    // more memory than it should
    //    for (CALayer *layer in view.layer.sublayers) {
    //        [layer removeFromSuperlayer];
    //   }
    [view.layer addSublayer: gradientLayer];
    [view.layer addSublayer: circle];
    
}


@end
