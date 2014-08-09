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
    [(UIScrollView *)self.superview setBounces:NO];
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
    NSLog( @"%f", distanceMoved);
    // As long as they aren't trying to scroll out of their screen allow the Slider to scroll along x axis
    if ( rect.origin.x >= 0 && rect.origin.x + rect.size.width <= self.superview.frame.size.width ) {
        [self.subviews.firstObject setFrame: rect];
        NSLog(@"yes");
    }
    
    self.xBeforeTouchesMoved = touchLocation.x;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [(UIScrollView *)self.superview setBounces:YES];
    [(UIScrollView *)self.superview setScrollEnabled:YES];
}

@end
