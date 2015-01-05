//
//  AWAnimatedTabBarItem.m
//  AWAnimatedTabBarDemo
//
//  Created by mafengwo on 15/1/4.
//  Copyright (c) 2015年 Aldaron. All rights reserved.
//

#import "AWTabBarItem.h"

#import "AWItemAnimation.h"

@implementation AWTabBarItem

- (void)playAnimationWithIcon:(UIImageView *)icon andTextLabel:(UILabel *)label{
    if (self.animation != nil) {
        [self.animation playAnimationWithIcon:icon andTextLabel:label];
    }
}

- (void)deselectionAnimationWithIcon:(UIImageView *)icon andTextLabel:(UILabel *)label{
    if (self.animation != nil) {
        [self.animation deselectionAnimationWithIcon:icon andTextLabel:label andDefaultTextColor:self.textColor];
    }
}

- (void)selectedState:(UIImageView *)icon andTextLabel:(UILabel *)label{
    if (self.animation != nil) {
        [self.animation selectedStateWithIcon:icon andTextLabel:label];
    }
}

- (UIColor *)textColor{
    if (!_textColor) {
        _textColor = [UIColor blackColor];
    }
    return _textColor;
}

@end
