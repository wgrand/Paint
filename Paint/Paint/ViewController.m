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
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.colorButton.tintColor = self.drawingView.lineColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)colorButtonTouchUpInside:(id)sender {
    ColorPickerViewController *colorPickerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ColorPickerViewController"];
    colorPickerViewController.drawingView = self.drawingView;
    [self presentViewController:colorPickerViewController animated:true completion:nil];
}

- (IBAction)clearButtonTouchUpInside:(id)sender {
    
    // clear the drawing
    [self.drawingView clearDrawing];
    
}
@end
