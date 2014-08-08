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
@property (nonatomic) bool resetX;

@end

@implementation SliderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)SliderView
{
    self.resetX = true;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   //NSLog( @"things are happening");
    UITouch *anyTouch = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self.superview];
    self.xBeforeTouchesMoved = touchLocation.x;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    float currentSliderX = self.frame.origin.x;
    UITouch *anyTouch = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self.superview];
//    if ( ! self.resetX )
//    {
        float distanceMoved = touchLocation.x - self.xBeforeTouchesMoved;
    NSLog ( @"Distance moved is %f", distanceMoved);
    //NSLog( @"%f", distanceMoved );
        // TODO: make sure this doesn't equal 0
        CGRect rect = self.frame;
        rect.origin.x += distanceMoved;
        self.frame = rect;
//    }
    self.xBeforeTouchesMoved = touchLocation.x;
//    self.resetX = true;
}



@end
