//
//  FCViewController.m
//  FCVerticalMenu
//
//  Created by Filippo Camillo on 10/23/2014.
//  Copyright (c) 2014 Filippo Camillo. All rights reserved.
//

#import "FCNavigationViewController.h"
#import <FCVerticalMenu/FCVerticalMenu.h>

#import "FCFirstViewController.h"
#import "FCSecondViewController.h"

@interface FCNavigationViewController ()

@end

@implementation FCNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureVerticalMenu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - FCVerticalMenu Configuration
- (void)configureVerticalMenu
{
    FCVerticalMenuItem *item1 = [[FCVerticalMenuItem alloc] initWithTitle:@"First Menu"
                                                             andIconImage:[UIImage imageNamed:@"settings-icon"]];
    
    FCVerticalMenuItem *item2 = [[FCVerticalMenuItem alloc] initWithTitle:@"Second Menu"
                                                             andIconImage:nil];
    
    FCVerticalMenuItem *item3 = [[FCVerticalMenuItem alloc] initWithTitle:@"Third Menu"
                                                             andIconImage:nil];
    
    FCVerticalMenuItem *item4 = [[FCVerticalMenuItem alloc] initWithTitle:@"Fourth Menu"
                                                             andIconImage:nil];
    
    FCVerticalMenuItem *item5 = [[FCVerticalMenuItem alloc] initWithTitle:@"Fifth Menu"
                                                             andIconImage:nil];
    
    FCVerticalMenuItem *item6 = [[FCVerticalMenuItem alloc] initWithTitle:@"Sixth Menu"
                                                             andIconImage:nil];
    
    item1.actionBlock = ^{
        NSLog(@"test element 1");
        FCFirstViewController *vc = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"FirstViewController"];
        if ([self.viewControllers[0] isEqual:vc])
            return;

        [self setViewControllers:@[vc] animated:NO];
    };
    item2.actionBlock = ^{
        NSLog(@"test element 2");
        FCSecondViewController *vc = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SecondViewController"];

        if ([self.viewControllers[0] isEqual:vc])
            return;
        
        [self setViewControllers:@[vc] animated:NO];

    };
    item3.actionBlock = ^{
        NSLog(@"test element 3");

        if ([self.viewControllers[0] isKindOfClass:[FCSecondViewController class]]) {
            [self.viewControllers[0] doSomething];
            return;
        }

        FCSecondViewController *vc = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SecondViewController"];
        
        [self setViewControllers:@[vc] animated:NO];
        [vc doSomething];
        
    };
    item4.actionBlock = ^{
        NSLog(@"test element 4");
        FCSecondViewController *vc = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ThirdViewController"];
        
        if ([self.viewControllers[0] isEqual:vc])
            return;
        
        [self setViewControllers:@[vc] animated:NO];

    };
    item5.actionBlock = ^{
        NSLog(@"test element 5");
    };
    item6.actionBlock = ^{
        NSLog(@"test element 6");
    };
    
    
    _verticalMenu = [[FCVerticalMenu alloc] initWithItems:@[item1, item2, item3, item4, item5, item6]];
    _verticalMenu.appearsBehindNavigationBar = YES;
    
}

-(IBAction)openVerticalMenu:(id)sender
{
    if (_verticalMenu.isOpen)
        return [_verticalMenu dismissWithCompletionBlock:nil];
    
    [_verticalMenu showFromNavigationBar:self.navigationBar inView:self.view];
}


@end
