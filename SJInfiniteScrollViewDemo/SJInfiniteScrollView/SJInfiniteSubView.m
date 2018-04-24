//
//  SJInfiniteSubView.m
//  LearnX2
//
//  Created by 沈骏 on 2018/4/17.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import "SJInfiniteSubView.h"

@implementation SJInfiniteSubView

//- (instancetype)initView
//{
//    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"SJInfiniteSubView" owner:nil options:nil];
//    for (id object in objects) {
//        if ([object isKindOfClass:[SJInfiniteSubView class]]) {
//            self = object;
//        }
//    }
//
//    if (self) {
//
//    }
//
//    return self;
//}
//
//+ (instancetype)SJInfiniteSubView
//{
//    return [[self alloc] initView];
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView {
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.frame = self.bounds;
    self.imageView.clipsToBounds = YES;
    [self addSubview:self.imageView];
    
    self.lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.lb.font = [UIFont systemFontOfSize:30];
    [self addSubview:self.lb];
    self.lb.hidden = YES;
}

@end
