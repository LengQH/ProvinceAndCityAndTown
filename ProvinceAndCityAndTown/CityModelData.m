//
//  CityModelData.m
//  ProvinceAndCityAndTown
//
//  Created by 冷求慧 on 16/12/27.
//  Copyright © 2016年 冷求慧. All rights reserved.
//

#import "CityModelData.h"

@implementation CityModelData


+ (NSDictionary *)objectClassInArray{
    return @{@"province" : [Province class]};
}
@end
@implementation Province

+ (NSDictionary *)objectClassInArray{
    return @{@"city" : [City class]};
}

@end


@implementation City

+ (NSDictionary *)objectClassInArray{
    return @{@"district" : [District class]};
}

@end


@implementation District

@end
