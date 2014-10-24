//
//  FCVerticalMenuItemCollectionViewCell.m
//  VerticalSideMenu
//
//  Created by Filippo Camillo on 16/10/14.
//  Copyright (c) 2014 Filippo Camillo. All rights reserved.
//

#import "FCVerticalMenuItemCollectionViewCell.h"
#import "FCVerticalMenuItem.h"

@interface FCVerticalMenuItemCollectionViewCell()
    -(UIImage *)image:(UIImage *)img withColor:(UIColor *)color;
@end

@implementation FCVerticalMenuItemCollectionViewCell

//TODO: implement these properties
// UIColor *textShadowColor;
// UIColor *highlightedTextColor;
// UIColor *highlightedTextShadowColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 25, frame.size.width-50, frame.size.height-70)];
        [self addSubview:_imageView];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 40)];
        [self addSubview:_titleLabel];
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-20)];


    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx, _theMenuItem.borderWidth);
    CGRect newRect = CGRectMake(rect.origin.x+5, rect.origin.y+5, rect.size.width-10, rect.size.height-30);

    if (self.highlighted) {
        CGContextSetFillColor(ctx, CGColorGetComponents([_theMenuItem.highlightedBackgroundColor CGColor]));
        CGContextSetStrokeColorWithColor(ctx, [_theMenuItem.borderColor CGColor]);
        CGContextFillEllipseInRect(ctx, newRect);
    } else {
        CGContextSetStrokeColorWithColor(ctx, [_theMenuItem.borderColor CGColor]);
        CGContextStrokeEllipseInRect (ctx, newRect);
    }

//    CGContextClosePath(ctx);
    
    if (_theMenuItem.icon) {
        [_placeholderLabel removeFromSuperview];
        
        UIColor *tintColor = _theMenuItem.imageTintColor;
        
        if (self.highlighted) {
            tintColor = _theMenuItem.highlightedImageTintColor;
        }
        
        if (tintColor)
            _imageView.image = [self image:_theMenuItem.icon withColor:tintColor];
        else
            _imageView.image = _theMenuItem.icon;
        
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        
    } else {
        UIColor *tintColor = _theMenuItem.imageTintColor;
        
        if (self.highlighted)
            tintColor = _theMenuItem.highlightedImageTintColor;
        
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(ctx, [tintColor CGColor]);
        CGContextFillEllipseInRect(ctx, CGRectMake(30, 30, rect.size.width-60, rect.size.height-80));
//        CGContextClosePath(ctx);
        
    }
    
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = _theMenuItem.textColor;
    _titleLabel.font = _theMenuItem.font;
    _titleLabel.textAlignment = _theMenuItem.textAlignment;
    _titleLabel.numberOfLines = 2;
    [_titleLabel setText:_theMenuItem.title];
    [_titleLabel sizeToFit];

    CGRect newFrame = _titleLabel.frame;
    newFrame = CGRectMake(newFrame.origin.x, newFrame.origin.y, rect.size.width, newFrame.size.height);
    _titleLabel.frame = newFrame;
    
}

- (void)layoutSubviews
{
    self.backgroundColor = [UIColor clearColor];
}


- (void)configureForItem:(FCVerticalMenuItem*)menuItem
{
    [self setNeedsDisplay];
}

-(void)setTheMenuItem:(FCVerticalMenuItem *)theMenuItem
{
    _theMenuItem = theMenuItem;
    [self setNeedsDisplay];
}


-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}


/**
 *  Create and return an image tinted with a color
 *
 *  @param img   the source image
 *  @param color the tint color
 *
 *  @return new UIImage
 */
-(UIImage *)image:(UIImage *)img withColor:(UIColor *)color {
    if (color) {
        // Construct new image the same size as this one.
        UIImage *image;
        UIGraphicsBeginImageContextWithOptions([img size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
        CGRect rect = CGRectZero;
        rect.size = [img size];
        
        // tint the image
        [img drawInRect:rect];
        [color set];
        UIRectFillUsingBlendMode(rect, kCGBlendModeMultiply);
        
        // restore alpha channel
        [img drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0f];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    return img;
}


@end
