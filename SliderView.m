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
@property float r;
@property float g;
@property float b;

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
        [self updateGreenControl];
        [self updateBlueControl];
    }
    else if ( self.tag == 1 )
    {
        [self updateRedControl];
        [self updateBlueControl];
    }
    else if ( self.tag == 2 )
    {
        [self updateRedControl];
        [self updateGreenControl];
    }
    
    NSLog( @"%f", distance);
}


- (void)updateRedControl
{
    [self updateBox:0
             startG:self.r
             startB:self.g
            finishR:1
            finishG:self.g
            finishB:self.b ];
}
- (void) updateGreenControl
{
    [self updateBox:self.r
             startG:0
             startB:self.g
            finishR:self.r
            finishG:1
            finishB:self.g ];
}
- (void)updateBlueControl
{
    
    [self updateBox:self.r
             startG:self.g
             startB:0
            finishR:self.r
            finishG:self.g
            finishB:1];
}

- (void)updateBox:(float)startR startG:(float)startG startB:(float)startB finishR:(float)finishR finishG:(float)finishG finishB:(float)finishB
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    [(UIScrollView *)self.superview setBounces:YES];
    [(UIScrollView *)self.superview setScrollEnabled:YES];
}

@end
