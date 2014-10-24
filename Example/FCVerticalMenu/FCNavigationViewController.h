//
//  FCViewController.h
//  FCVerticalMenu
//
//  Created by Filippo Camillo on 10/23/2014.
//  Copyright (c) 2014 Filippo Camillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCVerticalMenu;

@interface FCNavigationViewController : UINavigationController

@property (strong, readonly, nonatomic) FCVerticalMenu *verticalMenu;

-(IBAction)openVerticalMenu:(id)sender;

@end
