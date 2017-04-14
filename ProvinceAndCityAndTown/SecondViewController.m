//
//  SecondViewController.m
//  ProvinceAndCityAndTown
//
//  Created by 冷求慧 on 16/12/27.
//  Copyright © 2016年 冷求慧. All rights reserved.
//

#import "SecondViewController.h"

#import "CityModelData.h"   // 数据模型类
#import "MySingleton.h"   //单例类
#import <MJExtension.h>  // 数据转模型类
#import "CusDatePickerWithArea.h"    // pickView

#define changeDesc         @"changeDesc"
#define selectCityIndex    @"selectCityIndex"  // 选中城市的下标


#define screenWidthW  [[UIScreen mainScreen] bounds].size.width
#define screenHeightH [[UIScreen mainScreen] bounds].size.height

@interface SecondViewController (){
    CusDatePickerWithArea  *pickArea;   // PickView视图
    
}
/**
 *  城市模型数据
 */
@property (nonatomic,strong)CityModelData  *cityModel;
/**
 *  城市按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *addressButton;

@end

@implementation SecondViewController
-(CityModelData *)cityModel{
    if (_cityModel==nil) {
        MySingleton *mySing=[MySingleton shareMySingleton];
        if (mySing.cityModel) {
            _cityModel=mySing.cityModel;
        }
        else{
            NSString *jsonPath=[[NSBundle mainBundle]pathForResource:@"province_data.json" ofType:nil];
            NSData *jsonData=[[NSData alloc]initWithContentsOfFile:jsonPath];
            NSString *stringValue=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSDictionary *dicValue=[mySing getObjectFromJsonString:stringValue];  // 将本地JSON数据转为对象
            _cityModel=[CityModelData mj_objectWithKeyValues:dicValue];
            mySing.cityModel=_cityModel;
        }
    }
    return _cityModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self lastSelectValue];
}
#pragma mark 上次选中的值
-(void)lastSelectValue{
    NSString *strLastSelectValue=[MySingleton getsaveLoacalField:changeDesc];  // 得到本地存储的上次选中的值
    if(strLastSelectValue.length>0){
        [self.addressButton setTitle:strLastSelectValue forState:UIControlStateNormal];
    }
}
#pragma mark 跳转操作
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 显示对应的PickView
- (IBAction)showPickView:(UIButton *)sender {
    [self addPickView];  // 添加选中视图
}
#pragma mark 添加pickView
-(void)addPickView{
    __weak typeof(self) lowSelf=self;
    pickArea=[[CusDatePickerWithArea alloc]initWithFrame:CGRectMake(0, 0, screenWidthW, screenHeightH) cityData:lowSelf.cityModel];
    NSString *stringSelectCityIndex=[MySingleton getsaveLoacalField:selectCityIndex]; // 得到上次保存的下标
    if (stringSelectCityIndex.length>0) {
        NSArray *arrIndex=[stringSelectCityIndex componentsSeparatedByString:@"-"];
        if (arrIndex.count==3) {
            [pickArea scrollToRow:[arrIndex[0] integerValue] secondRand:[arrIndex[1] integerValue] thirdRand:[arrIndex[2] integerValue]]; // 滚动到选择的位置
        }
    }
    else{
        [pickArea scrollToRow:23 secondRand:0 thirdRand:4];  // 没有选择的情况下,默认滚动到上海
    }
    UIWindow *myWindow=[[UIApplication sharedApplication]keyWindow];
    [myWindow addSubview:pickArea];
    pickArea.areaValue=^(NSString *value,NSString *indexString){  //Block回调传值
        [lowSelf.addressButton setTitle:value forState:UIControlStateNormal];
        [MySingleton saveLoacalWithField:changeDesc value:value];           // 保存对应的数据和选中的下标
        [MySingleton saveLoacalWithField:selectCityIndex value:indexString];
        
    };
}
@end
