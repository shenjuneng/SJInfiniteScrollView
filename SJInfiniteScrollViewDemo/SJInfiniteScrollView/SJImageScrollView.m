//
//  SJImageScrollView.m
//  SJInfiniteScrollViewDemo
//
//  Created by 沈骏 on 2018/4/23.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import "SJImageScrollView.h"
#import "UIView+SJInfiniteScrollView.h"

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface SJImageScrollView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIView *refView;

@property (assign, nonatomic) CGRect oldRect;

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
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.clipsToBounds = NO;
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.imageView];

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
//            NSLog(@"%@", [NSThread currentThread]);
            [self setZoomScale:1 animated:YES];
        });
        
    });
    
    dispatch_barrier_sync(queue, ^{
//        NSLog(@"+++++");
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
//    CGRect frame = self.imageView.frame;
//
//    frame.origin.y = (self.frame.size.height - self.imageView.frame.size.height) > 0 ? (self.frame.size.height - self.imageView.frame.size.height) * 0.5 : 0;
//    frame.origin.x = (self.frame.size.width - self.imageView.frame.size.width) > 0 ? (self.frame.size.width - self.imageView.frame.size.width) * 0.5 : 0;
//    self.imageView.frame = frame;
//
//    self.contentSize = CGSizeMake(self.imageView.frame.size.width + 30, self.imageView.frame.size.height + 30);
}

#pragma mark - public
- (void)showSelfWithRefView:(UIView *)refView {
    self.refView = refView;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CGRect rect = [self.refView.superview convertRect:refView.frame toView:[UIApplication sharedApplication].keyWindow];
    
    CGFloat imageRate = self.imageView.image.size.width/self.imageView.image.size.height;
    CGFloat refViewRate = self.refView.width/self.refView.height;
    
    if (imageRate > refViewRate) {
        CGFloat w = rect.size.height*imageRate;
        CGFloat x = rect.origin.x - (w - rect.size.width)*0.5;
        rect.origin.x = x;
        rect.size.width = w;
    } else {
        CGFloat h = rect.size.width/imageRate;
        CGFloat y = rect.origin.y - (h - rect.size.height)*0.5;
        rect.origin.y = y;
        rect.size.height = h;
    }
    self.oldRect = rect;
    self.frame = self.oldRect;
    self.imageView.frame = self.bounds;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.27 animations:^{
            self.frame = [UIApplication sharedApplication].keyWindow.bounds;
            self.backgroundColor = [UIColor blackColor];
        } completion:^(BOOL finished) {
            
        }];
    });
}

- (void)hidenSelf {
    [UIView animateWithDuration:0.27 animations:^{
        self.frame = self.oldRect;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
