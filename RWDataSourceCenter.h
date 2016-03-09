//
//  RWDataSourceCenter.h
//  SunnyFreelander
//
//  Created by RyeWhiskey on 16/3/6.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWDatabaseManager.h"

@interface RWDataSourceCenter : NSObject
/**
 *  获取数据中心单例对对象
 *
 *  @return
 */
+ (RWDataSourceCenter *)sharedDataSourceCenter;
/**
 *  插入一条体重信息
 *
 *  @param weight
 *
 *  @return
 */
- (BOOL)insertWeight:(NSString *)weight;
/**
 *  删除一条体重信息
 *
 *  @param model
 *
 *  @return
 */
- (BOOL)deleteWeight:(RWWeightModel *)model;
/**
 *  删除指定日子的全部数据
 *
 *  @param model
 *
 *  @return 
 */
- (BOOL)deleteWeightOfDay:(RWWeightEntityModel *)model;
/**
 *  清除全部体重数据
 *
 *  @return
 */
- (BOOL)deleteAllDate;
/**
 *  变更一条体重信息
 *
 *  @param model
 *
 *  @return
 */
- (BOOL)updateWeight:(RWWeightModel *)model;
/**
 *  获取最小单位为天的全部数据
 *
 *  @return
 */
- (NSArray <NSArray <RWWeightEntityModel *>*>*)obtainWeightInformation;
/**
 *  获取当日的全部数据   ** RWWeightEntityModel.lastWeight -> "time||weight"
 *
 *  @param date  RWWeightEntityModel -> dateid
 *  @param month RWWeightEntityModel -> monthDate
 *
 *  @return 
 */
- (NSArray <RWWeightModel *>*)obtainAllDayWeight:(NSDate *)date AndMonthWeight:(NSDate *)month;
/**
 *  获取月列表
 *
 *  @param mod
 *
 *  @return
 */
- (NSArray <RWWeightEntityModel *>*)obtainWeightWithMonth:(RWWeightMonthModel *)mod;

@end

typedef enum date{
    
    RWDataOfYearAndMonth = 0,
    RWDateOfMonthAndDay = 1,
    RWDateOfTime = 2
    
}RWDate;

/**
 *  定时器代理方法
 */
@protocol RWDataProcessingTimerSource <NSObject>
/**
 *  定时器返回时间字符串
 *
 *  @param showtime
 */
- (void)realtimeOfTimer:(NSString *)showtime;

@end

@interface RWDataProcessingPlant : NSObject

@property (nonatomic,assign)id<RWDataProcessingTimerSource>timerSource;

#pragma mark - 计时器
//获取一个定时器 获取既开启 实现代理方法获取时间
- (void)obtainNewTimer;
//定时器停止 时间清零
- (void)stopTimer;
//开始定时器
- (void)startTimer;
//暂停定时器
- (void)suspendedTimer;
//重置定时器 时间清零
- (void)reloadTimer;

#pragma mark - 时间 以及日期的处理
// yyyy-MM-dd HH:mm:ss
+ (NSString *)obtainSystemDate;
// yyyy-MM
+ (NSString *)obtainYearAndMonth;
// yyyy-MM-dd
+ (NSString *)obtainYearMonthAndDay;
// HH:mm:ss
+ (NSString *)obtainTime;
//转换time
+ (NSString *)stringTime:(NSDate *)time;
//转换day
+ (NSString *)stringDay:(NSDate *)day;
//转换month
+ (NSString *)stringMonth:(NSDate *)month;
//获取数据库标签
+ (NSArray <NSDate *>*)obtainDate;

#pragma mark - other
//清除数组的某个元素
+ (NSArray *)clearSomeElementWithElement:(id)element ForArray:(NSArray *)array;

@end
