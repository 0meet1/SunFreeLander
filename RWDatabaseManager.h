//
//  RWDatabaseManager.h
//  SunnyFreelander
//
//  Created by RyeWhiskey on 16/3/6.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWWeightModel.h"
#import "RWWeightMonthModel.h"
#import "RWWeightEntityModel.h"

@interface RWDatabaseManager : NSObject

+ (RWDatabaseManager *)sharedDataBaseManager;
/**
 *  插入数据库
 *
 *  @param model
 *
 *  @return
 */
- (BOOL)insertWeight:(RWWeightModel *)model;
/**
 *  删除一条记录
 *
 *  @param model
 *
 *  @return
 */
- (BOOL)deleteWeight:(RWWeightModel *)model;
/**
 *  删除指定日子的全部记录
 *
 *  @param model
 *
 *  @return
 */
- (BOOL)deleteWeightOfDay:(RWWeightEntityModel *)model;
/**
 *  删除全部数据
 *
 *  @return
 */
- (BOOL)deleteAllWeight;
/**
 *  更新一条记录
 *
 *  @param model
 *
 *  @return
 */
- (BOOL)upDataWeight:(RWWeightModel *)model;
/**
 *  返回月列表
 *
 *  @return
 */
- (NSArray <RWWeightMonthModel *>*)obtainMonthList;
/**
 *  返回日模型
 *
 *  @param date
 *
 *  @return
 */
- (RWWeightEntityModel *)obtainDayListWithDate:(NSDate *)date;
/**
 *  返回当日的全部数据
 *
 *  @param date
 *  @param month
 *
 *  @return 
 */
- (NSArray <RWWeightModel *>*)obtainDayWeightWithDate:(NSDate *)date AndMonth:(NSDate *)month;

@end

