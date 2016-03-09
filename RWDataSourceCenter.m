//
//  RWDataSourceCenter.m
//  SunnyFreelander
//
//  Created by RyeWhiskey on 16/3/6.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWDataSourceCenter.h"


@interface RWDataSourceCenter ()

{
    @protected
    RWDatabaseManager *manager;
    
}

@end

@implementation RWDataSourceCenter

+ (RWDataSourceCenter *)sharedDataSourceCenter{
    
    static RWDataSourceCenter *_Only = nil;
    dispatch_once_t onceToKen;
    dispatch_once(&onceToKen, ^{
        _Only = [[super allocWithZone:NULL]init];
    });
    return _Only;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self sharedDataSourceCenter];
}

- (void)obtainDatabase{
    if (manager == nil) {
        manager = [RWDatabaseManager sharedDataBaseManager];
    }
}

- (BOOL)insertWeight:(NSString *)weight{
    [self obtainDatabase];
    
    NSArray *arr = [RWDataProcessingPlant obtainDate];
    
    RWWeightModel *weightModel = [[RWWeightModel alloc]init];
    NSString *time = [RWDataProcessingPlant obtainTime];
    weightModel.weight = [NSString stringWithFormat:@"%@||%@",time,weight];
    weightModel.dayDate = arr[RWDateOfMonthAndDay];
    weightModel.monthDate = arr[RWDataOfYearAndMonth];
    
    return [manager insertWeight:weightModel];
}

- (BOOL)deleteWeight:(RWWeightModel *)model{
    [self obtainDatabase];
    return [manager deleteWeight:model];
}

- (BOOL)deleteWeightOfDay:(RWWeightEntityModel *)model{
    [self obtainDatabase];
    return [manager deleteWeightOfDay:model];
}

- (BOOL)deleteAllDate{
    [self obtainDatabase];
    return [manager deleteAllWeight];
}

- (BOOL)updateWeight:(RWWeightModel *)model{
    [self obtainDatabase];
    return [manager upDataWeight:model];
}

- (NSArray <NSArray <RWWeightEntityModel *>*>*)obtainWeightInformation{
    [self obtainDatabase];
    NSArray *monList = [manager obtainMonthList];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < monList.count; i++) {

        [arr addObject:[self obtainWeightWithMonth:monList[i]]];
    }
    return arr;
}

- (NSArray <RWWeightEntityModel *>*)obtainWeightWithMonth:(RWWeightMonthModel *)mod{
    [self obtainDatabase];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < mod.monthList.count; i++) {
        RWWeightEntityModel *weight = [manager obtainDayListWithDate:mod.monthList[mod.monthList.count-i-1]];
        weight.monthDate = mod.dateid;
        [arr addObject:weight];
    }
    
    return arr;
}

- (NSArray <RWWeightModel *>*)obtainAllDayWeight:(NSDate *)date AndMonthWeight:(NSDate *)month {
    [self obtainDatabase];
    return [manager obtainDayWeightWithDate:date AndMonth:month];
}

@end

@interface RWDataProcessingPlant ()

{

    @protected
    NSTimer *timer;
    NSInteger showTimes;
    
}

@end

@implementation RWDataProcessingPlant


+ (NSString *)obtainSystemDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)obtainYearAndMonth{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)obtainYearMonthAndDay{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)obtainTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (void)obtainNewTimerNow {
    RWDataProcessingPlant *processing = [[RWDataProcessingPlant alloc]init];
    [processing obtainNewTimer];
}

- (void)obtainNewTimer{
    if (timer == nil) {
        showTimes = 0;
        timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerPass) userInfo:nil repeats:YES];
    }
    [timer setFireDate:[NSDate distantPast]];
}

- (void)timerPass {
    showTimes++;
    [self.timerSource realtimeOfTimer:[self processShowTime]];
}

- (NSString *)processShowTime {
    NSInteger hours = 0;
    NSInteger minute = 0;
    NSInteger second = 0;
    
    second = showTimes%60;
    minute = showTimes/60;
    
    if (showTimes/60 > 59) {
        hours = minute/60;
        minute = minute%60;
    }else {
        hours = 0;
    }
    return [NSString stringWithFormat:@"%ld:%ld:%ld",hours,minute,second];
}

- (void)suspendedTimer{
    [timer setFireDate:[NSDate distantFuture]];
}

- (void)stopTimer{
    [timer setFireDate:[NSDate distantFuture]];
    showTimes = 0;
}

- (void)startTimer{
    [timer setFireDate:[NSDate distantPast]];
}

- (void)reloadTimer {
    showTimes = 0;
}

+ (NSArray <NSDate *>*)obtainDate{
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM-yyyy"];
    NSString *monthString = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *dateMonth = [dateFormatter dateFromString:monthString];
    [arr addObject:dateMonth];
    
    [dateFormatter setDateFormat:@"MM.dd(EEE)"];
    NSString *dayString = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *dateDay = [dateFormatter dateFromString:dayString];
    [arr addObject:dateDay];
    
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *timeString = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *dateTime = [dateFormatter dateFromString:timeString];
    [arr addObject:dateTime];

    return arr;
}

+ (NSString *)stringTime:(NSDate *)time {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    return [dateFormatter stringFromDate:time];
}

+ (NSString *)stringMonth:(NSDate *)month {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM-yyyy"];
    return [dateFormatter stringFromDate:month];
}

+ (NSString *)stringDay:(NSDate *)day {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM.dd(EEE)"];
    return [dateFormatter stringFromDate:day];
}

+ (NSArray *)clearSomeElementWithElement:(id)element ForArray:(NSArray *)array {
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
    
    for (int i = 0; i < arr.count; i++) {
        if (arr[i] == element) {
            [arr removeObjectAtIndex:i];
        }
    }
    return arr;
}

@end
