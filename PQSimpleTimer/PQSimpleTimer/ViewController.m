//
//  ViewController.m
//  PQSimpleTimer
//
//  Created by ios on 16/7/30.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "ViewController.h"
#import "PQ_TimerManager.h"
#import "UIView+PQViewExtension.h"
#define PL_SRCEEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define RANDOM_COLOR [UIColor colorWithRed:random()%200/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1 ]
@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic)  UIPageControl *pageControl;
@property (nonatomic,strong) PQ_TimerManager *timerManager;;
@end

@implementation ViewController{
    NSInteger _pageIndex;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpForTopScrollView];
    [self setUpForPageControl];
    
    //建立一个定时器 轮播
    [self createTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    self.pageControl.centerX = self.scrollView.centerX;
}


//public

- (void)startTopScrollViewTimer{
    [self.timerManager pq_open];
    //    NSLog(@"打开了定时器");
}

- (void)closeTopScrollViewTimer{
    [self.timerManager pq_close];
    //    NSLog(@"关闭了定时器");
}

// my method
- (void)createTimer{
    self.timerManager = [PQ_TimerManager pq_createTimerWithType:PQ_TIMERTYPE_CREATE_OPEN updateInterval:3 repeatInterval:1 update:^{
        _pageIndex ++;
        if (_pageIndex >= 5) {
            _pageIndex = 0;
        }
        //这里调用方法后不会到滑动停止的方法 所以要自己在开始定时器
        [self.scrollView setContentOffset:CGPointMake(_pageIndex * PL_SRCEEN_WIDTH, 0) animated:YES];
        self.pageControl.currentPage = _pageIndex;
    }];
}

- (void)setUpForPageControl{
    UIPageControl * pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, PL_SRCEEN_WIDTH, 20)];
    self.pageControl = pageControl;
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    [self.view addSubview:self.pageControl];
    pageControl.y = CGRectGetMaxY(self.scrollView.frame)-20;
}

- (void)setUpForTopScrollView{
    for (int i = 0; i < 5; i++) {
        UIView * view = [[UIView alloc]initWithFrame:self.scrollView.bounds];
        view.x = i * PL_SRCEEN_WIDTH;
        view.backgroundColor = RANDOM_COLOR;
        [self.scrollView addSubview:view];
    }
    self.scrollView.contentSize = CGSizeMake(5 * PL_SRCEEN_WIDTH, 0);
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //手动滑动的时候暂停计时
    [self.timerManager pq_pause];
}

- (void) scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = sender.frame.size.width;
    _pageIndex = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = _pageIndex;
    //滑动结束，这个时候我们应该把计时器归零，在计算
    [self.timerManager pq_updateTimeIntervalToZero];
    [self.timerManager pq_start];
}

@end
