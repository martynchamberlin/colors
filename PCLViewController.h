//
//  PCLViewController.h
//  ColorPicker
//
//  Created by Martyn Chamberlin on 2/25/14.
//  Copyright (c) 2014 Big Nerd Branch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCLViewController : UIViewController

- (void)updateBox:(UIView *)box startR:(int)startR startG:(int)startG startB:(int)startB finishR:(int)finishR finishG:(int)finishG finishB:(int)finishB;
- (bool)shouldAutorotate;
@end
