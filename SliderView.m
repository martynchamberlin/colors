//
//  SliderView.m
//  ColorApp
//
//  Created by Martyn Chamberlin on 8/7/14.
//  Copyright (c) 2014 Martyn Chamberlin. All rights reserved.
//

#import "SliderView.h"

@interface SliderView()

@property (nonatomic) int xBeforeTouchesMoved;

@end

@implementation SliderView

// In order to determine how far a person has scrolled,
// we first need to track the x coordinate of their initial touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *anyTouch = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self.superview];
    self.xBeforeTouchesMoved = touchLocation.x;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *anyTouch = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self.superview];
    float distanceMoved = touchLocation.x - self.xBeforeTouchesMoved;
    CGRect rect = self.frame;
    rect.origin.x += distanceMoved;
    
    // As long as they aren't trying to scroll out of their screen allow the Slider to scroll along x axis
    if ( rect.origin.x >= 0 && rect.origin.x + self.frame.size.width <= self.superview.frame.size.width )
    {
        self.frame = rect;
    }
    
    self.xBeforeTouchesMoved = touchLocation.x;
}



@end
