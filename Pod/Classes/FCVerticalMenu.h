//
//  FCVerticalMenu.h
//  VerticalSideMenu
//
//  Created by Filippo Camillo on 14/10/14.
//  Copyright (c) 2014 Filippo Camillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FCVerticalMenuItem.h"

@class FCVerticalMenu;

@protocol FCVerticalMenuDelegate <NSObject>
@optional
-(void)menuWillOpen:(FCVerticalMenu *)menu;
-(void)menuDidOpen:(FCVerticalMenu *)menu;
-(void)menuWillClose:(FCVerticalMenu *)menu;
-(void)menuDidClose:(FCVerticalMenu *)menu;
@end


@interface FCVerticalMenu : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

// Properties
//
@property (strong, readwrite, nonatomic) NSArray *items;
@property (assign, readonly, nonatomic) BOOL isOpen;
@property (assign, readonly, nonatomic) BOOL isAnimating;
@property (assign, readwrite, nonatomic) BOOL closeOnSelection;
@property (weak, readwrite, nonatomic) id <FCVerticalMenuDelegate> delegate;

@property (strong, nonatomic) UICollectionView *menuCollection;



// Style properties
//

@property (strong, readwrite, nonatomic) UICollectionViewFlowLayout *menuLayout;

@property (strong, readwrite, nonatomic) UIColor *shadowColor;
@property (assign, readwrite, nonatomic) CGSize shadowOffset;
@property (assign, readwrite, nonatomic) CGFloat shadowOpacity;
@property (assign, readwrite, nonatomic) CGFloat shadowRadius;
@property (assign, readwrite, nonatomic) CGFloat backgroundAlpha;
@property (strong, readwrite, nonatomic) UIColor *backgroundColor;


@property (strong, readwrite, nonatomic) UIFont *font;
@property (strong, readwrite, nonatomic) UIColor *textColor;
@property (strong, readwrite, nonatomic) UIColor *textShadowColor;
@property (strong, readwrite, nonatomic) UIColor *imageTintColor;
@property (strong, readwrite, nonatomic) UIColor *highlightedBackgroundColor;
@property (strong, readwrite, nonatomic) UIColor *highlightedTextColor;
@property (strong, readwrite, nonatomic) UIColor *highlightedTextShadowColor;
@property (strong, readwrite, nonatomic) UIColor *highlightedImageTintColor;
@property (assign, readwrite, nonatomic) CGFloat borderWidth;
@property (strong, readwrite, nonatomic) UIColor *borderColor;
@property (assign, readwrite, nonatomic) NSTextAlignment textAlignment;


@property (assign, readwrite, nonatomic) NSTimeInterval animationDuration;
@property (assign, readwrite, nonatomic) NSTimeInterval closeAnimationDuration;
@property (assign, readwrite, nonatomic) NSTimeInterval bounceAnimationDuration;
@property (assign, readwrite, nonatomic) BOOL appearsBehindNavigationBar;
@property (assign, readwrite, nonatomic) BOOL bounce;

// only iOS 7+
// liveBlur is automatically activated
//
@property (assign, readwrite, nonatomic) BOOL liveBlur;
@property (strong, readwrite, nonatomic) UIColor *liveBlurTintColor;
@property (assign, readwrite, nonatomic) UIBarStyle liveBlurBackgroundStyle;




//Methods
//
- (id)initWithItems:(NSArray*)itemsList;
- (void)showFromNavigationBar:(UINavigationBar*)navigationBar inView:(UIView *)view;
- (void)showFromRect:(CGRect)rect inView:(UIView *)view;
- (void)dismissWithCompletionBlock:(void (^)(void))completion;

@end
