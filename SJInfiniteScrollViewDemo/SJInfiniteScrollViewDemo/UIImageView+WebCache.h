//
//  UIImageView+WebCache.h
//  SJInfiniteScrollViewDemo
//
//  Created by 沈骏 on 2018/4/20.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebCache)

- (void)sd_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)image;

@end
