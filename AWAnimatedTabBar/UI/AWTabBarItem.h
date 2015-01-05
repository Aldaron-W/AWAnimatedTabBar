//
//  AWAnimatedTabBarItem.h
//  AWAnimatedTabBarDemo
//
//  Created by mafengwo on 15/1/4.
//  Copyright (c) 2015年 Aldaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AWItemAnimation;

@interface AWTabBarItem : UITabBarItem

@property (nonatomic, weak) IBOutlet AWItemAnimation *animation;

@property (nonatomic, strong) UIColor *textColor;

- (void)playAnimationWithIcon:(UIImageView *)icon andTextLabel:(UILabel *)label;
- (void)deselectionAnimationWithIcon:(UIImageView *)icon andTextLabel:(UILabel *)label;
- (void)selectedState:(UIImageView *)icon andTextLabel:(UILabel *)label;

@end
