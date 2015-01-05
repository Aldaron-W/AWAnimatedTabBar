//
//  AWItemAnimation.m
//  AWAnimatedTabBarDemo
//
//  Created by mafengwo on 15/1/4.
//  Copyright (c) 2015年 Aldaron. All rights reserved.
//

#import "AWItemAnimation.h"

@implementation AWItemAnimation

- (instancetype)init{
    if (self = [super init]) {
        self.duration = 0.5;
        self.textSelectedColor = [UIColor blackColor];
    }
    return self;
}

- (void) playAnimationWithIcon:(UIImageView *)icon andTextLabel:(UILabel *)label{
    
}

- (void)deselectionAnimationWithIcon:(UIImageView *)icon andTextLabel:(UILabel *)label andDefaultTextColor:(UIColor *)defaultColor{
    
}

- (void)selectedStateWithIcon:(UIImageView *)icon andTextLabel:(UILabel *)label{
    
}

@end
