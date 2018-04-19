//
//  SJInfiniteSubView.h
//  LearnX2
//
//  Created by 沈骏 on 2018/4/17.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJInfiniteSubView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *lb;

- (instancetype)initView;

+ (instancetype)SJInfiniteSubView;

@end
