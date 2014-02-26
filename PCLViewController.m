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

// Store previous layer, so we can remove them and save memory
@property (nonatomic, strong) CAGradientLayer *redLayer;
@property (nonatomic, strong) CAGradientLayer *greenLayer;
@property (nonatomic, strong) CAGradientLayer *blueLayer;

@end

@implementation PCLViewController

// Force the application to stay in portrait mode
- (bool)shouldAutorotate
{
    return false;
}

- (void)updateRedControl
{
    [self updateBox:self.redView
             startR:0
             startG:self.greenSlider.value
             startB:self.blueSlider.value
            finishR:1
            finishG:self.greenSlider.value
            finishB:self.blueSlider.value ];
}
- (void) updateGreenControl
{
    [self updateBox:self.greenView
             startR:self.redSlider.value
             startG:0
             startB:self.blueSlider.value
            finishR:self.redSlider.value
            finishG:1
            finishB:self.blueSlider.value ];
}
- (void)updateBlueControl
{
    
    [self updateBox:self.blueView
             startR:self.redSlider.value
             startG:self.greenSlider.value
             startB:0
            finishR:self.redSlider.value
            finishG:self.greenSlider.value
            finishB:1];
}
- (void)updateInputs
{
    self.redInput.text = [NSString stringWithFormat:@"%d", (int) (self.redSlider.value * 255) ];
    self.greenInput.text = [NSString stringWithFormat:@"%d", (int) (self.greenSlider.value * 255) ];
    self.blueInput.text = [NSString stringWithFormat:@"%d", (int) (self.blueSlider.value * 255) ];
    long long longlongred = (long long) (self.redSlider.value * 255);
    long long longlonggreen = (long long) (self.greenSlider.value * 255);
    long long longlongblue = (long long) (self.blueSlider.value * 255);
    self.hexInput.text = [NSString stringWithFormat:@"%llx%llx%llx", longlongred, longlonggreen, longlongblue];
}

// This event fires when the user changes any of the sliders
- (IBAction)moveAnySlider:(id)sender
{
    UIColor * currentColor = [UIColor colorWithRed:self.redSlider.value green:self.greenSlider.value blue:self.blueSlider.value alpha:1];
    
    self.colorBox.backgroundColor = currentColor;
    [self updateInputs];
}
- (IBAction)moveRedSlider:(id)sender
{
    [self updateGreenControl];
    [self updateBlueControl];
}

- (IBAction)moveGreenSlider:(id)sender
{
    [self updateRedControl];
    [self updateBlueControl];
}

- (IBAction)moveBlueSlider:(id)sender
{
    [self updateRedControl];
    [self updateGreenControl];
}


- (void)updateBox:(UIView *)box startR:(float)startR startG:(float)startG startB:(float)startB finishR:(float)finishR finishG:(float)finishG finishB:(float)finishB
{
    self.colorBox.layer.cornerRadius = 65;
    self.colorBox.layer.masksToBounds = true;
    
    // Initial setup is the same for the three boxes
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
    
    // Check to see if a layer already exists
    bool previousLayer = false;
    if ( [box tag] == 1 ) // box is red
    {
        if (self.redLayer != nil )
        {
            [box.layer replaceSublayer:self.redLayer with:self.gradientLayer];
            previousLayer = true;
        }
        [self setRedLayer:self.gradientLayer];
    }
    else if ( box.tag == 2 ) // box is green
    {
        if ( self.greenLayer != nil )
        {
            [box.layer replaceSublayer:self.greenLayer with:self.gradientLayer];
            previousLayer = true;
        }
        [self setGreenLayer:self.gradientLayer];
    }
    else if ( [box tag] == 3 ) // box is blue
    {
        if ( self.blueLayer != nil )
        {
            [box.layer replaceSublayer:self.blueLayer with:self.gradientLayer];
            previousLayer = true;
        }
        [self setBlueLayer:self.gradientLayer];
    }

    if ( ! previousLayer)
    {
        [box.layer addSublayer:self.gradientLayer];
    }
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
    
    [self updateRedControl];
    [self updateGreenControl];
    [self updateBlueControl];
    [self updateInputs];
    
    self.redView.backgroundColor = [UIColor purpleColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
