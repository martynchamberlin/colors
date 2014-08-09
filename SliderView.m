//
//  SliderView.m
//  ColorApp
//
//  Created by Martyn Chamberlin on 8/7/14.
//  Copyright (c) 2014 Martyn Chamberlin. All rights reserved.
//

#import "SliderView.h"
#import "AppDelegate.h"

@interface SliderView()

@property (nonatomic) int xBeforeTouchesMoved;

@property (nonatomic, strong) IBOutlet UIView * sliderControlRView;
@property (nonatomic, strong) IBOutlet UIView * sliderControlGView;
@property (nonatomic, strong) IBOutlet UIView * sliderControlBView;


@end

@implementation SliderView

 -(id)initWithCoder:(NSCoder*)coder
{
    self = [super initWithCoder:coder];
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
    float start = 30.0 + half_of_slider_width;
    float finish = self.superview.frame.size.width - start;
    
    float distance = ( touchLocation.x - start ) / ( finish - start );
    if ( distance < 0.0 ) { distance = 0.0; }
    else if ( distance > 1.0 ) { distance = 1.0; }
    NSLog( @"%f", distance);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    [(UIScrollView *)self.superview setBounces:YES];
    [(UIScrollView *)self.superview setScrollEnabled:YES];
}

@end
