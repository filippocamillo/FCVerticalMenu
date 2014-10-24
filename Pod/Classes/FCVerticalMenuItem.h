//
//  FCVerticalMenuItem.h
//  VerticalSideMenu
//
//  Created by Filippo Camillo on 14/10/14.
//  Copyright (c) 2014 Filippo Camillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ActionBlock)();

@interface FCVerticalMenuItem : NSObject

@property (nonatomic, readonly, assign) CGFloat calculatedHeight;
@property (nonatomic, readonly, assign) CGFloat calculatedWidth;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *icon;
@property(readwrite, copy) ActionBlock actionBlock;


//style
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



- (id)initWithTitle:(NSString*)theTitle andIconImage:(UIImage*)theIcon;


@end
