//
//  AWFrameItemAnimation.m
//  AWAnimatedTabBarDemo
//
//  Created by mafengwo on 15/1/4.
//  Copyright (c) 2015年 Aldaron. All rights reserved.
//

#import "AWFrameItemAnimation.h"

@implementation AWFrameItemAnimation

- (void)awakeFromNib{
    NSString *path = [[NSBundle mainBundle] pathForResource:self.imagesPath ofType:@"plist"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *animationImagesName = dict[@"images"];
    [self createImagesArray:animationImagesName];
    
    NSString *selectedImageName = animationImagesName[animationImagesName.count - 1];
    
    self.selectedImage = [UIImage imageNamed:selectedImageName];
}

- (void)createImagesArray:(NSArray *)imageNames{
    for (NSString *name in imageNames) {
        UIImage *image = [UIImage imageNamed:name];
        [self.animationImages addObject:image];
    }
}

- (void)playAnimationWithIcon:(UIImageView *)icon andTextLabel:(UILabel *)label{
    [self playFrameAnimation:icon andImageArray:self.animationImages];
    [label setTextColor:self.textSelectedColor];
}

- (void)deselectionAnimationWithIcon:(UIImageView *)icon andTextLabel:(UILabel *)label andDefaultTextColor:(UIColor *)defaultColor{
    if (self.isDeselectAnimation) {
        NSMutableArray *imagesReverse = [NSMutableArray new];
        
        for (UIImage *image in [self.animationImages reverseObjectEnumerator]) {
            [imagesReverse addObject:image];
        }
        
        [self playFrameAnimation:icon andImageArray:imagesReverse];
    }
    
    [label setTextColor:defaultColor];
}

- (void)selectedStateWithIcon:(UIImageView *)icon andTextLabel:(UILabel *)label{
    [icon setImage:self.selectedImage];
    [label setTextColor:self.textSelectedColor];
}

- (void)playFrameAnimation:(UIImageView *)icon andImageArray:(NSArray *)images{
    NSMutableArray *cgimagesArray = [NSMutableArray new];
    if (images && 0 < [images count]) {
        for (UIImage *image in images) {
            [cgimagesArray addObject:[image CGImage]];
        }
    }
    
    CAKeyframeAnimation *frameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    [frameAnimation setCalculationMode:kCAAnimationDiscrete];
    [frameAnimation setDuration:self.duration];
    [frameAnimation setValues:cgimagesArray];
    [frameAnimation setRepeatCount:1];
    [frameAnimation setRemovedOnCompletion:NO];
    [frameAnimation setFillMode:kCAFillModeForwards];
    [icon.layer addAnimation:frameAnimation forKey:@"frameAnimation"];
}

- (NSMutableArray *)animationImages{
    if (!_animationImages) {
        _animationImages = [NSMutableArray new];
    }
    return _animationImages;
}

@end
