//
//  ViewController.m
//  WFImageCycleView
//
//  Created by feiwu on 15/8/22.
//  Copyright (c) 2015年 feiwu. All rights reserved.
//

#import "ViewController.h"
#import "WFImageCycleView.h"

@interface ViewController () <WFImageCycleViewDataSource, WFImageCycleViewDelegate>

@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WFImageCycleView *cycleView = [[WFImageCycleView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    cycleView.scrollDirection = WFImageCycleViewScrollDirectionHorizontal;
    cycleView.autoScrollTimeInterval = 2;
    cycleView.dataSource = self;
    cycleView.delegate = self;
    [self.view addSubview:cycleView];
}

- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
        [_images addObject:[UIImage imageNamed:@"image0.jpg"]];
        [_images addObject:[UIImage imageNamed:@"image1.jpg"]];
        [_images addObject:[UIImage imageNamed:@"image2.jpg"]];
        [_images addObject:[UIImage imageNamed:@"image3.jpg"]];
        [_images addObject:[UIImage imageNamed:@"image4.jpg"]];
    }
    return _images;
}

#pragma mark - WFImageCycleViewDataSource

- (NSUInteger)countOfImagesInCycleView:(WFImageCycleView *)cycleView;
{
    return self.images.count;
}

- (UIImage *)imageCycleView:(WFImageCycleView *)cycleView imageAtIndex:(NSUInteger)index
{
    return self.images[index];
}

#pragma mark - WFImageCycleViewDelegate

- (void)imageCycleView:(WFImageCycleView *)cycleView didScrollToImageAtIndex:(NSUInteger)index
{
    NSLog(@"current index is %zd", index);
}

@end
