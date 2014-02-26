//
//  PCLView.m
//  ColorPicker
//
//  Created by Martyn Chamberlin on 2/25/14.
//  Copyright (c) 2014 Big Nerd Branch. All rights reserved.
//

#import "PCLView.h"

@implementation PCLView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
            NSLog(@"Self is %p", self);
    // 40 points padding on the left and right
    int padding = 20;
    int margin_top = 50;
    int width = self.bounds.size.width - (padding * 2);
    
    CGRect redFrame = CGRectMake(padding, 100, width, margin_top);
    PCLView *redView = [[ PCLView alloc] initWithFrame:redFrame ];
    // Initially set background color to light grey

    redView.backgroundColor = [UIColor colorWithRed:1
                                              green:1
                                               blue:1
                                              alpha:1.0];

    // Build the gradient
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGFloat locations[2] = { 0.0, 1.0 };
    
    CGFloat components[8] = {1.0, 0.0, 0.0, 1.0, // start at red
                            1.0, 1.0, 1.0, 1.0 }; // end at white
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents( colorspace, components, locations, 2);
    
    CGPoint startPoint = CGPointMake( 0, 0 );
    CGPoint endPoint = CGPointMake( 280, 0 );
    NSLog(@"%d", width);
    CGContextDrawLinearGradient( currentContext, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease( gradient );
    CGColorSpaceRelease( colorspace );
    
    // Make the red RGB box appear to the screen
    [self.window addSubview:redView];
}


@end
