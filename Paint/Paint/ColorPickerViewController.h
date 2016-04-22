//
//  ColorPickerViewController.h
//  Paint
//
//  Created by William Grand on 4/22/16.
//  Copyright © 2016 William Grand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorPickerViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *wellCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

- (IBAction)cancelAction:(id)sender;
- (IBAction)applyAction:(id)sender;

@end
