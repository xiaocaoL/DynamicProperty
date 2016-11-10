//
//  main.m
//  RuntimeTest
//
//  Created by nav on 16/6/29.
//  Copyright © 2016年 Chris.C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <objc/runtime.h>
#import <objc/message.h>

void sayFunction(id self, SEL _cmd, id some) {
    NSLog(@"%@岁的%@说：%@", object_getIvar(self, class_getInstanceVariable([self class], "_age")),[self valueForKey:@"name"],some);
}



void dynamicFucntion() {
    //动态创建一个Person类，继承自NSObject类
    Class People = objc_allocateClassPair([NSObject class], "Person", 0);
    
    //为该类添加_name  成员变量
    class_addIvar(People, "_name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    class_addIvar(People, "_age", sizeof(int), sizeof(int), @encode(int));
    
    //注册方法名为say的方法
    SEL  s = sel_registerName("say");
    
    //为该类增加名为say的方法
    class_addMethod(People, s, (IMP)sayFunction, "V@:@");
    
    //注册该类
    objc_registerClassPair(People);
    
    //创建一个类的实例变量
    id peopleInstance = [[People alloc]init];
    //KVC动态改变类的实例变量
    [peopleInstance setValue:@"苍老师" forKey:@"name"];
    
    //从类中获取成员变量Ivar
    Ivar ageIvar = class_getInstanceVariable(People, "_age");
    object_setIvar(peopleInstance, ageIvar, @18);
    
    ((void (*)(id, SEL, id))objc_msgSend)(peopleInstance, s, @"大家好");
    
}


int main(int argc, char * argv[]) {
    @autoreleasepool {
        dynamicFucntion();
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}


