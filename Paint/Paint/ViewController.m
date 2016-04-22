//
//  ViewController.m
//  Paint
//
//  Created by William Grand on 4/20/16.
//  Copyright © 2016 William Grand. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)colorButtonTouchUpInside:(id)sender {
    UIViewController *colorPickerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ColorPickerViewController"];
    
    [self presentViewController:colorPickerViewController animated:true completion:nil];
}

- (IBAction)clearButtonTouchUpInside:(id)sender {
    
    
}
@end
