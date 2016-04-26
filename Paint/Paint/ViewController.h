//
//  ViewController.h
//  Paint
//
//  Created by William Grand on 4/20/16.
//  Copyright © 2016 William Grand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingView.h"

@interface ViewController : UIViewController
- (IBAction)colorButtonTouchUpInside:(id)sender;
- (IBAction)shareButtonTouchUpInside:(id)sender;

- (IBAction)clearButtonTouchUpInside:(id)sender;
@property (strong, nonatomic) IBOutlet DrawingView *drawingView;
@property (strong, nonatomic) IBOutlet UIView *toolBarView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) IBOutlet UIButton *colorButton;

@end

