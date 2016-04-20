//
//  DrawingView.h
//  Paint
//
//  Created by William Grand on 4/20/16.
//  Copyright © 2016 William Grand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingView : UIView

// public properties
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat lineAlpha;

// get the current drawing
@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, readonly) NSUInteger undoSteps;

@end
