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

@property (strong, nonatomic) UIView *refView;

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
    
    self.backgroundColor = [UIColor clearColor];
//    UIImage *image = [UIImage alloc] init;
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = NO;
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
    
    dispatch_queue_t queue = dispatch_queue_create("d", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", [NSThread currentThread]);
            [self setZoomScale:1 animated:YES];
        });
        
    });
    
    dispatch_barrier_sync(queue, ^{
        NSLog(@"+++++");
    });
    
    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
             [self hidenSelf];
        });
    });
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
    
//    self.contentSize = self.imageView.size;
}

#pragma mark - public
- (void)showSelfWithRefView:(UIView *)refView {
    self.refView = refView;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CGRect rect = [self.refView.superview convertRect:refView.frame toView:[UIApplication sharedApplication].keyWindow];
    NSLog(@"%@", NSStringFromCGRect(rect));
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(rect.origin.y));
        make.left.equalTo(@(rect.origin.x));
        make.size.equalTo(refView);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.27 animations:^{
            //        sv.frame = [UIApplication sharedApplication].keyWindow.bounds;
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(0));
                make.left.equalTo(@(0));
                make.size.equalTo([UIApplication sharedApplication].keyWindow);
            }];
            [[UIApplication sharedApplication].keyWindow layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    });
}

- (void)hidenSelf {
    CGRect rect = [self.refView.superview convertRect:self.refView.frame toView:[UIApplication sharedApplication].keyWindow];
    NSLog(@"%@", NSStringFromCGRect(self.refView.frame));
    [UIView animateWithDuration:0.27 animations:^{
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(rect.origin.y));
            make.left.equalTo(@(rect.origin.x));
            make.size.mas_equalTo(CGSizeMake(240, 362));
        }];
        [[UIApplication sharedApplication].keyWindow layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
