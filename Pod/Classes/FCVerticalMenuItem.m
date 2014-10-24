//
//  FCVerticalMenuItem.m
//  VerticalSideMenu
//
//  Created by Filippo Camillo on 14/10/14.
//  Copyright (c) 2014 Filippo Camillo. All rights reserved.
//

#import "FCVerticalMenuItem.h"


@interface FCVerticalMenuItem ()

@end

@implementation FCVerticalMenuItem



- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


- (id)initWithTitle:(NSString*)theTitle andIconImage:(UIImage*)theIcon
{
    self = [self init];
    if (self) {
        _title = theTitle;
        _icon = theIcon;
    }
    return self;

}

- (CGFloat)calculatedHeight
{
    //TODO: calculate height with label and icon
    return 100.0;
}

- (CGFloat)calculatedWidth
{
    //TODO: calculate width
    return 100.0;
}





@end
