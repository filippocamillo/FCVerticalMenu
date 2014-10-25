# FCVerticalMenu

A vertical menu animated and fully customizable.

<img src="https://github.com/filippocamillo/FCVerticalMenu/raw/master/FCVerticalMenu_demo.png" alt="FCVerticalMenu Screenshot" width="375" height="667" /> <img src="https://github.com/filippocamillo/FCVerticalMenu/raw/master/FCVerticalMenuDemo.gif" alt="FCVerticalMenu Demo" width="320" height="568" /> 
## Requirements

Xcode 6 or higher
Apple LLVM compiler
iOS 7.0 or higher
ARC


## Demo

Build the demo project with Xcode 6+. Take a look at the FCNavigatorViewController in which everything is configured.

## Installation

FCVerticalMenu is available through [CocoaPods](http://cocoapods.org). 


Install CocoaPods if you don't:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```

Change to the directory of your Xcode project:

``` bash
$ cd /path/to/YourProject
$ touch Podfile
$ edit Podfile
```

To install FCVerticalMenu, simply add the following line to your Podfile:

``` bash
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '7.0'
pod "FCVerticalMenu"
```


Install for your project as usual:

``` bash
$ pod install
```

Finally start working with the .xcworkspace file instead of .xcproject as usual

``` bash
$ open YourProject.xcworkspace
```



## Example Usage

``` objective-c
FCVerticalMenuItem *item1 = [[FCVerticalMenuItem alloc] initWithTitle:@"First Menu" andIconImage:[UIImage imageNamed:@"settings-icon"]];

item1.actionBlock = ^{
    NSLog(@"test element 1");
};


self.verticalMenu = [[FCVerticalMenu alloc] initWithItems:@[item1]];
self.verticalMenu.appearsBehindNavigationBar = YES;

[self.verticalMenu showFromNavigationBar:self.navigationBar inView:self.view];

```


## Fully customizable

You can customize the appearance of the menu:

``` objective-c

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
```

## Delegate Methods

You can also take advantage of the delegate methods just implementing it. 

Remember to adopt the delegate <FCVerticalMenuDelegate> in your controller and set the delegate with self.verticalMenu.delegate = self;

``` objective-c
@protocol FCVerticalMenuDelegate <NSObject>
@optional
-(void)menuWillOpen:(FCVerticalMenu *)menu;
-(void)menuDidOpen:(FCVerticalMenu *)menu;
-(void)menuWillClose:(FCVerticalMenu *)menu;
-(void)menuDidClose:(FCVerticalMenu *)menu;
@end
```

## Author

Filippo Camillo

- http://www.filippocamillo.com
- hello@filippocamillo.com


## License

FCVerticalMenu is available under the MIT license. See the LICENSE file for more info.

[![Version](https://img.shields.io/cocoapods/v/FCVerticalMenu.svg?style=flat)](http://cocoadocs.org/docsets/FCVerticalMenu)
[![License](https://img.shields.io/cocoapods/l/FCVerticalMenu.svg?style=flat)](http://cocoadocs.org/docsets/FCVerticalMenu)
[![Platform](https://img.shields.io/cocoapods/p/FCVerticalMenu.svg?style=flat)](http://cocoadocs.org/docsets/FCVerticalMenu)

