//
//  ViewController.m
//  SJInfiniteScrollViewDemo
//
//  Created by 沈骏 on 2018/4/19.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import "ViewController.h"
#import "SJInfiniteScrollView.h"
#import <MJExtension.h>

@interface ViewController ()
<SJInfiniteScrollViewDelegate, SJInfiniteScrollViewDataSource>

@property (weak, nonatomic) IBOutlet SJInfiniteScrollView *sc;

@property (weak, nonatomic) IBOutlet UIImageView *testImage;

@property (weak, nonatomic) IBOutlet UILabel *pageLb;

@property (strong, nonatomic) NSArray *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.sc.infiniteDelegate = self;
    self.sc.infiniteDataSource = self;
    
    NSArray *arr = @[@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2958139619,1451793191&fm=27&gp=0.jpg",
                     @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1685382092,1727136322&fm=27&gp=0.jpg",
                     @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=284552213,3359816284&fm=27&gp=0.jpg",
                     @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1622756279,3823459048&fm=27&gp=0.jpg"];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 20; i++) {
//        NSString *str = [NSString stringWithFormat:@"小清新%zd", i%4+1];
        NSDictionary *dic = @{@"imageUrl" : arr[i%4],
                              @"type" : @"1"};
        [tempArr addObject:[SJInfiniteItem mj_objectWithKeyValues:dic]];
    }
    
    self.dataList = tempArr;
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

@end
