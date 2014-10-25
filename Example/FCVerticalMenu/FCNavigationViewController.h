//
//  FCViewController.h
//  FCVerticalMenu
//
//  Created by Filippo Camillo on 10/23/2014.
//  Copyright (c) 2014 Filippo Camillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FCVerticalMenu/FCVerticalMenu.h>


@interface FCNavigationViewController : UINavigationController <FCVerticalMenuDelegate>

@property (strong, readonly, nonatomic) FCVerticalMenu *verticalMenu;

-(IBAction)openVerticalMenu:(id)sender;

@end
