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
@property (assign) id <AppDelegate> delegate;

@property (nonatomic) int xBeforeTouchesMoved;

@property (nonatomic, strong) IBOutlet UIView * sliderControlRView;
@property (nonatomic, strong) IBOutlet UIView * sliderControlGView;
@property (nonatomic, strong) IBOutlet UIView * sliderControlBView;


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
    CGRect rect = [[self getThing:self.tag] frame];
    rect.origin.x += distanceMoved;
    NSLog( @"%f", distanceMoved);
    // As long as they aren't trying to scroll out of their screen allow the Slider to scroll along x axis
    if ( rect.origin.x >= 0 && rect.origin.x + rect.size.width <= self.superview.frame.size.width ) {
        [[self getThing:self.tag] setFrame: rect];
        NSLog(@"yes");
    }
    
    self.xBeforeTouchesMoved = touchLocation.x;
}

// Man, this is redneck
-(UIView *)getThing:(NSUInteger)tag{
    if ( tag == 0 )
    {
        return self.sliderControlRView;
    }
    else if ( tag == 1 )
    {
        return self.sliderControlGView;
    }
    else // if ( tag == 2)
    {
        return self.sliderControlBView;
    }
}

@end
