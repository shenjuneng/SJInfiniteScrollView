//
//  SJInfiniteScrollView.h
//  LearnX2
//
//  Created by 沈骏 on 2018/4/17.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJInfiniteItem.h"
#import "UIView+SJInfiniteScrollView.h"

@class SJInfiniteScrollView;

@protocol SJInfiniteScrollViewDataSource<NSObject>

@required

- (NSInteger)infiniteItemCount;


- (SJInfiniteItem *)infiniteItemWithIndex:(NSInteger)index;

@end

@protocol SJInfiniteScrollViewDelegate<NSObject>

@optional

- (void)infiniteScrollView:(SJInfiniteScrollView *)view
    changeCurrentPageIndex:(NSInteger)index;

- (void)infiniteScrollView:(SJInfiniteScrollView *)view
               selectIndex:(NSInteger)index;

@end

@interface SJInfiniteScrollView : UIScrollView

/** available */
@property (assign, nonatomic) BOOL availableTimer;

/** delegate */
@property (weak, nonatomic) id<SJInfiniteScrollViewDelegate> infiniteDelegate;

/** dataSource */
@property (weak, nonatomic) id<SJInfiniteScrollViewDataSource> infiniteDataSource;

- (void)reloadScrollView;

- (void)nextPage;

@end
