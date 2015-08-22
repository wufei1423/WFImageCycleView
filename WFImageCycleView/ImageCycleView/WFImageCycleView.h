//
//  WFImageCycleView.h
//  WFImageCycleView
//
//  Created by feiwu on 15/8/22.
//  Copyright (c) 2015年 feiwu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WFImageCycleViewScrollDirection) {
    WFImageCycleViewScrollDirectionHorizontal, // 水平滚动
    WFImageCycleViewScrollDirectionVertical, // 垂直滚动
};

@class WFImageCycleView;

@protocol WFImageCycleViewDataSource <NSObject>

@required

- (NSUInteger)countOfImagesInCycleView:(WFImageCycleView *)cycleView;

- (UIImage *)imageInCycleView:(WFImageCycleView *)cycleView atIndex:(NSUInteger)index;

@end

@interface WFImageCycleView : UIView

@property (nonatomic, weak) id<WFImageCycleViewDataSource> dataSource;

@property (nonatomic, assign) WFImageCycleViewScrollDirection scrollDirection; // default WFImageCycleViewScrollDirectionhorizontal

@property (nonatomic, assign) NSUInteger displayPageIndex; // default 0

@end
