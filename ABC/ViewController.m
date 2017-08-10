//
//  ViewController.m
//  ABC
//
//  Created by tosakai on 2017/8/9.
//  Copyright © 2017年 tosakai. All rights reserved.
//

#import "ViewController.h"

#define  TIME_FROMATTER @"yyyy_MM_dd_HH_mm_ss"//时间格式


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *str = [self getYearMonthDayHourMinuteSecondsForTotalSeconds:1493619600000];
//    NSString *ss = [self transToDate:1493619600000];
    test3();
}

void test3(){
    NSString *str = @"{123123123这是一个导出的字符串}";
    //文件不存在会自动创建，文件夹不存在则不会自动创建会报错
    NSString *path = @"/Users/tosakai/Desktop/test_export.txt";
    NSError *error;
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"导出失败:%@",error);
    }else{
        NSLog(@"导出成功");
    }
}

//- (NSString *)getYearMonthDayHourMinuteSecondsForTotalSeconds:(long long)seconds {
//    NSTimeInterval time= seconds;
//    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//    //设置时区
//    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
//    //目标日期与当前时区的偏移量
////    NSTimeInterval interval = [timeZone secondsFromGMTForDate:detaildate];
////    NSDate *realDate = [detaildate dateByAddingTimeInterval:interval];
//    NSLog(@"date:%@",[realDate description]);
//    NSDateFormatter *dateFormatter = [NSDateFormatter new];
//    [dateFormatter setDateFormat:TIME_FROMATTER];
//    [dateFormatter setTimeZone:timeZone];
//    NSString *currentDateStr = [dateFormatter stringFromDate: realDate];
//    return currentDateStr;
//}

- (NSString *)getYearMonthDayHourMinuteSecondsForTotalSeconds:(double)seconds {
    NSTimeInterval time = seconds;//如果不使用本地时区,因为时差问题要加8小时 == 28800 sec
    //    Unix时间戳有10位（秒级），也有13位（毫秒级），也有19位（纳秒级）
    if ((time/pow(10, 13)) < 1) {//毫秒级
        time = time/1000;
    } else if ((time/pow(10, 19)) < 1) {//纳秒级
        time = time/(pow(10, 9));
    }
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];//设置本地时区
    [dateFormatter setDateFormat:TIME_FROMATTER];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}


- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
