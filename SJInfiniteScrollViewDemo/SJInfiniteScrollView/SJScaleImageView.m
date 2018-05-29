//
//  SJScaleImageView.m
//  SJInfiniteScrollViewDemo
//
//  Created by 沈骏 on 2018/5/29.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import "SJScaleImageView.h"
#import "SJImageScrollView.h"

@implementation SJScaleImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"ss");
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIconIMG:)];
        [self addGestureRecognizer:tapGestureRecognizer];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)tapIconIMG:(UITapGestureRecognizer *)tapGestureRecognizer {
    SJImageScrollView *sView = [[SJImageScrollView alloc] init];
    [sView.imageView setImage:self.image];
    [sView showSelfWithRefView:self];
}

@end
