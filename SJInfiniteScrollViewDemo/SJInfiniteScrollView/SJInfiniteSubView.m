//
//  SJInfiniteSubView.m
//  LearnX2
//
//  Created by 沈骏 on 2018/4/17.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import "SJInfiniteSubView.h"

@implementation SJInfiniteSubView

- (instancetype)initView
{
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"SJInfiniteSubView" owner:nil options:nil];
    for (id object in objects) {
        if ([object isKindOfClass:[SJInfiniteSubView class]]) {
            self = object;
        }
    }
    
    if (self) {
        
    }
    
    return self;
}

+ (instancetype)SJInfiniteSubView
{
    return [[self alloc] initView];
}

@end
