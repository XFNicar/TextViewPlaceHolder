//
//  ViewController.m
//  TextViewPlaceHolder
//
//  Created by YanYi on 2018/9/28.
//  Copyright © 2018 YanYi. All rights reserved.
//

#import "ViewController.h"
#import "UITextView+PlaceHolder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextView *txv = [[UITextView alloc]initWithFrame:CGRectMake(7, 200, 400, 100)];
    [self.view addSubview:txv];
    txv.placeHolder = @"请输入至少超过500字符的短文";
    txv.backgroundColor = [UIColor clearColor];
    txv.layer.cornerRadius = 3;
    txv.layer.borderColor = [UIColor grayColor].CGColor;
    txv.layer.borderWidth = 1;
    txv.layer.masksToBounds = YES;
}


@end
