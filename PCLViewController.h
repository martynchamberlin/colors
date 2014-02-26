//
//  PCLViewController.h
//  ColorPicker
//
//  Created by Martyn Chamberlin on 2/25/14.
//  Copyright (c) 2014 Big Nerd Branch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCLViewController : UIViewController

- (void)updateBox:(UIView *)box startR:(float)startR startG:(float)startG startB:(float)startB finishR:(float)finishR finishG:(float)finishG finishB:(float)finishB;
- (bool)shouldAutorotate;

- (IBAction)moveRedSlider:(id)sender;
@end
