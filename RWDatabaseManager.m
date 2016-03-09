//
//  RWDatabaseManager.m
//  SunnyFreelander
//
//  Created by RyeWhiskey on 16/3/6.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWDatabaseManager.h"
#import "MagicalRecord.h"
#import "RWDataSourceCenter.h"
#import "WeightEntity+CoreDataProperties.h"
#import "WeightMonthEntity+CoreDataProperties.h"
#import "RWWeightModel.h"

@interface RWDatabaseManager ()

{
    @protected
    RWDataProcessingPlant *processing;
    
}

@end

@implementation RWDatabaseManager

+ (RWDatabaseManager *)sharedDataBaseManager{
    
    static RWDatabaseManager *_Only = nil;
    
    static dispatch_once_t onecToKen;
    dispatch_once(&onecToKen, ^{
        _Only = [[super allocWithZone:NULL]init];
    });
    
    return _Only;
    
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self sharedDataBaseManager];
}

- (BOOL)insertWeight:(RWWeightModel *)model{

    if ([self containWeight:model]) {
        
        return [self upDataWeight:model];
    }else {
        WeightEntity *weightEntity = [WeightEntity MR_createEntity];
        weightEntity.dateid = model.dayDate;
        weightEntity.weight = @[model.weight];
        weightEntity.lastweight = model.weight;
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        if ([self containWeightMonthList:model]) {
            WeightMonthEntity *monthList = [WeightMonthEntity MR_findFirstByAttribute:@"dateid" withValue:model.monthDate];
            NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:monthList.monthList];
            [arr addObject:model.dayDate];
            monthList.monthList = arr ;
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            return YES;
        }else {
            WeightMonthEntity *monthList = [WeightMonthEntity MR_createEntity];
            monthList.dateid = model.monthDate;
            monthList.monthList = @[model.dayDate];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            return YES;
        }
    }
    return NO;
}

- (BOOL)deleteWeight:(RWWeightModel *)model{

    WeightEntity *weightEntity = [WeightEntity MR_findFirstByAttribute:@"dateid" withValue:model.dayDate];
    
    if (weightEntity != nil) {
        NSArray *newWeight = [RWDataProcessingPlant clearSomeElementWithElement:model.weight ForArray:weightEntity.weight];
        if (newWeight.count < 1) {
            
            [weightEntity MR_deleteEntity];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            
            WeightMonthEntity *monthList = [WeightMonthEntity MR_findFirstByAttribute:@"dateid" withValue:model.monthDate];
            
            if (monthList != nil) {
                NSArray *faceList = monthList.monthList;
                
                if (faceList.count <= 1) {
                    [monthList MR_deleteEntity];
                    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                }else {
                    monthList.monthList = [RWDataProcessingPlant clearSomeElementWithElement:model.dayDate ForArray:faceList];
                    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                }
            }else {
                return NO;
            }
        }else {
            weightEntity.weight = newWeight;
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
        return YES;
    }
    return NO;
}

- (BOOL)deleteWeightOfDay:(RWWeightEntityModel *)model {
    WeightEntity *weightEntity = [WeightEntity MR_findFirstByAttribute:@"dateid" withValue:model.dateid];
    if (weightEntity != nil) {
        [weightEntity MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        WeightMonthEntity *monthList = [WeightMonthEntity MR_findFirstByAttribute:@"dateid" withValue:model.monthDate];
        
        if (monthList != nil) {
            NSArray *faceList = monthList.monthList;
            
            if (faceList.count <= 1) {
                [monthList MR_deleteEntity];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            }else {
                monthList.monthList = [RWDataProcessingPlant clearSomeElementWithElement:model.dateid ForArray:faceList];
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            }
        }
        return YES;
    }
    return NO;
}

- (BOOL)deleteAllWeight{
    BOOL WEsec = [WeightEntity MR_truncateAll];
    BOOL WMEsec = [WeightMonthEntity MR_truncateAll];
    if (WEsec&&WMEsec) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)upDataWeight:(RWWeightModel *)model{
    
    WeightEntity *weightEntity = [WeightEntity MR_findFirstByAttribute:@"dateid" withValue:model.dayDate];
    if (weightEntity != nil) {
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:weightEntity.weight];
        [arr addObject:model.weight];
        weightEntity.weight = arr;
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        return YES;
    }
    return NO;
}

- (NSArray <RWWeightMonthModel *>*)obtainMonthList{
    
    NSArray *allMonth = [WeightMonthEntity MR_findAll];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i < allMonth.count; i++) {
        WeightMonthEntity *monthEntity = allMonth[allMonth.count-i-1];
        RWWeightMonthModel *mod = [[RWWeightMonthModel alloc]init];
        
        mod.dateid = monthEntity.dateid;
        mod.monthList = monthEntity.monthList;
        
        [arr addObject:mod];
    }
    return arr;
}

- (RWWeightEntityModel *)obtainDayListWithDate:(NSDate *)date{
    WeightEntity *weightEntity = [WeightEntity MR_findFirstByAttribute:@"dateid" withValue:date];     
    RWWeightEntityModel *mod = [[RWWeightEntityModel alloc]init];
    mod.dateid = weightEntity.dateid;
    mod.lastweight = weightEntity.lastweight;
    return mod;
}

- (NSArray <RWWeightModel *>*)obtainDayWeightWithDate:(NSDate *)date AndMonth:(NSDate *)month{
    WeightEntity *weightEntity = [WeightEntity MR_findFirstByAttribute:@"dateid" withValue:date];
    NSArray *arr = weightEntity.weight;
    
    NSMutableArray *mArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < arr.count; i++) {
        RWWeightModel *mod = [[RWWeightModel alloc]init];
        mod.weight = arr[arr.count-i-1];
        mod.dayDate = date;
        mod.monthDate = month;
        [mArr addObject:mod];
    }
    return mArr;
}

- (BOOL)containWeight:(RWWeightModel *)model {
    
    WeightEntity *weightEntity = [WeightEntity MR_findFirstByAttribute:@"dateid" withValue:model.dayDate];
    if (weightEntity != nil) {
        return YES;
    }
    return NO;
}

- (BOOL)containWeightMonthList:(RWWeightModel *)model {
    WeightMonthEntity *monthList = [WeightMonthEntity MR_findFirstByAttribute:@"dateid" withValue:model.monthDate];
    if (monthList != nil) {
        return YES;
    }
    return NO;
}


@end
