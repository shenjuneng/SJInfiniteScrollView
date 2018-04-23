//
//  SJImageScrollView.m
//  SJInfiniteScrollViewDemo
//
//  Created by 沈骏 on 2018/4/23.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import "SJImageScrollView.h"
#import "UIView+SJInfiniteScrollView.h"
#import "Masonry.h"

@interface SJImageScrollView () <UIScrollViewDelegate>

@end

@implementation SJImageScrollView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupSubView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView {
    
    self.minimumZoomScale = 1;
    self.maximumZoomScale = 2;
//    self.showsVerticalScrollIndicator = NO;
//    self.showsHorizontalScrollIndicator = NO;
    self.delegate = self;
    
    self.backgroundColor = [UIColor yellowColor];
//    UIImage *image = [UIImage alloc] init;
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        make.center.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(self);
    }];
    
    // 点击手势
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [self.imageView addGestureRecognizer:tapGestureRecognizer];
    
    // 双击点击手势
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapView:)];
    doubleTapGestureRecognizer.numberOfTouchesRequired = 1;
    doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    [self.imageView addGestureRecognizer:doubleTapGestureRecognizer];
    
    [tapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
    
    //如果处理的是图片，别忘了
    [self.imageView setUserInteractionEnabled:YES];
    [self.imageView setMultipleTouchEnabled:YES];
}

#pragma mark - gesture
- (void)tapView:(UITapGestureRecognizer *)tapGestureRecognizer {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)doubleTapView:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (self.zoomScale > 1) {
        [self setZoomScale:1.0 animated:YES];
    } else {
        [self setZoomScale:2.0 animated:YES];

    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if (scrollView.zoomScale == 1) {
        NSLog(@"ll");
        CGFloat xOffset = 0;
        CGFloat yOffset = 0;
        if (self.width <= self.contentSize.width) {
            xOffset = (self.contentSize.width - self.width)*0.5;
        }
        if (self.height <= self.contentSize.height) {
            yOffset = (self.contentSize.height - self.height)*0.5;
        }
        self.contentOffset = CGPointMake(xOffset, yOffset);
    }
}



@end
