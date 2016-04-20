//
//  DrawingView.m
//  Paint
//
//  Created by William Grand on 4/20/16.
//  Copyright © 2016 William Grand. All rights reserved.
//

#import "DrawingView.h"

#define kDefaultLineColor       [UIColor blackColor]
#define kDefaultLineWidth       10.0f;
#define kDefaultLineAlpha       1.0f

@interface DrawingView() {
    
    CGPoint initialPoint;
    CGPoint currentPoint;
    CGPoint previousPoint1;
    CGPoint previousPoint2;

}

@property (nonatomic, strong) NSMutableArray *pathArray;
@property (nonatomic, strong) NSMutableArray *bufferArray;
//@property (nonatomic, strong) id<ACEDrawingTool> currentTool;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) CGFloat originalFrameYPos;

@end



@implementation DrawingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self configure];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        [self configure];
    }
    return self;
}

- (void)configure
{
    // init the private arrays
    self.pathArray = [NSMutableArray array];
    self.bufferArray = [NSMutableArray array];
    
    // set the default values for the public properties
    self.lineColor = kDefaultLineColor;
    self.lineWidth = kDefaultLineWidth;
    self.lineAlpha = kDefaultLineAlpha;
    
//    self.drawMode = ACEDrawingModeOriginalSize;
    
    // set the transparent background
    self.backgroundColor = [UIColor clearColor];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


#pragma mark - Drawing Methods





#pragma mark - Touch Methods
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    // add the first touch
    UITouch *touch = [touches anyObject];
    
    previousPoint1 = [touch previousLocationInView:self];
    currentPoint = [touch locationInView:self];
    
    NSLog (@"lastPoint = %f, %f; currentPoint = %f, %f", previousPoint1.x, previousPoint1.y, currentPoint.x, currentPoint.y);
    
    // init the bezier path
//    self.currentTool = [self toolWithCurrentSettings];
//    self.currentTool.lineWidth = self.lineWidth;
//    self.currentTool.lineColor = self.lineColor;
//    self.currentTool.lineAlpha = self.lineAlpha;
    
    
    
//    [self.pathArray addObject:self.currentTool];
    
    // set the first point in the line path
    initialPoint = currentPoint;
    
//    // call the delegate
//    if ([self.delegate respondsToSelector:@selector(drawingView:willBeginDrawUsingTool:)]) {
//        [self.delegate drawingView:self willBeginDrawUsingTool:self.currentTool];
//    }
}


@end
