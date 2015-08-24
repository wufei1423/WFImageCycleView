//
//  WFImageCycleView.h
//  WFImageCycleView
//
//  Created by feiwu on 15/8/22.
//  Copyright (c) 2015年 feiwu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WFImageCycleViewScrollDirection) {
    WFImageCycleViewScrollDirectionHorizontal,
    WFImageCycleViewScrollDirectionVertical,
};

@class WFImageCycleView;

@protocol WFImageCycleViewDataSource <NSObject>

@required

- (NSUInteger)countOfImagesInCycleView:(WFImageCycleView *)cycleView;

- (UIImage *)imageCycleView:(WFImageCycleView *)cycleView imageAtIndex:(NSUInteger)index;

@end

@protocol WFImageCycleViewDelegate <NSObject>

@optional

- (void)imageCycleView:(WFImageCycleView *)cycleView didScrollToImageAtIndex:(NSUInteger)index;

@end

@interface WFImageCycleView : UIView

@property (nonatomic, weak) id<WFImageCycleViewDataSource> dataSource;
@property (nonatomic, weak) id<WFImageCycleViewDelegate> delegate;

/**
 *  default WFImageCycleViewScrollDirectionhorizontal
 */
@property (nonatomic, assign) WFImageCycleViewScrollDirection scrollDirection;

/**
 *  default 0, first page
 */
@property (nonatomic, assign) NSUInteger displayPageIndex;

/**
 *  default 0, not auto scroll
 */
@property (nonatomic, assign) NSTimeInterval autoScrollTimeInterval;

@end
