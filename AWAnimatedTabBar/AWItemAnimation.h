//
//  AWItemAnimation.h
//  AWAnimatedTabBarDemo
//
//  Created by mafengwo on 15/1/4.
//  Copyright (c) 2015年 Aldaron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AWItemAnimation : NSObject

@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) UIColor *textSelectedColor;
@property (nonatomic, assign) UIColor *iconSelectedColor;

- (void)playAnimationWithIcon:(UIImageView *)icon andTextLabel:(UILabel *)label;

- (void)deselectionAnimationWithIcon:(UIImageView *)icon andTextLabel:(UILabel *)label andDefaultTextColor:(UIColor *)defaultColor;

- (void)selectedStateWithIcon:(UIImageView *)icon andTextLabel:(UILabel *)label;

@end
