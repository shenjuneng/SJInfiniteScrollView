//
//  SJImageScrollView.h
//  SJInfiniteScrollViewDemo
//
//  Created by 沈骏 on 2018/4/23.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJImageScrollView : UIScrollView

@property (strong, nonatomic) UIImageView *imageView;

- (void)showSelfWithRefView:(UIView *)refView;

@end
