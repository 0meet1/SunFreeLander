//
//  WeightEntity+CoreDataProperties.h
//  SunnyFreelander
//
//  Created by RyeWhiskey on 16/3/7.
//  Copyright © 2016年 RyeWhiskey. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WeightEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeightEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *dateid;
@property (nullable, nonatomic, retain) id weight;
@property (nullable, nonatomic, retain) NSString *lastweight;

@end

NS_ASSUME_NONNULL_END
