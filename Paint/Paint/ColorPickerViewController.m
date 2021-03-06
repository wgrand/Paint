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

NSIndexPath *selectedItemIndexPath;

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
    return colorFromIndexPath(selectedItemIndexPath);
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
        cellColor = [UIColor colorWithHue:hue saturation:1 brightness:1 alpha:1];
    }
    
    return cellColor;
}

#pragma mark collection view

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2; // there are two sections: one for the grayscale colors and the other for a variety of hues
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 0 ? grayColorCount : colorCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WellCollectionViewCell *cell = (WellCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // apply well color
    cell.backgroundColor = colorFromIndexPath(indexPath);
    
    // apply or remove border
    if (selectedItemIndexPath == indexPath)
    {
        cell.frame = CGRectInset(cell.frame, -cell.layer.borderWidth, -cell.layer.borderWidth);
        cell.layer.borderColor = [UIColor blackColor].CGColor;
        cell.layer.borderWidth = 2.0;
    }
    else {
        cell.layer.borderColor = nil;
        cell.layer.borderWidth = 0;
    }

    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // size cell according to the size of the view
    return CGSizeMake(collectionView.bounds.size.width / 8, collectionView.bounds.size.height / 8);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithObject:indexPath];
    
    // if we had a previously selected cell
    if (selectedItemIndexPath && [indexPath compare:selectedItemIndexPath] != NSOrderedSame)
    {
        
        // add previously selected cell to array so that both previous and currently selected cells will get updated
        [indexPaths addObject:selectedItemIndexPath];
        selectedItemIndexPath = indexPath;
    }
    
    selectedItemIndexPath = indexPath;
    
    // reload the cells that need updating
    [wellCollectionView reloadItemsAtIndexPaths:indexPaths];
    
}


#pragma mark actions
- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)applyAction:(id)sender {
    
    // apply the color
    self.drawingView.lineColor = selectedColor();

    // dismiss this view controller
    [self dismissViewControllerAnimated:true completion:nil];
    
}
@end
