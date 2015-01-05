//
//  AWAnimatedTabBarController.m
//  AWAnimatedTabBarDemo
//
//  Created by mafengwo on 15/1/4.
//  Copyright (c) 2015年 Aldaron. All rights reserved.
//

#import "AWTabBarController.h"

#import "AWTabBarItem.h"

@interface AWTabBarController ()

#define ICON_KEY @"icon"
#define TEXTLABEL_KEY @"textLabel"

@property (nonatomic, strong) NSMutableArray *iconsView;

@end

@implementation AWTabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSDictionary *containers = [self createViewContainers];
    
    [self createCustomIcons:containers];
}

- (void)createCustomIcons:(NSDictionary *)containers{
    if ([self.tabBar.items count] > 0) {
        NSUInteger itemsCount = [self.tabBar.items count] - 1;
        NSUInteger index = 0;
        for (AWTabBarItem *item in self.tabBar.items) {
            UIView *container = [containers objectForKey:[NSString stringWithFormat:@"container%d", (itemsCount - index)]];
            [container setTag:index];
            
            UIImageView *icon = [[UIImageView alloc] initWithImage:item.image];
            [icon setTranslatesAutoresizingMaskIntoConstraints:NO];
            [icon setTintColor:[UIColor clearColor]];
            
            UILabel *textLabel = [UILabel new];
            textLabel.text = item.title;
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.textColor = item.textColor;
            textLabel.font = [UIFont systemFontOfSize:10];
            textLabel.textAlignment = NSTextAlignmentCenter;
            [textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
            
            [container addSubview:icon];
            [self createConstraintsWithView:icon andContainer:container andSize:item.image.size andYOffset:-5];
            
            [container addSubview:textLabel];
            CGFloat textLabelWidth = (self.tabBar.frame.size.width / (CGFloat)[self.tabBar.items count]) - 5.0;
            [self createConstraintsWithView:textLabel andContainer:container andSize:CGSizeMake(textLabelWidth, 10) andYOffset:16];
            
            NSDictionary *iconsAndLabels = @{ICON_KEY : icon,
                                             TEXTLABEL_KEY : textLabel};
            [self.iconsView addObject:iconsAndLabels];
            
            if (0 == index) {
                [item selectedState:icon andTextLabel:textLabel];
            }
            
            item.image = nil;
            item.title = @"";
            index ++;
        }
    }
}

- (void)createConstraintsWithView:(UIView *)view andContainer:(UIView *)container andSize:(CGSize)size andYOffset:(CGFloat)yOffset{
    NSLayoutConstraint *constX = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [container addConstraint:constX];
    
    NSLayoutConstraint *constY = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeCenterY multiplier:1 constant:yOffset];
    [container addConstraint:constY];
    
    NSLayoutConstraint *constW = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:size.width];
    [view addConstraint:constW];
    
    NSLayoutConstraint *constH = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:size.height];
    [view addConstraint:constH];
}

- (NSMutableDictionary *)createViewContainers{
    NSMutableDictionary *containersDict = [NSMutableDictionary new];
    NSUInteger itemsCount = [self.tabBar.items count] - 1;
    
    for (int index=0; index <= itemsCount; index++) {
        UIView *viewContainer = [self createViewContainer];
        [containersDict setObject:viewContainer forKey:[NSString stringWithFormat:@"container%d", (index)]];
    }
    
    NSMutableString *formatString = [NSMutableString stringWithString:@"H:|-(0)-[container0]"];
    for (int index=1; index <= itemsCount; index++) {
        [formatString appendFormat:@"-(0)-[container%d(==container0)]", index];
    }
    [formatString appendString:@"-(0)-|"];
    
    NSArray *constranints = [NSLayoutConstraint constraintsWithVisualFormat:formatString options:NSLayoutFormatDirectionRightToLeft metrics:nil views:containersDict];
    [self.view addConstraints:constranints];
    
    return containersDict;
}

- (UIView *)createViewContainer{
    UIView *viewContainer = [UIView new];
    [viewContainer setBackgroundColor:[UIColor clearColor]];
    [viewContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:viewContainer];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeandler:)];
    tapGesture.numberOfTouchesRequired = 1;
    [viewContainer addGestureRecognizer:tapGesture];
    
    NSLayoutConstraint *constY = [NSLayoutConstraint constraintWithItem:viewContainer attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.view addConstraint:constY];
    
    NSLayoutConstraint *constH = [NSLayoutConstraint constraintWithItem:viewContainer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:self.tabBar.frame.size.height];
    [viewContainer addConstraint:constH];
    
    return viewContainer;
}
- (void)tapHeandler:(UIGestureRecognizer *)gesture{
    
    NSUInteger currentIndex = gesture.view.tag;
    if (self.selectedIndex != currentIndex) {
        AWTabBarItem *animationItem = self.tabBar.items[currentIndex];
        UIImageView *icon = [self.iconsView[currentIndex] objectForKey:ICON_KEY];
        UILabel *textLabel = [self.iconsView[currentIndex] objectForKey:TEXTLABEL_KEY];
        [animationItem playAnimationWithIcon:icon andTextLabel:textLabel];
        
        AWTabBarItem *deselelectItem = self.tabBar.items[self.selectedIndex];
        UIImageView *deselelectIcon = [self.iconsView[self.selectedIndex] objectForKey:ICON_KEY];
        UILabel *deselelectTextLabel = [self.iconsView[self.selectedIndex] objectForKey:TEXTLABEL_KEY];
        [deselelectItem deselectionAnimationWithIcon:deselelectIcon andTextLabel:deselelectTextLabel];
        
        self.selectedIndex = gesture.view.tag;
    }
}

- (NSMutableArray *)iconsView{
    if (!_iconsView) {
        _iconsView = [NSMutableArray new];
    }
    return _iconsView;
}

@end
