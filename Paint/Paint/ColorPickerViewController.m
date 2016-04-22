//
//  ColorPickerViewController.m
//  Paint
//
//  Created by William Grand on 4/22/16.
//  Copyright © 2016 William Grand. All rights reserved.
//

#import "ColorPickerViewController.h"
#import "WellCollectionViewCell.h"

CGFloat grayColorCount = 8.0;
CGFloat colorCount     = 64.0;

NSIndexPath *selectedIndexPath;

@interface ColorPickerViewController ()

    UIColor *selectedColor();
    UIColor *colorFromIndexPath (NSIndexPath *);

@end

@implementation ColorPickerViewController

@synthesize wellCollectionView;
@synthesize flowLayout;


static NSString *cellIdentifier = @"wellCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    /* Styles */
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    
    /* Configure */
    
    // configure layout
    [self.wellCollectionView registerClass:[WellCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    // remove top and bottom space between cells
    flowLayout.minimumLineSpacing = 0;
    
    // remove leading and trailing space between cells
    flowLayout.minimumInteritemSpacing = 0;

    [self.wellCollectionView setCollectionViewLayout:flowLayout];

}

UIColor *selectedColor() {
    return colorFromIndexPath(selectedIndexPath);
}

UIColor *colorFromIndexPath (NSIndexPath* indexPath) {
    
    UIColor *cellColor;
    
    // gray gradient
    if (indexPath.section == 0)
    {
        CGFloat intensity = indexPath.row / (grayColorCount - 1);
        cellColor = [UIColor colorWithRed:intensity green:intensity blue:intensity alpha:1];
        
    }
    // color gradient
    else {
        CGFloat hue = indexPath.row / (colorCount - grayColorCount - 1);
        NSLog (@"%f", hue);
        cellColor = [UIColor colorWithHue:hue saturation:1 brightness:1 alpha:1];
    }
    
    return cellColor;
}

#pragma mark collection view

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 0 ? grayColorCount : colorCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WellCollectionViewCell *cell = (WellCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = colorFromIndexPath(indexPath);

    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // size cell according to the size of the screen
    return CGSizeMake(collectionView.frame.size.width / 8, collectionView.frame.size.height / 8);
}

#pragma mark actions
- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)applyAction:(id)sender {

    [self dismissViewControllerAnimated:true completion:nil];
}
@end
