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
        
    CGPoint currentPoint;
    CGPoint previousPoint1;
    CGPoint previousPoint2;
    UIBezierPath *path;

}

@property (nonatomic, strong) NSMutableArray *pathArray;
@property (nonatomic, strong) NSMutableArray *colorArray;

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
    
    // initialize arrays that retain the drawing history
    self.pathArray = [NSMutableArray array];
    self.colorArray = [NSMutableArray array];

    // set the default values for the public properties
    self.lineColor = kDefaultLineColor;
    self.lineWidth = kDefaultLineWidth;
    self.lineAlpha = kDefaultLineAlpha;

}



#pragma mark - Drawing Methods
CGPoint getMidPoint(CGPoint point1, CGPoint point2)
{
    return CGPointMake(0.5*(point1.x + point2.x), 0.5*(point1.y + point2.y));
}

- (void)drawRect:(CGRect)rect {

    for (int i = 0; i < pathArray.count; i++)
    {

        // set the color, so long as the color exists
        if(colorArray.count > i)
            [[colorArray objectAtIndex:i] setStroke];
        
        // draw the path for that color
        [[pathArray objectAtIndex:i] strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
        
    }
    
 }

- (void) clearDrawing
{
    
    /* fade the drawing gracefully before disposing it */
    
    [CATransaction begin];
    
    // create the animation
    CABasicAnimation *fadeAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnim.fromValue = [NSNumber numberWithFloat:self.layer.opacity];
    fadeAnim.toValue = @(0);
    fadeAnim.duration = 0.2;

    // when the animation completes, wipe the array containing the path and color history
    [CATransaction setCompletionBlock:^{
         
        // remove all paths
        [self.pathArray removeAllObjects];
        
        // remove all colors
        [self.colorArray removeAllObjects];

        // draw the new drawing (which is empty)
        [self setNeedsDisplay];
        
     }];
    
    // add the animation to the layer
    [self.layer addAnimation:fadeAnim forKey:nil];
    
    // execute the animation
    [CATransaction commit];

}




#pragma mark - Touch Methods
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    // add the first touch
    UITouch *touch = [touches anyObject];
    
    previousPoint1 = [touch previousLocationInView:self];
    currentPoint = [touch locationInView:self];
    
    // initialize path
    path = [[UIBezierPath alloc] init];
    path.lineWidth = self.lineWidth;
    path.lineCapStyle = kCGLineCapRound;
    [path moveToPoint:currentPoint];

    // add the new path to path array
    [pathArray addObject:path];
    [colorArray addObject:self.lineColor];

}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // save all the touches in the path
    UITouch *touch = [touches anyObject];
    
    previousPoint2 = previousPoint1;
    previousPoint1 = [touch previousLocationInView:self];
    currentPoint = [touch locationInView:self];
    
    // if the touch hasn't moved, then draw a point
    if (CGPointEqualToPoint (currentPoint, previousPoint1))
    {
        
        [path addLineToPoint:currentPoint];
        
    } else {

        // get point between last two points
        CGPoint midPoint1 = getMidPoint (previousPoint1, previousPoint2);
        
        // get point between this point and last point
        CGPoint midPoint2 = getMidPoint (currentPoint, previousPoint1);
        
        // begin quad curve at midpoint
        [path moveToPoint:midPoint1];
        
        // create quad curve from midPoint1 to previous point to midPoint2
        // Note: We're using a quad curve instead of line, otherwise strokes will have corners and will look more like polygons
        [path addQuadCurveToPoint:midPoint2 controlPoint:previousPoint1];
        
    }
    
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // pass last touched to touchesMoved
    // this enables the artist to mark dots on the canvas
    [self touchesMoved:touches withEvent:event];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}



@end
