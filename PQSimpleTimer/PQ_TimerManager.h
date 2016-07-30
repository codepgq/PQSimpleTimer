//
//  PQ_TimerManager.h
//  PGQLZKugouDemo
//
//  Created by ios on 16/7/30.
//  Copyright © 2016年 PL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PQ_TIMERTYPE_CREATE = 0,
    PQ_TIMERTYPE_CREATE_OPEN,
}PQ_TimerType;

typedef void(^TimerUpdateBlock)();

@interface PQ_TimerManager : NSObject
/**
 *  快速创建一个定时器，用type区分要不要一开始就执行
 *
 *  @param type
 *  @param interval
 *  @param repeatInterval
 *  @param block
 *
 *  @return 
 */
+ (instancetype)pq_createTimerWithType:(PQ_TimerType)type updateInterval:(NSTimeInterval)interval repeatInterval:(NSTimeInterval)repeatInterval update:(TimerUpdateBlock)block;
/**
 *  打开
 */
- (void)pq_open;
/**
 *  关闭
 */
- (void)pq_close;
/**
 *  把时间设置为零
 */
- (void)pq_updateTimeIntervalToZero;
/**
 *  更新现在的时间
 *
 *  @param interval
 */
- (void)pq_updateTimeInterval:(NSTimeInterval)interval;
/**
 *  开机计时
 */
- (void)pq_start;
/**
 *  暂停计时
 */
- (void)pq_pause;
/**
 *  开始计时器
 */
- (void)pq_distantPast;
/**
 *  暂停计时器
 */
- (void)pq_distantFuture;

@end
