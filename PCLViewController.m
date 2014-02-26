//
//  PCLViewController.m
//  ColorPicker
//
//  Created by Martyn Chamberlin on 2/25/14.
//  Copyright (c) 2014 Big Nerd Branch. All rights reserved.
//

#import "PCLViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PCLViewController ()

@property (nonatomic, weak) IBOutlet UIView *redView;
@property (nonatomic, weak) IBOutlet UIView *greenView;
@property (nonatomic, weak) IBOutlet UIView *blueView;
@property (nonatomic, weak) IBOutlet UIView *colorBox;
@property (nonatomic, weak) IBOutlet UISlider *redSlider;
@property (nonatomic, weak) IBOutlet UISlider *greenSlider;
@property (nonatomic, weak) IBOutlet UISlider *blueSlider;
@property (nonatomic, weak) IBOutlet UITextField *redInput;
@property (nonatomic, weak) IBOutlet UITextField *greenInput;
@property (nonatomic, weak) IBOutlet UITextField *blueInput;
@property (nonatomic, weak) IBOutlet UITextField *hexInput;
@property (nonatomic, strong) CAGradientLayer * gradientLayer;

@end

@implementation PCLViewController

// Force the application to stay in portrait mode
- (bool)shouldAutorotate
{
    return false;
}

- (void)updateBox:(UIView *)box startR:(int)startR startG:(int)startG startB:(int)startB finishR:(int)finishR finishG:(int)finishG finishB:(int)finishB
{

    
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = box.bounds;
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(1, 0);
    
    UIColor *startColor = [UIColor colorWithRed:startR
                                         green:startG
                                          blue:startB
                                           alpha:1.0];
    UIColor *finishColor = [UIColor colorWithRed:finishR
                                          green:finishG
                                           blue:finishB
                                          alpha:1.0];

    self.gradientLayer.colors = [NSArray arrayWithObjects: (id)[startColor CGColor],(id)[finishColor CGColor], nil];
                                 
    [box.layer insertSublayer:self.gradientLayer atIndex:1];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Make z index high up because otherwise they get lost underneath
    // the gradients
    self.redSlider.layer.zPosition = 100;
    self.greenSlider.layer.zPosition = 100;
    self.blueSlider.layer.zPosition = 100;
    

    
    [self updateBox:self.redView startR:0 startG:0 startB:0 finishR:1 finishG:0 finishB:0];
    
    
    NSLog(@"Success");
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
