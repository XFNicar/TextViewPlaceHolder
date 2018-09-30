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

@property (nonatomic, strong) UITextView        *textView;
@property (weak, nonatomic) IBOutlet UITextView *IBTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.textView];
//    self.IBTextView.placeHolder = @"zhanweizifu";
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:@"富文本字符串"];
    [attri setAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15], } range:NSMakeRange(0, attri.length)];
     [attri setAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], } range:NSMakeRange(0, attri.length)];
    self.IBTextView.attributedPlaceHolder = attri;
}

- (UITextView *)textView {
    if (_textView == nil) {
        UITextView *txv = [[UITextView alloc]initWithFrame:CGRectMake(7, 200, 400, 100)];
        txv.backgroundColor = [UIColor clearColor];
        txv.layer.cornerRadius = 3;
        txv.layer.borderColor = [UIColor grayColor].CGColor;
        txv.layer.borderWidth = 1;
        txv.layer.masksToBounds = YES;
        _textView = txv;
    }
    return _textView;
}


@end
