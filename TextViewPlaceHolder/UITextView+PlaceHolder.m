//
//  UITextView+PlaceHolder.m
//  TextViewPlaceHolder
//
//  Created by YanYi on 2018/9/28.
//  Copyright © 2018 YanYi. All rights reserved.
//

#import "UITextView+PlaceHolder.h"
#import <objc/runtime.h>

@implementation UITextView (PlaceHolder)

static char *PlaceHolder = "PlaceHolder";

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    UILabel *phLab = nil;
    for (UIView *subView in self.subviews) {
        if (subView.tag == 9527) {
            phLab = (UILabel *)subView;
        }
    }
    if (phLab != nil) {
        phLab.text = placeHolder;
    } else {
        [self initPlaceHolderLabWithText:placeHolder];
    }
    objc_setAssociatedObject(self, PlaceHolder, placeHolder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}



- (NSString *)placeHolder {
    NSString *phStr = @"";
    for (UIView *subView in self.subviews) {
        if (subView.tag == 9527) {
            phStr = ((UILabel *)subView).text;
        }
    }
    return objc_getAssociatedObject(self, PlaceHolder);
}

- (void)initPlaceHolderLabWithText:(NSString *)placeHolder {
    UILabel *phLab = [[UILabel alloc]init];
    phLab.textColor = [UIColor lightGrayColor];
    phLab.tag = 9527;
    phLab.numberOfLines = 0;
    phLab.lineBreakMode = NSLineBreakByWordWrapping;
    phLab.text = placeHolder;
    phLab.font = self.font;
    phLab.backgroundColor = [UIColor clearColor];
    phLab.userInteractionEnabled = YES;
    phLab.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:phLab];
    NSLayoutConstraint * phLeftLc = [NSLayoutConstraint constraintWithItem:phLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.f];
    [self addConstraint:phLeftLc];
    
    NSLayoutConstraint * phTopLc = [NSLayoutConstraint constraintWithItem:phLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:4.f];
    [self addConstraint:phTopLc];
    
    NSLayoutConstraint * phWidthLc = [NSLayoutConstraint constraintWithItem:phLab attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0f];
    [self addConstraint:phWidthLc];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];

}

- (void)textDidChange:(NSNotification *)sender {
    UILabel *phLab = nil;
    for (UIView *subView in self.subviews) {
        if (subView.tag == 9527) {
            phLab = (UILabel *)subView;
        }
    }
    if (self.text.length > 0) {
        phLab.alpha = 0;
    } else {
        phLab.alpha = 1;
    }
}




@end














