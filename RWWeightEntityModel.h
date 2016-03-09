//
//  RWWeightEntityModel.h
//  SunnyFreelander
//
//  Created by RyeWhiskey on 16/3/8.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWWeightEntityModel : NSObject

#pragma mark - 数据库标签

@property (nullable, nonatomic, retain) NSDate *dateid;


#pragma mark - 附加属性
@property (nullable, nonatomic, retain) NSString *lastweight;


#pragma mark - 标签属性
@property (nonatomic,strong,nullable)NSDate *monthDate;

@end
