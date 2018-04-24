//
//  SecondVC.m
//  SJInfiniteScrollViewDemo
//
//  Created by 沈骏 on 2018/4/24.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import "SecondVC.h"

@interface SecondVC ()

@property (strong, nonatomic) UIScrollView *sc;

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.sc = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 100, 200, 300)];
    self.sc.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.sc];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"小清新6"]];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.frame = self.sc.bounds;
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.sc addSubview:self.imageView];
}

- (IBAction)clickToBig:(UIButton *)sender {
    
    self.sc.frame = CGRectMake(10, 100, 300, 400);
}


@end
