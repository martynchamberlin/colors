//
//  SliderView.h
//  ColorApp
//
//  Created by Martyn Chamberlin on 8/7/14.
//  Copyright (c) 2014 Martyn Chamberlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ViewController.h"

//  SliderView.h
@protocol SliderViewDelegate <NSObject>
@optional
- (void) isScrollViewToBounce:(BOOL)isBounce;
@end

@interface SliderView : UIView
@property (nonatomic, weak) id <SliderViewDelegate> sliderViewDelegate;
@end    