//
//  RWTestModel.m
//  SunnyFreelander
//
//  Created by RyeWhiskey on 16/3/8.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import "RWTestModel.h"
#import "RWDataSourceCenter.h"

@implementation RWTestModel

/*
 
 
     数据测试类
 
 
 */

+ (void)startTest{
//    RWTestModel *test = [[RWTestModel alloc]init];
//    [test heightPressureTest];
//    [test log];
}
//高压测试
- (void)heightPressureTest {
    
    //结果：数据量过大读取速度有限
    
    RWDataSourceCenter *source = [RWDataSourceCenter sharedDataSourceCenter];
    
    [source deleteAllDate];
    NSLog(@"%@",[source obtainWeightInformation]);
    for (int i = 0 ; i < 1000; i ++) {
        @autoreleasepool {
           [source insertWeight:[NSString stringWithFormat:@"%dKG",arc4random()%50+50]];
        }
    }
}

- (void)log{
    RWDataSourceCenter *source = [RWDataSourceCenter sharedDataSourceCenter];
    
    NSArray *arr = [source obtainWeightInformation];
    
    for (int i = 0 ; i < arr.count; i++) {
        for (int j = 0; j < [arr[i] count]; j++) {
            RWWeightEntityModel *mod = arr[i][j];
            NSLog(@"%@",mod.lastweight);
            NSArray *arr = [source obtainAllDayWeight:mod.dateid AndMonthWeight:mod.monthDate];
            for (int v = 0; v < arr.count; v++) {
                RWWeightModel *wei = arr[v];
                NSLog(@"%@",wei.weight);
            }
        }
    }
    
}

@end
