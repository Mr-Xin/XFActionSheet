//
//  ViewController.m
//  XFActionSheet
//
//  Created by xinfeng on 2017/1/17.
//  Copyright © 2017年 XFActionSheet. All rights reserved.
//

#import "ViewController.h"
#import "XFActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupBasiceData];
    [self setupLayout];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"XFActionSheet";
}

- (void)setupBasiceData {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupLayout {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setFrame:CGRectMake(50, 100, 100, 40)];
    [button setTitle:@"全部控件展示" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setFrame:CGRectMake(150, 100, 100, 40)];
    [button2 setTitle:@"只有标题" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(clickButton2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button3 setFrame:CGRectMake(50, 200, 100, 40)];
    [button3 setTitle:@"只有描述" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(clickButton3:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button4 setFrame:CGRectMake(150, 200, 100, 40)];
    [button4 setTitle:@"只有蓝色按钮" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(clickButton4:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button5 setFrame:CGRectMake(50, 300, 100, 40)];
    [button5 setTitle:@"只有红色按钮" forState:UIControlStateNormal];
    [button5 addTarget:self action:@selector(clickButton5:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    UIButton *button6 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button6 setFrame:CGRectMake(150, 300, 100, 40)];
    [button6 setTitle:@"无按钮" forState:UIControlStateNormal];
    [button6 addTarget:self action:@selector(clickButton6:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button6];
}

- (void)clickButton1:(UIButton *)sender {
    XFActionSheet *actionSheet = [[XFActionSheet alloc]initActionSheetWithTitle:@"测试标题" descriptiveText:@"测试描述" cancelButtonTitle:@"返回" destructiveButtonTitles:@[@"红色按钮1",@"红色按钮2",@"红色按钮3"] otherButtonTitles:@[@"蓝色按钮1",@"蓝色按钮2",@"蓝色按钮3"] itemAction:^(XFActionSheet *actionSheet, NSString *title, NSInteger index) {
        [actionSheet dismissAction];
    }];
    [actionSheet showAction];
}

- (void)clickButton2:(UIButton *)sender {
    XFActionSheet *actionSheet = [[XFActionSheet alloc]initActionSheetWithTitle:@"测试标题，这个标题没有长度限制，想要多长就有多长.测试标题，这个标题没有长度限制，想要多长就有多长.测试标题，这个标题没有长度限制，想要多长就有多长.测试标题，这个标题没有长度限制，想要多长就有多长.测试标题，这个标题没有长度限制，想要多长就有多长.测试标题，这个标题没有长度限制，想要多长就有多长." descriptiveText:nil cancelButtonTitle:@"返回" destructiveButtonTitles:nil otherButtonTitles:nil itemAction:^(XFActionSheet *actionSheet, NSString *title, NSInteger index) {
        [actionSheet dismissAction];
    }];
    [actionSheet showAction];
}

- (void)clickButton3:(UIButton *)sender {
    XFActionSheet *actionSheet = [[XFActionSheet alloc]initActionSheetWithTitle:nil descriptiveText:@"测试描述，这个描述也没有内容限制，想要多长就会有多长,测试描述，这个描述也没有内容限制，想要多长就会有多长测试描述，这个描述也没有内容限制，想要多长就会有多长测试描述，这个描述也没有内容限制，想要多长就会有多长测试描述，这个描述也没有内容限制，想要多长就会有多长" cancelButtonTitle:@"返回" destructiveButtonTitles:nil otherButtonTitles:nil itemAction:^(XFActionSheet *actionSheet, NSString *title, NSInteger index) {
        [actionSheet dismissAction];
    }];
    [actionSheet showAction];
}

- (void)clickButton4:(UIButton *)sender {
    XFActionSheet *actionSheet = [[XFActionSheet alloc]initActionSheetWithTitle:nil descriptiveText:nil cancelButtonTitle:@"返回" destructiveButtonTitles:nil otherButtonTitles:@[@"蓝色按钮1",@"蓝色按钮2",@"蓝色按钮3"] itemAction:^(XFActionSheet *actionSheet, NSString *title, NSInteger index) {
        [actionSheet dismissAction];
    }];
    [actionSheet showAction];
}

- (void)clickButton5:(UIButton *)sender {
    XFActionSheet *actionSheet = [[XFActionSheet alloc]initActionSheetWithTitle:nil descriptiveText:nil cancelButtonTitle:@"返回" destructiveButtonTitles:@[@"红色按钮1",@"红色按钮2",@"红色按钮3"] otherButtonTitles:nil itemAction:^(XFActionSheet *actionSheet, NSString *title, NSInteger index) {
        [actionSheet dismissAction];
    }];
    [actionSheet showAction];
}

- (void)clickButton6:(UIButton *)sender {
    XFActionSheet *actionSheet = [[XFActionSheet alloc]initActionSheetWithTitle:nil descriptiveText:nil cancelButtonTitle:@"返回" destructiveButtonTitles:nil otherButtonTitles:nil itemAction:^(XFActionSheet *actionSheet, NSString *title, NSInteger index) {
        [actionSheet dismissAction];
    }];
    [actionSheet showAction];
}
@end
