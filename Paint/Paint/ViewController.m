//
//  ViewController.m
//  Paint
//
//  Created by William Grand on 4/20/16.
//  Copyright © 2016 William Grand. All rights reserved.
//

#import "ViewController.h"
#import "ColorPickerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // hide the toolbar's hairline
    self.toolBar.clipsToBounds = true;

    // apply border to color well button
    self.colorButton.layer.cornerRadius = self.colorButton.frame.size.height/2;
    self.colorButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.colorButton.layer.borderWidth = 1;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // set the color background color to the curent drawing color every time the view appears
    self.colorButton.backgroundColor = self.drawingView.lineColor;
    
}

- (IBAction)colorButtonTouchUpInside:(id)sender {
    ColorPickerViewController *colorPickerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ColorPickerViewController"];
    colorPickerViewController.drawingView = self.drawingView;
    [self presentViewController:colorPickerViewController animated:true completion:nil];
}

- (IBAction)shareButtonTouchUpInside:(id)sender {
    
    NSArray *items = @[self.drawingView.imageCapture];
    
    // build an activity view controller
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)clearButtonTouchUpInside:(id)sender {
    
    // clear the drawing
    [self.drawingView clearDrawing];
    
}
@end
