//
//  SliderView.m
//  ColorApp
//
//  Created by Martyn Chamberlin on 8/7/14.
//  Copyright (c) 2014 Martyn Chamberlin. All rights reserved.
//

#import "SliderView.h"
#import "AppDelegate.h"
#import "ViewController.h"

@interface SliderView()

@property (nonatomic) int xBeforeTouchesMoved;

@property (nonatomic, weak) IBOutlet UIView * sliderControlRView;
@property (nonatomic, weak) IBOutlet UIView * sliderControlGView;
@property (nonatomic, weak) IBOutlet UIView * sliderControlBView;

@property (nonatomic, weak) IBOutlet UIView * circle;
@property (nonatomic, weak) IBOutlet UILabel * rgb;
@property (nonatomic, weak) IBOutlet UILabel * hex;
@end

@implementation SliderView

// These hold a value from 0.0 to 1.0
static float r = .5;
static float g = .5;
static float b = .5;

 -(id)initWithCoder:(NSCoder*)coder
{
    self = [super initWithCoder:coder];
    self.circle.layer.cornerRadius = self.circle.frame.size.width / 2; // not working, so doing it in the view controller
    
    [self updateRedControl];
    [self updateGreenControl];
    [self updateBlueControl];
    
    [(ViewController *)[self sliderViewDelegate] changeStuff];
    return self;

}

// In order to determine how far a person has scrolled,
// we first need to track the x coordinate of their initial touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [(UIScrollView *)self.superview setBounces:NO];
    [(UIScrollView *)self.superview setScrollEnabled:NO];
    
    UITouch *anyTouch = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self.superview];
    self.xBeforeTouchesMoved = touchLocation.x;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *anyTouch = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self.superview];
    float distanceMoved = touchLocation.x - self.xBeforeTouchesMoved;
    CGRect rect = [self.subviews.firstObject frame];
    rect.origin.x += distanceMoved;
    //NSLog( @"%f", distanceMoved);
    // As long as they aren't trying to scroll out of their screen allow the Slider to scroll along x axis. Also have 20 pixel padding left and right so the slider cannot go all the way to the edge of the screen
    int slider_padding = 20;
    if ( rect.origin.x >= slider_padding && rect.origin.x + rect.size.width + slider_padding <= self.superview.frame.size.width ) {
        [self.subviews.firstObject setFrame: rect];
       // NSLog(@"yes");
    }
    
    self.xBeforeTouchesMoved = touchLocation.x;
    
    // Now get value, from 0 to 1.0, that the slider exists. We don't get any
    // of this for free since we're using a custom control
    
    float half_of_slider_width = (int)[self.subviews.firstObject frame].size.width / 2;
    float currently_selected = [self.subviews.firstObject frame].origin.x + half_of_slider_width;
    
    // We want there to be a 10 pixel area where 0.0 or 1.0 (for left and right
    // respectively) don't change. This improves the UX imo
    float start = 30.0 + half_of_slider_width;
    float finish = self.superview.frame.size.width - start;

    float distance = ( currently_selected - start ) / ( finish - start );
    
    if ( distance < 0.0 ) { distance = 0.0; }
    else if ( distance > 1.0 ) { distance = 1.0; }
    
    if ( self.tag == 0 )
    {
        r = distance;
        [self updateGreenControl];
        [self updateBlueControl];
    }
    else if ( self.tag == 1 )
    {
        g = distance;
        [self updateRedControl];
        [self updateBlueControl];
    }
    else if ( self.tag == 2 )
    {
        b = distance;
        [self updateRedControl];
        [self updateGreenControl];
    }

    self.circle.backgroundColor = [[UIColor alloc] initWithRed:r green:g blue:b alpha:1.0];
}


- (void)updateRedControl
{
    [self updateBox:self.sliderControlRView.superview
             startR:0
             startG:g
             startB:b
            finishR:1
            finishG:g
            finishB:b ];
}
- (void) updateGreenControl
{
    [self updateBox:self.sliderControlGView.superview
             startR:r
             startG:0
             startB:b
            finishR:r
            finishG:1
            finishB:b ];
}
- (void)updateBlueControl
{
    
    [self updateBox:self.sliderControlBView.superview
             startR:r
             startG:g
             startB:0
            finishR:r
            finishG:g
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
    
    NSString *rr = [NSString stringWithFormat:@"%d", (int) (r * 255.0) ];
    NSString *gg = [NSString stringWithFormat:@"%d", (int) (g * 255) ];
    NSString *bb = [NSString stringWithFormat:@"%d", (int) (b * 255) ];
    NSMutableString *rgb = [[NSMutableString alloc] initWithString:rr];
    [rgb appendString:@"."];
    [rgb appendString:gg];
    [rgb appendString:@"."];
    [rgb appendString:bb];
    
    self.rgb.text = rgb;
    long long longlongred = (long long) (r * 255);
    long long longlonggreen = (long long) (g * 255);
    long long longlongblue = (long long) (b * 255);
    self.hex.text = [NSString stringWithFormat:@"%02llx%02llx%02llx", longlongred, longlonggreen, longlongblue];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    [(UIScrollView *)self.superview setBounces:YES];
    [(UIScrollView *)self.superview setScrollEnabled:YES];
}


@end
