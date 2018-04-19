//
//  SJInfiniteItem.h
//  LearnX2
//
//  Created by 沈骏 on 2018/4/19.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SJItemAssetImage = 0,
    SJItemWebImage,
} SJItemType;

@interface SJInfiniteItem : NSObject

@property (copy, nonatomic) NSString *imageUrl;

@property (copy, nonatomic) NSString *imageName;

@property (assign, nonatomic) SJItemType type;

@end
