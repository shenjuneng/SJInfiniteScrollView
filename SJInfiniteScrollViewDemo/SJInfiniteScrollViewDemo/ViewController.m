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
#import "Masonry.h"

@interface ViewController ()
<SJInfiniteScrollViewDelegate, SJInfiniteScrollViewDataSource>

@property (weak, nonatomic) IBOutlet SJInfiniteScrollView *sc;

@property (weak, nonatomic) IBOutlet UILabel *pageLb;

@property (strong, nonatomic) NSArray *dataList;

@property (strong, nonatomic) SJImageScrollView *sView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.sc.infiniteDelegate = self;
    self.sc.infiniteDataSource = self;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < 11; i++) {
        NSString *str = [NSString stringWithFormat:@"小清新%zd", i%6 + 1];
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
    SJInfiniteItem *item = self.dataList[index];
    UIImage *img = [UIImage imageNamed:item.imageName];
    
//    SJImageScrollView *sv = [[SJImageScrollView alloc] init];
    self.sView = [[SJImageScrollView alloc] init];
    [self.sView.imageView setImage:img];
//    [[UIApplication sharedApplication].keyWindow addSubview:sv];
//    CGRect rect = [self.view convertRect:self.sc.frame toView:[UIApplication sharedApplication].keyWindow];
    [self.navigationController.view addSubview:self.sView];
    CGRect rect = [self.view convertRect:self.sc.frame toView:self.navigationController.view];
//    sv.frame = rect;
    [self.sView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(rect.origin.y));
        make.left.equalTo(@(rect.origin.x));
        make.size.equalTo(self.sc);
    }];
    
    
    
}
- (IBAction)clickTest:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        //        sv.frame = [UIApplication sharedApplication].keyWindow.bounds;
        [self.sView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(0));
            make.left.equalTo(@(0));
            make.size.equalTo(self.navigationController.view);
        }];
        [self.navigationController.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}

@end
