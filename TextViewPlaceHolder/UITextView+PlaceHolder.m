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
static char *AttributedPlaceHolder = "AttributedPlaceHolder";

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    [self initPlaceHolderLabWithText:placeHolder];
    objc_setAssociatedObject(self, PlaceHolder, placeHolder, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)placeHolder {
    return objc_getAssociatedObject(self, PlaceHolder);
}

- (NSAttributedString *)attributedPlaceHolder {
    return objc_getAssociatedObject(self, AttributedPlaceHolder);
}

- (void)setAttributedPlaceHolder:(NSAttributedString *)attributedPlaceHolder {
    [self initPlaceHolderLabWithAttributedText:attributedPlaceHolder];
    objc_setAssociatedObject(self, AttributedPlaceHolder, attributedPlaceHolder, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)initPlaceHolderLabWithAttributedText:(NSAttributedString *)attributedPlaceHolder {
    UILabel *phLab = [self getPlaceHolderLab];
    phLab.attributedText = attributedPlaceHolder;
}

- (void)initPlaceHolderLabWithText:(NSString *)placeHolder {
    UILabel *phLab = [self getPlaceHolderLab];
    phLab.text = placeHolder;
}

- (UILabel *)getPlaceHolderLab {
    UILabel *phLab = nil;
    for (UIView *subView in self.subviews) {
        if (subView.tag == 9527) {
            return  (UILabel *)subView;
        }
    }
    
    phLab = [[UILabel alloc]init];
    phLab.textColor = [UIColor lightGrayColor];
    phLab.tag = 9527;
    phLab.numberOfLines = 0;
    phLab.lineBreakMode = NSLineBreakByWordWrapping;
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
    phLab.hidden = (self.text.length != 0);
    return phLab;
}


- (void)textDidChange:(NSNotification *)sender {
    UILabel *phLab = nil;
    for (UIView *subView in self.subviews) {
        if (subView.tag == 9527) {
            phLab = (UILabel *)subView;
        }
    }
    phLab.hidden = (self.text.length != 0);
}

@end















