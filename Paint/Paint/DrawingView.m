//
//  DrawingView.m
//  Paint
//
//  Created by William Grand on 4/20/16.
//  Copyright © 2016 William Grand. All rights reserved.
//

#import "DrawingView.h"

#define kDefaultLineColor       [UIColor blackColor]
#define kDefaultLineWidth       2.0f;
#define kDefaultLineAlpha       1.0f

@interface DrawingView() {
    
    CGPoint initialPoint;
    CGPoint currentPoint;
    CGPoint previousPoint1;
    CGPoint previousPoint2;
    UIBezierPath *path;

}

@property (nonatomic, strong) NSMutableArray *pathArray;
@property (nonatomic, strong) NSMutableArray *colorArray;
//@property (nonatomic, strong) id<ACEDrawingTool> currentTool;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) CGFloat originalFrameYPos;

@end



@implementation DrawingView

@synthesize pathArray;
@synthesize colorArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure
{
//    // init the private arrays
    self.pathArray = [NSMutableArray array];
    self.colorArray = [NSMutableArray array];
//
    // set the default values for the public properties
    self.lineColor = kDefaultLineColor;
    self.lineWidth = kDefaultLineWidth;
    self.lineAlpha = kDefaultLineAlpha;

}



#pragma mark - Drawing Methods
CGPoint midPoint(CGPoint p1, CGPoint p2)
{
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

- (void)drawRect:(CGRect)rect {
     
//    CGContextRef context = UIGraphicsGetCurrentContext();

     // create the path
//     CGPathMoveToPoint(path, NULL, previousPoint1.x, previousPoint1.y);
//     CGPathAddLineToPoint(path, NULL, currentPoint.x, currentPoint.y);
//     CGPathCloseSubpath(path);

    for (int i = 0; i < pathArray.count; i++)
    {

        // set the color, so long as the color exists
        if(colorArray.count > i)
            [[colorArray objectAtIndex:i] setStroke];
    
        // draw the path for that color
        [[pathArray objectAtIndex:i] strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];

    }

    
 }





#pragma mark - Touch Methods
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    // add the first touch
    UITouch *touch = [touches anyObject];
    
    previousPoint1 = [touch previousLocationInView:self];
    currentPoint = [touch locationInView:self];
    
    // set the first point in the line path
    initialPoint = currentPoint;
    
    // initialize path
    path = [[UIBezierPath alloc] init];
    
    // begin quad curve at midpoint
    [path moveToPoint:initialPoint];
//    CGPathMoveToPoint(path, NULL, initialPoint.x, initialPoint.y);

    // add the new path to path array
    [pathArray addObject:path];
    [colorArray addObject:self.lineColor];
//    path.lineWidth = kDefaultLineWidth;

}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // save all the touches in the path
    UITouch *touch = [touches anyObject];
    
    previousPoint2 = previousPoint1;
    previousPoint1 = [touch previousLocationInView:self];
    currentPoint = [touch locationInView:self];

    // get point between last two points
    CGPoint mid1 = midPoint(previousPoint1, previousPoint2);
    
    // get point between this point and last point
    CGPoint mid2 = midPoint(currentPoint, previousPoint1);
    
    // begin quad curve at midpoint
//    CGPathMoveToPoint(path, NULL, mid1.x, mid1.y);
    [path moveToPoint:mid1];
    
    // create quad curve from mid1 to previous point to mid2
    // use quad curve instead of line, otherwise strokes will have corners and will look more like polygons
//    CGPathAddQuadCurveToPoint(path, NULL, previousPoint1.x, previousPoint1.y, mid2.x, mid2.y);
    [path addQuadCurveToPoint:mid2 controlPoint:previousPoint1];

    [self setNeedsDisplay];
    
}

//
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // pass last touched to touchesMoved
    // this enables the artist to mark dots on the canvas
    [self touchesMoved:touches withEvent:event];
    
}
//
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
//    CFRelease (path);
}



@end
