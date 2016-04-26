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
    
    // get an image capture of the drawing
    NSArray *items = @[self.drawingView.imageCapture];
    
    // present activity view controller with the image
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (IBAction)clearButtonTouchUpInside:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Are you sure you want clear?" preferredStyle:UIAlertControllerStyleAlert];
    
    // make action colors gray
    alertController.view.tintColor = [UIColor darkGrayColor];
    
    // yes action
    UIAlertAction *yesAction = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    // clear the drawing
                                    [self.drawingView clearDrawing];
                                }];
    
    
    // no action
    UIAlertAction *noAction = [UIAlertAction
                                actionWithTitle:@"No"
                                style:UIAlertActionStyleDefault
                                handler:nil];
    
    [alertController addAction:yesAction];
    [alertController addAction:noAction];
    
    [self presentViewController:alertController animated:true completion:^{
        // workaround for iOS9 bug where tint color gets reset
        alertController.view.tintColor = [UIColor darkGrayColor];
    }];
    
    
}
@end
