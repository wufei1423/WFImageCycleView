//
//  WFImageCycleView.m
//  WFImageCycleView
//
//  Created by feiwu on 15/8/22.
//  Copyright (c) 2015年 feiwu. All rights reserved.
//

#import "WFImageCycleView.h"

static const NSUInteger WFImageViewCount = 3;

@interface WFImageCycleView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *imageViews;

@end

@implementation WFImageCycleView

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = WFImageCycleViewScrollDirectionhorizontal;
        self.displayPageIndex = 0;
    }
    return self;
}

#pragma mark - lazy load

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (NSMutableArray *)imageViews
{
    if (_imageViews == nil) {
        _imageViews = [NSMutableArray array];
        for (NSUInteger i = 0; i < WFImageViewCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [self.scrollView addSubview:imageView];
            [_imageViews addObject:imageView];
        }
    }
    return _imageViews;
}

#pragma mark - override

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    CGFloat contentSizeW = (self.scrollDirection == WFImageCycleViewScrollDirectionhorizontal ? self.bounds.size.width * WFImageViewCount : self.bounds.size.width);
    CGFloat contentSizeH = (self.scrollDirection == WFImageCycleViewScrollDirectionVertical ? self.bounds.size.height * WFImageViewCount : self.bounds.size.height);
    self.scrollView.contentSize = CGSizeMake(contentSizeW, contentSizeH);
    
    CGFloat imageViewX = 0;
    CGFloat imageViewY = 0;
    CGFloat imageViewW = self.bounds.size.width;
    CGFloat imageViewH = self.bounds.size.height;
    for (NSUInteger i = 0; i < self.imageViews.count; i++) {
        UIImageView *imageView = self.imageViews[i];
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        if (self.scrollDirection == WFImageCycleViewScrollDirectionhorizontal) {
            imageViewX += imageViewW;
        } else {
            imageViewY += imageViewH;
        }
    }
    
    [self loadImages];
}

#pragma mark - private method

- (void)loadImages
{
    CGFloat contentOffsetX = (self.scrollDirection == WFImageCycleViewScrollDirectionhorizontal ? self.scrollView.bounds.size.width : 0);
    CGFloat contentOffsetY = (self.scrollDirection == WFImageCycleViewScrollDirectionVertical ? self.scrollView.bounds.size.height : 0);
    self.scrollView.contentOffset = CGPointMake(contentOffsetX, contentOffsetY);
    
    UIImageView *imageView0 = self.imageViews[0];
    imageView0.image = [self.dataSource imageInCycleView:self atIndex:[self previousPageIndex]];
    
    UIImageView *imageView1 = self.imageViews[1];
    imageView1.image = [self.dataSource imageInCycleView:self atIndex:self.displayPageIndex];
    
    UIImageView *imageView2 = self.imageViews[2];
    imageView2.image = [self.dataSource imageInCycleView:self atIndex:[self nextPageIndex]];
}

- (NSUInteger)previousPageIndex
{
    NSUInteger imageCount = [self.dataSource countOfImagesInCycleView:self];
    
    if (self.displayPageIndex == 0) {
        return imageCount - 1;
    } else {
        return self.displayPageIndex - 1;
    }
}

- (NSUInteger)nextPageIndex
{
    NSUInteger imageCount = [self.dataSource countOfImagesInCycleView:self];
    
    if (self.displayPageIndex == imageCount - 1) {
        return 0;
    } else {
        return self.displayPageIndex + 1;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollDirection == WFImageCycleViewScrollDirectionhorizontal) {
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        if (contentOffsetX <= 0) {
            self.displayPageIndex = [self previousPageIndex];
            [self loadImages];
        } else if (contentOffsetX >= self.scrollView.bounds.size.width * (WFImageViewCount - 1)) {
            self.displayPageIndex = [self nextPageIndex];
            [self loadImages];
        }
    } else {
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        if (contentOffsetY <= 0) {
            self.displayPageIndex = [self previousPageIndex];
            [self loadImages];
        } else if (contentOffsetY >= self.scrollView.bounds.size.height * (WFImageViewCount - 1)) {
            self.displayPageIndex = [self nextPageIndex];
            [self loadImages];
        }
    }
}

@end
