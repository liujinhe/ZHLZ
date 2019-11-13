//
//  GRToast.m
//  GR
//
//  Created by liujinhe on 2019/11/12.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "GRToast.h"

// 提示信息时效
#define kDurationTime 2.f

@interface GRToast()

@end

@implementation GRToast

+ (void)makeText:(NSString *)text {
    [self makeText:text duration:kDurationTime offset:0 withIsDuration:YES];
}

+ (void)makeText:(NSString *)text withIsDuration:(BOOL)isDuration {
    [self makeText:text duration:kDurationTime offset:0 withIsDuration:isDuration];
}

+ (void)makeText:(NSString *)text offset:(CGFloat)offset {
    [self makeText:text duration:kDurationTime offset:offset withIsDuration:YES];
}

+ (void)makeText:(NSString *)text duration:(CFTimeInterval)duration {
    [self makeText:text duration:duration offset:0 withIsDuration:YES];
}

#if __has_include(<YYKit/YYKit.h>)
static YYLabel *label = nil;
#else
static UILabel *label = nil;
#endif
static UIView *contentView = nil;

+ (void)makeText:(NSString *)text duration:(CFTimeInterval)duration offset:(CGFloat)offset withIsDuration:(BOOL)isDuration {
    if (!text) {
        return;
    }
    if (![text isKindOfClass:[NSString class]]) {
        return;
    }
    if (![text isNotBlank]) {
        return;
    }
    
    static CGFloat padding = 10.f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        contentView = [UIView new];
#if __has_include(<YYKit/YYKit.h>)
        label = [[YYLabel alloc] init];
        label.textContainerInset = UIEdgeInsetsMake(0.5f * padding, padding * 1.5f, 0.5f * padding, padding * 1.5f);
#else
        label = [[UILabel alloc] init];
#endif
        label.numberOfLines = 0.f;
        label.userInteractionEnabled = NO;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
        label.layer.cornerRadius = 5.f;
        label.layer.masksToBounds = YES;
        [contentView addSubview:label];
    });
    
    label.size = [text sizeForFont:label.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - padding * 7, HUGE) mode:NSLineBreakByWordWrapping];
    label.width += 3 * padding;
    label.height += 2 * padding;
    contentView.size = label.size;
    
    UIView *superView = [UIApplication sharedApplication].keyWindow ?: [UIApplication sharedApplication].windows.lastObject;
    
    contentView.centerX = superView.centerX;
    contentView.bottom = [UIScreen mainScreen].bounds.size.height - 64.f - 216.f - 50.f;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [superView addSubview:contentView];
        label.text = text;
        
        if (label.superview) {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideToast) object:nil];
        } else {
            [UIView animateWithDuration:kDurationTime animations:^{
                contentView.alpha = 1.f;
            }];
        }
        if (isDuration) {
            [self performSelector:@selector(hideToast) withObject:nil afterDelay:duration];
        }
    });
    
}

+ (void)hideToast {
    [UIView animateWithDuration:0.25f animations:^{
        contentView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [contentView removeFromSuperview];
        contentView.alpha = 1.f;
    }];
}

@end
