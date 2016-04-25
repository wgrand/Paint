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

- (IBAction)clearButtonTouchUpInside:(id)sender;
@property (strong, nonatomic) IBOutlet DrawingView *drawingView;

@end

