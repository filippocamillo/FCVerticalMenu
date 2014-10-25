//
//  FCVerticalMenu.m
//  VerticalSideMenu
//
//  Created by Filippo Camillo on 14/10/14.
//  Copyright (c) 2014 Filippo Camillo. All rights reserved.
//

#import "FCVerticalMenu.h"
#import "FCVerticalMenuItem.h"
#import "FCVerticalMenuItemCollectionViewCell.h"

@interface FCVerticalMenu ()
    @property (assign, readwrite, nonatomic) BOOL isOpen;
    @property (assign, readwrite, nonatomic) BOOL isAnimating;
    @property (strong, readwrite, nonatomic) UIView *containerView;
    @property (strong, readwrite, nonatomic) UIView *menuView;
    @property (strong, readwrite, nonatomic) UIToolbar *toolbar;

- (CGFloat)navigationBarOffset;
@end

@implementation FCVerticalMenu


- (id)init
{
    self = [super init];
    if (self) {
        
//        Setting default appeareance and settings
//
        _closeOnSelection = YES;
        
        _font = [UIFont fontWithName:@"Helvetica-Light" size:14];
        _textColor = [UIColor whiteColor];
        _textShadowColor = [UIColor blackColor];
        _textAlignment = NSTextAlignmentCenter;

        _imageTintColor = [UIColor whiteColor];
        _highlightedImageTintColor = _imageTintColor;
        
        _highlightedBackgroundColor = [UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0];
        _highlightedTextColor = [UIColor colorWithRed:128/255.0 green:126/255.0 blue:124/255.0 alpha:1.0];
        _highlightedTextShadowColor = [UIColor blackColor];

        _borderWidth = 0.5;
        _borderColor = [UIColor whiteColor];
        
        _backgroundAlpha = 0.95;
        _backgroundColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:52/255.0 alpha:1.0];
        _liveBlurTintColor = nil;
        _liveBlur = YES;

        _animationDuration = 0.3;
        _closeAnimationDuration = 0.2;
        _bounce = YES;
        _bounceAnimationDuration = 0.2;
        
        
        _menuLayout = [[UICollectionViewFlowLayout alloc] init];
        // setting cell attributes globally via layout properties ///////////////
        
        _menuLayout.itemSize = CGSizeMake(80, 100);
        _menuLayout.minimumInteritemSpacing = 15;
        _menuLayout.minimumLineSpacing = 15;
        _menuLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _menuLayout.sectionInset = UIEdgeInsetsMake(25, 25, 25, 25);

        _menuCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_menuLayout];
        [_menuCollection registerClass:[FCVerticalMenuItemCollectionViewCell class] forCellWithReuseIdentifier:@"menuItem"];
        _menuCollection.backgroundColor = [UIColor clearColor];
        _menuCollection.delegate = self;
        _menuCollection.dataSource = self;
        
        
    }
    return self;
}



/**
 *  Init the menu with an array of FCVerticalMenuItem
 *
 *  @param itemsList an array of object FCVerticalMenuItem
 *
 */
- (id)initWithItems:(NSArray*)itemsList
{
    self = [self init];
    if (self) {
        self.items = itemsList;
        for (FCVerticalMenuItem *anItem in self.items) {
            //do something with the item
            NSInteger index = [self.items indexOfObject:anItem];
            
            anItem.index = index;
            
            anItem.font = _font;
            anItem.textColor = _textColor;
            anItem.textShadowColor = _textShadowColor;
            anItem.textAlignment = _textAlignment;
            anItem.highlightedBackgroundColor = _highlightedBackgroundColor;
            anItem.highlightedTextColor = _highlightedTextColor;
            anItem.highlightedTextShadowColor = _highlightedTextShadowColor;
            anItem.borderWidth = _borderWidth;
            anItem.borderColor = _borderColor;
            anItem.imageTintColor = _imageTintColor;
            anItem.highlightedImageTintColor = _highlightedImageTintColor;

        }
    }
    
    return self;
}

/**
 *  Setup and add gesture recognizer
 */
-(void)setupGesture {
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    panGestureRecognizer.minimumNumberOfTouches = 1;
    [self.containerView addGestureRecognizer:panGestureRecognizer];
}


/**
 *  show the menu from the navigationBar and bring the navbar to front
 *
 *  @param navigationBar the navigationBar
 *  @param view          the view container
 */
- (void)showFromNavigationBar:(UINavigationBar*)navigationBar inView:(UIView *)view
{    
    [self showFromRect:navigationBar.frame inView:view];
    
    if (self.appearsBehindNavigationBar) {
        [view bringSubviewToFront:navigationBar];
    }
}


/**
 *  show the menu from the rect
 *
 *  @param rect a CGrect from where the rect is showed
 *  @param view an UIView where the menu is showed
 */
- (void)showFromRect:(CGRect)rect inView:(UIView *)view
{
    if (self.isAnimating) {
        return;
    }
    
    self.isOpen = YES;
    self.isAnimating = YES;
    
    // Create views
    //
    self.containerView = ({
        UIView *view = [[UIView alloc] init];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        if (!self.liveBlur) {
            view.layer.opacity = self.backgroundAlpha;
            view.backgroundColor = self.backgroundColor;
            view.layer.shadowColor = self.shadowColor.CGColor;
            view.layer.shadowOffset = self.shadowOffset;
            view.layer.shadowOpacity = self.shadowOpacity;
            view.layer.shadowRadius = self.shadowRadius;
            view.layer.shouldRasterize = YES;
            view.layer.rasterizationScale = [UIScreen mainScreen].scale;
        }
        view;
    });

    if (self.liveBlur) {
        self.toolbar = ({
            UIToolbar *toolbar = [[UIToolbar alloc] init];
            toolbar.barStyle = self.liveBlurBackgroundStyle;
            if ([toolbar respondsToSelector:@selector(setBarTintColor:)])
                [toolbar performSelector:@selector(setBarTintColor:) withObject:self.liveBlurTintColor];
            toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            toolbar.layer.masksToBounds = YES;
            toolbar;
        });
    }
    
    self.menuView = ({
        UIView *view = [[UIView alloc] init];
        view.layer.masksToBounds = YES;
        view.layer.shouldRasterize = YES;
        view.layer.rasterizationScale = [UIScreen mainScreen].scale;
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth;


        view;
    });
    
    // Set up frames
    //
        
    //    Adding the collectionview with temporary frame
    //
    [self.menuCollection setFrame:rect];
    [self.menuView addSubview:self.menuCollection];

    //initial container position
    self.containerView.frame = CGRectMake(0, -[self totalHeight], rect.size.width, [self totalHeight]);

    //menu frame
    self.menuView.frame = CGRectMake(0, 40 + [self navigationBarOffset], rect.size.width, self.containerView.bounds.size.height-40);
    
    
    if (self.toolbar && self.liveBlur) {
        self.toolbar.frame = self.containerView.bounds;
        [self.containerView addSubview:self.toolbar];
    }


    // Add subviews
    //
    [self.containerView addSubview:self.menuView];
    [view addSubview:self.containerView];

    //    Changing the MenuCollectionView frame with the real one
    //
    self.menuCollection.frame = self.menuView.bounds;
    
    if ([self.delegate respondsToSelector:@selector(menuWillOpen:)]) {
        [self.delegate menuWillOpen:self];
    }
    
    
    // Set up gestures
    //
    [self setupGesture];

    
    // Animate presentation
    //
    if (self.bounce) {
        self.isAnimating = YES;
        if ([UIView respondsToSelector:@selector(animateWithDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:)]) {
            [UIView animateWithDuration:self.animationDuration+self.bounceAnimationDuration
                                  delay:0.0
                 usingSpringWithDamping:0.6
                  initialSpringVelocity:4.0
                                options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 CGRect frame = self.containerView.frame;
                                 frame.origin.y = -40.0;
                                 self.containerView.frame = frame;
                             } completion:^(BOOL finished) {
                                 self.isAnimating = NO;
                                 if ([self.delegate respondsToSelector:@selector(menuDidOpen:)]) {
                                     [self.delegate menuDidOpen:self];
                                 }
                             }];
        } else {
            [UIView animateWithDuration:self.animationDuration
                                  delay:0.0
                                options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 CGRect frame = self.containerView.frame;
                                 frame.origin.y = -40.0;
                                 self.containerView.frame = frame;
                             } completion:^(BOOL finished) {
                                 self.isAnimating = NO;
                                 if ([self.delegate respondsToSelector:@selector(menuDidOpen:)]) {
                                     [self.delegate menuDidOpen:self];
                                 }
                             }];
            
        }
    } else {
        [UIView animateWithDuration:self.animationDuration
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect frame = self.containerView.frame;
                             frame.origin.y = -40.0;
                             self.containerView.frame = frame;
                         } completion:^(BOOL finished) {
                             self.isAnimating = NO;
                             if ([self.delegate respondsToSelector:@selector(menuDidOpen:)]) {
                                 [self.delegate menuDidOpen:self];
                             }
                         }];
    }
}



#pragma mark - Frame utils

/**
 *  Calculate the actual height of the vertical menu
 *
 *  @return return the height as CGfloat
 */
- (CGFloat)totalHeight
{
    CGFloat navigationBarOffset = [self navigationBarOffset];
    return _menuCollection.collectionViewLayout.collectionViewContentSize.height + navigationBarOffset + 60;
}


- (CGFloat)navigationBarOffset
{
    return self.appearsBehindNavigationBar? 64.0f : 0.0f;
}


/**
 *  Present the menu
 *
 *  @param completion a completion block
 */
- (void)presentWithCompletionBlock:(void (^)(void))completion
{
    if (self.isAnimating) return;
    
    self.isAnimating = YES;
    [UIView animateWithDuration:self.animationDuration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect frame = self.containerView.frame;
                         frame.origin.y = -40.0;
                         self.containerView.frame = frame;
                     } completion:^(BOOL finished) {
                         self.isAnimating = NO;
                         //this is the parameter completion block
                         if (completion) {
                             completion();
                         }
                     }];
}

/**
 *  Dismiss the menu
 *
 *  @param completion a completion block
 */
- (void)dismissWithCompletionBlock:(void (^)(void))completion
{
    if (self.isAnimating) return;
    
    self.isAnimating = YES;
    
    //animation block
    void (^closeMenu)(void) = ^{
        [UIView animateWithDuration:self.closeAnimationDuration
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut
                         animations:^ {
                             CGRect frame = self.containerView.frame;
                             frame.origin.y = - [self totalHeight];
                             self.containerView.frame = frame;
                         } completion:^(BOOL finished) {
                             self.isOpen = NO;
                             self.isAnimating = NO;
                             
                             [self.menuView removeFromSuperview];
                             [self.containerView removeFromSuperview];
                             
                             //this is the parameter completion block
                             if (completion) {
                                 completion();
                             }
                             
                             if ([self.delegate respondsToSelector:@selector(menuDidClose:)]) {
                                 [self.delegate menuDidClose:self];
                             }
                         }];
        
    };
    
    if ([self.delegate respondsToSelector:@selector(menuWillClose:)]) {
        [self.delegate menuWillClose:self];
    }
    
    if (self.bounce) {
        [UIView animateWithDuration:self.bounceAnimationDuration animations:^{
            CGRect frame = self.containerView.frame;
            frame.origin.y = -20.0;
            self.containerView.frame = frame;
        } completion:^(BOOL finished) {
            closeMenu();
        }];
    } else {
        closeMenu();
    }
}




#pragma mark - CollectionView DataSource protocol
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FCVerticalMenuItemCollectionViewCell *cell = (FCVerticalMenuItemCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"menuItem" forIndexPath:indexPath];
    
    cell.theMenuItem = self.items[indexPath.row];
    
    return cell;
}


#pragma mark - CollectionView Delegate protocol
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FCVerticalMenuItemCollectionViewCell *cell = (FCVerticalMenuItemCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([cell isHighlighted])
        [self collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
    else
        [cell setHighlighted:YES];
  
    if (cell.theMenuItem.actionBlock) {
        cell.theMenuItem.actionBlock();
    }
    
    if (_closeOnSelection) {
        self.bounce = NO;
        [self dismissWithCompletionBlock:^{
            self.bounce = YES;
        }];
    }

}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FCVerticalMenuItemCollectionViewCell *cell = (FCVerticalMenuItemCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    [cell setHighlighted:NO];

}


#pragma mark - Gesture Recognizer
- (void)panGestureAction:(UIPanGestureRecognizer *)recognizer
{
    
    if( ([recognizer state] == UIGestureRecognizerStateBegan) ||
       ([recognizer state] == UIGestureRecognizerStateChanged) )
    {
        CGPoint translation = [recognizer translationInView:self.containerView];
        CGRect old_rect = self.containerView.frame;
        
        
        if (translation.y+recognizer.view.frame.origin.y>-40) {
            return;
        }

        old_rect.origin.y = old_rect.origin.y + translation.y;

        self.containerView.frame = old_rect;
        
        [recognizer setTranslation:CGPointZero inView:self.containerView];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        CGFloat halfPoint = (self.containerView.frame.size.height) * -0.20;
        if(self.containerView.frame.origin.y <= halfPoint)
        {
            self.bounce = NO;
            [self dismissWithCompletionBlock:^{
                self.bounce = YES;
            }];
        }
        else
        {
            [self presentWithCompletionBlock:nil];
        }
    }
    
}

@end
