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
#import "UIImageView+WebCache.h"


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
    self.sc.availableTimer = YES;
    
    NSArray *arri = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524562906236&di=70c730ce37ca5f342488f85282eb7cd7&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201601%2F29%2F20160129153406_mEQFH.jpeg",
                     @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=476407592,44588448&fm=27&gp=0.jpg",
                     @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=183400027,2782512857&fm=27&gp=0.jpg",
                     @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=27406517,369827068&fm=11&gp=0.jpg"];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < 11; i++) {
//        NSString *str = [NSString stringWithFormat:@"小清新%zd", i%6 + 1];
        NSDictionary *dic = @{@"type":@"1", @"imageUrl": arri[i%4]};
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
//    UIImage *img = [UIImage imageNamed:item.imageUrl];
//    [];
    
    self.sView = [[SJImageScrollView alloc] init];
    [self.sView.imageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl]];
    [self.sView showSelfWithRefView:self.sc];
}

- (IBAction)clickTest:(id)sender {
    
}

@end
