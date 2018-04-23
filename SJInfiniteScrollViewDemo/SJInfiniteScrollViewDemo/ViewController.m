//
//  ViewController.m
//  SJInfiniteScrollViewDemo
//
//  Created by 沈骏 on 2018/4/20.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import "ViewController.h"
#import "SJInfiniteScrollView.h"
#import <MJExtension.h>

@interface ViewController ()
<SJInfiniteScrollViewDelegate, SJInfiniteScrollViewDataSource>

@property (weak, nonatomic) IBOutlet SJInfiniteScrollView *sc;

@property (weak, nonatomic) IBOutlet UILabel *pageLb;

@property (strong, nonatomic) NSArray *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.sc.infiniteDelegate = self;
    self.sc.infiniteDataSource = self;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < 11; i++) {
        NSString *str = [NSString stringWithFormat:@"小清新%zd", i%4 + 1];
        NSDictionary *dic = @{@"type":@"0", @"imageName": str};
        [arr addObject:[SJInfiniteItem mj_objectWithKeyValues:dic]];
    }
    self.dataList = arr;
    [self.sc reloadScrollView];
}



#pragma mark - SJInfiniteScrollViewDataSource
- (NSInteger)infiniteItemCount {
    return self.dataList.count;
}

- (SJInfiniteItem *)infiniteItemWithIndex:(NSInteger)index {
    return self.dataList[index];
}

#pragma mark - SJInfiniteScrollViewDelegate
- (void)infiniteScrollView:(SJInfiniteScrollView *)view changeCurrentPageIndex:(NSInteger)index {
    self.pageLb.text = [NSString stringWithFormat:@"%zd", index];
}

- (void)infiniteScrollView:(SJInfiniteScrollView *)view selectIndex:(NSInteger)index {
    NSLog(@"%zd", index);
//    SJInfiniteItem *item = self.dataList[index];
//    UIImage *img = [UIImage imageNamed:item.imageName];
//    UIImageView *imgview = [[UIImageView alloc] initWithImage:img];
//    imgview.contentMode = UIViewContentModeScaleAspectFill;
//    imgview.clipsToBounds = YES;
////    [self.sc addSubview: imgview];
////    imgview.frame = self.sc.bounds;
//    [[UIApplication sharedApplication].keyWindow addSubview:imgview];
//    CGRect rect = [self.view convertRect:self.sc.frame toView:[UIApplication sharedApplication].keyWindow];
//    imgview.frame = rect;
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        imgview.frame = [UIApplication sharedApplication].keyWindow.bounds;
//    } completion:^(BOOL finished) {
//    }];
}

@end
