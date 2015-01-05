//
//  AWFrameItemAnimation.h
//  AWAnimatedTabBarDemo
//
//  Created by mafengwo on 15/1/4.
//  Copyright (c) 2015年 Aldaron. All rights reserved.
//

#import "AWItemAnimation.h"

@interface AWFrameItemAnimation : AWItemAnimation

@property (nonatomic, strong) NSString * imagesPath;

@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, strong) NSMutableArray *animationImages;

@property (nonatomic, assign) BOOL isDeselectAnimation;

@end
