//
//  FCSecondViewController.m
//  FCVerticalMenu
//
//  Created by Filippo Camillo on 23/10/14.
//  Copyright (c) 2014 Filippo Camillo. All rights reserved.
//

#import "FCSecondViewController.h"
#import "FCNavigationViewController.h"

@implementation FCSecondViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self.navigationController action:@selector(openVerticalMenu:)];
}

-(void)doSomething
{
    self.view.backgroundColor = [UIColor redColor];
}

@end
