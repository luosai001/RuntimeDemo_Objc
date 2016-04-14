//
//  Person.m
//  RuntimeDemo_Objc
//
//  Created by luosai19910103@163.com on 16/4/13.
//  Copyright © 2016年 bingqingxueku. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@interface Person()

//@property int age ;
@end
@implementation Person

- (NSArray *)allProperties {
    unsigned int count ;
    //获取所有的属性  properties 结构体指针 数组
   objc_property_t *properties =  class_copyPropertyList(objc_getClass("Person"), &count);
    
    NSMutableArray * propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i<count;i++ ) {
        objc_property_t property = properties[i];
      const char *name =  property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        [propertiesArray addObject:propertyName];
    }
    //释放资源
    free(properties);
    
    return propertiesArray;
}


- (NSDictionary *)allPropertyNamesAndValues {
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        
        // 得到属性名
        NSString *propertyName = [NSString stringWithUTF8String:name];
        
        // 获取属性值
        id propertyValue = [self valueForKey:propertyName];
        
        if (propertyValue && propertyValue != nil) {
            [resultDict setObject:propertyValue forKey:propertyName];
        }
    }
    
    // 记得释放
    free(properties);
    
    return resultDict;
}


- (void) work {
    NSLog(@"I start to work ...");
}

void dynamicMethodIMP(id self, SEL _cmd) {
    // implementation ....
    NSLog(@"%s",__func__);
}


+(BOOL)resolveInstanceMethod:(SEL)aSEL
{
    if (aSEL == @selector(resolveThisMethodDynamically)) {
        class_addMethod([self class], aSEL, (IMP) dynamicMethodIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:aSEL];
}

//+ (BOOL)resolveClassMethod:(SEL)aSEL
//{
//    if (aSEL == @selector(resolveThisMethodDynamically)) {
//        class_addMethod([self class], aSEL, (IMP) dynamicMethodIMP, "v@:");
//        return YES;
//    }
//    return [super resolveClassMethod:aSEL];
//}
@end










