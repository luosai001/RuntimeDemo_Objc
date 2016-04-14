//
//  ViewController.m
//  RuntimeDemo_Objc
//
//  Created by luosai19910103@163.com on 16/4/13.
//  Copyright © 2016年 bingqingxueku. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/objc-runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    Person *p = [[Person alloc] init];
    p.name = @"Lili";
//    [p setValue:@"19" forKey:@"age"];
    size_t size = class_getInstanceSize(p.class);

    NSLog(@"size=%ld", size);
    
    for (NSString *propertyName in p.allProperties) {
        NSLog(@"%@", propertyName);
    }
    
    // 此方法返回的只有属性值不为空的属性
    NSDictionary *dict = p.allPropertyNamesAndValues;
    for (NSString *propertyName in dict.allKeys) {
        NSLog(@"propertyName: %@ propertyValue: %@",
              propertyName,
              dict[propertyName]);
    }
    
    
    
    id LenderClass = objc_getClass("Person");
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(LenderClass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
    }
    
    SEL sel = @selector(allProperties);
    //发送消息  去除严格验证 p.list  enble stric 
    id array =  objc_msgSend(p,sel);
    for (NSString *propertyName in array) {
        NSLog(@"%@", propertyName);
    }
    
    

    
     sel = @selector(resolveThisMethodDynamically);
    
     objc_msgSend(p,sel);
    [p performSelector:sel withObject:nil afterDelay:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
