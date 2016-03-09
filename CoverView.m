//
//  CoverView.m
//  SunFreeLander
//
//  Created by qianfeng on 16/3/9.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "CoverView.h"

@implementation CoverView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.2;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCover)];
    [self addGestureRecognizer:tap];
    return self;
}

- (void)tapCover {
//    UIView *uv = (UIView *)[self viewWithTag:1];
    [self removeFromSuperview];
}

@end
