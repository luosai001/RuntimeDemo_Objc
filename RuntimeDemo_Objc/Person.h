//
//  Person.h
//  RuntimeDemo_Objc
//
//  Created by luosai19910103@163.com on 16/4/13.
//  Copyright © 2016年 bingqingxueku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person:NSObject  {
    NSString *_variableString;
}

// 默认会是什么呢？
@property (nonatomic, copy) NSString *name;

// 默认是strong类型
@property (nonatomic, strong) NSMutableArray *array;

// 获取所有的属性名
- (NSArray *)allProperties;
- (NSDictionary *)allPropertyNamesAndValues ;
@end
