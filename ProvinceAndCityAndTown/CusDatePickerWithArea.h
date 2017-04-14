//
//  CusDatePickerWithArea.h
//  ProvinceAndCityAndTown
//
//  Created by 冷求慧 on 16/12/27.
//  Copyright © 2016年 冷求慧. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModelData.h"
typedef void(^AreaBlock)(NSString *areaValue,NSString *selectIndexValue);  // 区域回调Block

@interface CusDatePickerWithArea : UIView

-(instancetype)initWithFrame:(CGRect)frame cityData:(CityModelData *)cityData;

+(instancetype)cusDatePickerWithArea:(CGRect)frame cityData:(CityModelData *)cityData;

/**
 *  选择器对象
 */
@property (nonatomic,strong)UIPickerView *pickerView;
/**
 *  最终选中的值
 */
@property (nonatomic,copy)AreaBlock areaValue;
/**
 *  滚动到对应的行
 *
 *  @param firstRank  第一列的下标
 *  @param secondRand 第二列的下标
 *  @param thirdRand  第三列的下标
 */
-(void)scrollToRow:(NSInteger)firstRank  secondRand:(NSInteger)secondRand thirdRand:(NSInteger)thirdRand;
@end
