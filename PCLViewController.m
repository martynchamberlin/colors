//
//  PCLViewController.m
//  ColorPicker
//
//  Created by Martyn Chamberlin on 2/25/14.
//  Copyright (c) 2014 Big Nerd Branch. All rights reserved.
//

#import "PCLViewController.h"

@interface PCLViewController ()

@property (nonatomic, weak) IBOutlet UIView *redView;
@property (nonatomic, weak) IBOutlet UILabel * redLabel;

@end

@implementation PCLViewController

- (void)updateBox:(UIView *)box colors:(CGFloat[8])colors
{
    UIGraphicsPushContext( UIGraphicsGetCurrentContext()  );
    
    // Build the gradient
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGFloat locations[2] = { 0.0, 1.0 };
    
    //CGFloat components[8] = {1.0, 0.0, 0.0, 1.0, // start at red
        //1.0, 1.0, 1.0, 1.0 }; // end at white
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents( colorspace, colors, locations, 2);
    
    CGPoint startPoint = CGPointMake( 0, 0 );
    CGPoint endPoint = CGPointMake( 280, 0);
    CGContextDrawLinearGradient( currentContext, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease( gradient );
    CGColorSpaceRelease( colorspace );
    
    box.backgroundColor = [UIColor blueColor];
    
    // Make the red RGB box appear to the screen
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
    self.redView.backgroundColor = [UIColor redColor];
    self.redLabel.text = @"Fail!";
    //CGFloat components[8] = {1.0, 0.0, 0.0, 1.0, // start at red
        //1.0, 1.0, 1.0, 1.0 }; // end at white

    //[self updateBox:self.redView colors:components];
    CAGradientLayer *redLayer = [CAGradientLayer layer];
    redLayer.frame = self.redView.bounds;
    redLayer.startPoint = CGPointMake(0, 0);
    redLayer.endPoint = CGPointMake(1, .5);
    redLayer.colors = [NSArray arrayWithObjects: (id)[[UIColor blueColor] CGColor], (id)[[UIColor greenColor] CGColor], nil];
    [self.redView.layer insertSublayer:redLayer atIndex:1];
    
    NSLog(@"Success");
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
