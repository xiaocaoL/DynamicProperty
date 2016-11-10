//
//  ViewController.m
//  RuntimeTest
//
//  Created by nav on 16/6/29.
//  Copyright © 2016年 Chris.C. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UIButton+Transcation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    objc_msgSend(self,@selector(test));
    
    [self say];
    [self mySay];
   
    [self changeMethod];
    
    [self say];
    [self mySay];
//    [self category];
    
}

- (void)category
{
    UIButton *btn = [[UIButton alloc]init];
    btn.foreignkeyarr = @[@"1",@"2"];
    NSLog(@"%@",btn.foreignkeyarr);
}

- (void)test
{
    NSLog(@"test");
}

- (void)changeMethod
{
    /*
     class_getInstanceMethod     得到类的实例方法
     class_getClassMethod          得到类的类方法
     */
    Method say1 = class_getInstanceMethod([ViewController class], @selector(say));
    Method mySay1 = class_getInstanceMethod([ViewController class], @selector(mySay));
    method_exchangeImplementations(say1, mySay1);
}

- (void)say
{
     NSLog(@"%s",__FUNCTION__);
}

- (void)mySay
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)add_Ivar
{
    class_addIvar([ViewController class], "name", sizeof(NSString *), 0, "@");
     id peopleInstance = [[ViewController alloc]init];
    [peopleInstance setValue:@"xiaocao" forKey:@"name"];
    
    Ivar v = class_getInstanceVariable([self class], "name");
    //返回名为itest的ivar的变量的值
    id o = object_getIvar(self, v);
    //成功打印出结果
    NSLog(@"%s-%@", __FUNCTION__,o);
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
