//
//  FCVerticalMenuItemCollectionViewCell.h
//  VerticalSideMenu
//
//  Created by Filippo Camillo on 16/10/14.
//  Copyright (c) 2014 Filippo Camillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCVerticalMenuItem;

@interface FCVerticalMenuItemCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) FCVerticalMenuItem *theMenuItem;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *placeholderLabel;

@end
