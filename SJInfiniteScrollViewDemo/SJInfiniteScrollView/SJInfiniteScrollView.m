//
//  SJInfiniteScrollView.m
//  LearnX2
//
//  Created by 沈骏 on 2018/4/17.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import "SJInfiniteScrollView.h"
#import "SJInfiniteSubView.h"

#define StartPage 4
#define PageCount 10

@interface SJInfiniteScrollView () <UIScrollViewDelegate>

// 拖动时候的偏移量
@property (nonatomic, assign) CGFloat offset;

/** 子视图数组 */
@property (strong, nonatomic) NSMutableArray *subViewsArr;

/** 最前面 */
@property (assign, nonatomic) NSInteger foremostIndex;

/** 最后面 */
@property (assign, nonatomic) NSInteger backmostIndex;

/** 记录当前页数 */
@property (assign, nonatomic) NSInteger currentPage;

@property (strong, nonatomic) NSTimer *browseTimer;

@end

@implementation SJInfiniteScrollView

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
    self.pagingEnabled = YES;
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 记录拖动开始的偏移量
//    self.offset = scrollView.contentOffset.x;
    [self destroyBrowseTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offset = scrollView.contentOffset.x + self.offset;
    
    [self calculatePageWithOffset:offset];
    
    [self buildBrowseTimer];
}

- (void)calculatePageWithOffset:(CGFloat)offset {
    NSInteger page = floor((offset - self.width*StartPage - self.width/2)/self.width)+1;
    
    if (page >= 0) {
        self.currentPage = page%[self.infiniteDataSource infiniteItemCount];
    } else {
        
        self.currentPage = [self.infiniteDataSource infiniteItemCount] - (-page)%[self.infiniteDataSource infiniteItemCount];
        if (self.currentPage == [self.infiniteDataSource infiniteItemCount]) {
            self.currentPage = 0;
        }
    }
    
    if ([self.infiniteDelegate respondsToSelector:@selector(infiniteScrollView:changeCurrentPageIndex:)]) {
        [self.infiniteDelegate infiniteScrollView:self changeCurrentPageIndex:self.currentPage];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currentOffset = scrollView.contentOffset.x;
    
    if (currentOffset < self.width*2) {
        SJInfiniteSubView *lastView = self.subViewsArr.lastObject;
        lastView.frame = CGRectMake(self.width, 0, self.width, self.height);

        [self.subViewsArr removeObject:lastView];
        [self.subViewsArr insertObject:lastView atIndex:0];

        SJInfiniteSubView *secondLast = self.subViewsArr.lastObject;
        secondLast.frame = CGRectMake(0, 0, self.width, self.height);
        [self.subViewsArr removeObject:secondLast];
        [self.subViewsArr insertObject:secondLast atIndex:0];
        
        self.foremostIndex -= 2;
        NSInteger foremostTemp = self.foremostIndex;
        NSInteger secondForemostTemp = self.foremostIndex + 1;
        if (secondForemostTemp < 0) {
            secondForemostTemp = [self.infiniteDataSource infiniteItemCount] - 1;
            foremostTemp = secondForemostTemp - 1;
            if (foremostTemp < 0) {
                foremostTemp = [self.infiniteDataSource infiniteItemCount] - 1;
            }
        } else if (foremostTemp < 0) {
            foremostTemp = [self.infiniteDataSource infiniteItemCount] - 1;
        }
        
        self.foremostIndex = foremostTemp;
        self.backmostIndex = (self.backmostIndex + [self.infiniteDataSource infiniteItemCount] - 2)%[self.infiniteDataSource infiniteItemCount];
        
//        [lastView.imageView setImage:[UIImage imageNamed:self.dataList[secondForemostTemp]]];
//        lastView.lb.text = [NSString stringWithFormat:@"%zd", secondForemostTemp];
        [self infiniteSubView:lastView index:secondForemostTemp];
        
//        [secondLast.imageView setImage:[UIImage imageNamed:self.dataList[foremostTemp]]];
//        secondLast.lb.text = [NSString stringWithFormat:@"%zd", foremostTemp];
        [self infiniteSubView:secondLast index:foremostTemp];
        
        for (NSInteger i = 2; i < self.subViewsArr.count;i++) {
            UIView *view = self.subViewsArr[i];
            view.frame = CGRectMake(self.width*i, 0, self.width, self.height);
        }
        scrollView.contentOffset = CGPointMake(currentOffset + self.width*2, 0);

        self.offset -= self.width*2;
    } else if (currentOffset >= self.width*8) {
        SJInfiniteSubView *firstView = self.subViewsArr.firstObject;
        firstView.frame = CGRectMake(self.width*6, 0, self.width, self.height);
        [self.subViewsArr removeObject:firstView];
        [self.subViewsArr addObject:firstView];
        
        SJInfiniteSubView *secondView = self.subViewsArr.firstObject;
        secondView.frame = CGRectMake(self.width*7, 0, self.width, self.height);
        [self.subViewsArr removeObject:secondView];
        [self.subViewsArr addObject:secondView];
        
        SJInfiniteSubView *thridView = self.subViewsArr.firstObject;
        thridView.frame = CGRectMake(self.width*8, 0, self.width, self.height);
        [self.subViewsArr removeObject:thridView];
        [self.subViewsArr addObject:thridView];
        
        SJInfiniteSubView *fourthView = self.subViewsArr.firstObject;
        fourthView.frame = CGRectMake(self.width*9, 0, self.width, self.height);
        [self.subViewsArr removeObject:fourthView];
        [self.subViewsArr addObject:fourthView];
        
        NSArray *viewArr = @[firstView, secondView, thridView, fourthView];
        
        NSInteger offset = (self.backmostIndex + 1)%[self.infiniteDataSource infiniteItemCount];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSInteger i = 0; i < 4; i++) {
            NSInteger index = (i + offset)%[self.infiniteDataSource infiniteItemCount];
            [tempArr addObject:@(index)];
        }

        self.backmostIndex = [tempArr.lastObject integerValue];
        self.foremostIndex = (self.foremostIndex + 4)%[self.infiniteDataSource infiniteItemCount];
        
        NSInteger i = 0;
        for (SJInfiniteSubView *view in viewArr) {
//            [view.imageView setImage:[UIImage imageNamed:self.dataList[[tempArr[i] integerValue]]]];
//            view.lb.text = [NSString stringWithFormat:@"%zd", [tempArr[i] integerValue]];
            [self infiniteSubView:view index:[tempArr[i] integerValue]];
            i++;
        }
    
        for (NSInteger i = 0; i < self.subViewsArr.count - 4;i++) {
            UIView *view = self.subViewsArr[i];
            view.frame = CGRectMake(self.width*i, 0, self.width, self.height);
        }
        scrollView.contentOffset = CGPointMake(currentOffset - self.width*4, 0);
        
        self.offset += self.width*4;
    }
}

- (void)infiniteSubView:(SJInfiniteSubView *)view index:(NSInteger)index {
    SJInfiniteItem *item = [self.infiniteDataSource infiniteItemWithIndex:index];
    
    switch (item.type) {
        case SJItemAssetImage:
            [view.imageView setImage:[UIImage imageNamed:item.imageName]];
            break;
        case SJItemWebImage:
            [view.imageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl] placeholderImage:nil];
        default:
            break;
    }
    view.lb.text = [NSString stringWithFormat:@"%zd", index];
}

#pragma mark - public
- (void)reloadScrollView {
    self.subViewsArr = [NSMutableArray array];
    
    CGFloat xView = 0;
    for (NSInteger i = 0; i < PageCount; i++) {
        
        SJInfiniteSubView *view = [SJInfiniteSubView SJInfiniteSubView];
        view.frame = CGRectMake(xView, 0, self.width, self.height);
        view.backgroundColor = [UIColor yellowColor];
        [self.subViewsArr addObject:view];
        [self addSubview:view];
      
        
        
        if (i < StartPage) {
            NSInteger offset = [self.infiniteDataSource infiniteItemCount] - 1 - (StartPage - 1)%[self.infiniteDataSource infiniteItemCount];
            NSInteger foreIndex = (i + offset)%[self.infiniteDataSource infiniteItemCount];
            [self infiniteSubView:view index:foreIndex];
            if (i == 0) {
                self.foremostIndex = foreIndex;
            }
        } else if (i >= StartPage) {
            NSInteger backIndex = (i - StartPage)%[self.infiniteDataSource infiniteItemCount];
            [self infiniteSubView:view index:backIndex];
            if (i == PageCount - 1) {
                self.backmostIndex = backIndex;
            }
        }
        
        
        xView += self.width;
    }
    
    self.currentPage = 0;
    if ([self.infiniteDelegate respondsToSelector:@selector(infiniteScrollView:changeCurrentPageIndex:)]) {
        [self.infiniteDelegate infiniteScrollView:self changeCurrentPageIndex:self.currentPage];
    }
    
    self.contentSize = CGSizeMake(self.width*PageCount, 0);
    self.contentOffset = CGPointMake(self.width*StartPage, 0);
    
    [self buildBrowseTimer];
}

- (void)nextPage {
    CGFloat offset = self.contentOffset.x;
    
    NSLog(@"%f", offset);

    [self setContentOffset:CGPointMake(offset + self.width, 0) animated:YES];
    
    [self calculatePageWithOffset:self.contentOffset.x + self.offset + self.width];
}


- (void)buildBrowseTimer
{
    if (self.availableTimer == NO) {
        return;
    }
    CGFloat timef = 2;
    self.browseTimer = [NSTimer scheduledTimerWithTimeInterval:timef target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.browseTimer forMode:NSRunLoopCommonModes];
}

- (void)destroyBrowseTimer
{
    if (self.availableTimer == NO) {
        return;
    }
    [self.browseTimer invalidate];
    self.browseTimer = nil;
}

@end
