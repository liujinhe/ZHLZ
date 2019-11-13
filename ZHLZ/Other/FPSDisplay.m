//
//  FPSDisplay.m
//  RJSBankDepository
//
//  Created by liujinhe on 2019/1/21.
//  Copyright © 2019 RongJinSuo. All rights reserved.
//

#import "FPSDisplay.h"

@interface FPSDisplay ()

@property (strong, nonatomic) UILabel *displayLabel;    // 显示
@property (strong, nonatomic) CADisplayLink *link;      // CADisplayLink 是一个将定时器绑定到显示屏上负责垂直同步的类
@property (assign, nonatomic) NSInteger count;          // FPS 值大小
@property (assign, nonatomic) NSTimeInterval lastTime;  // 时间间隔
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIFont *subFont;

@end

@implementation FPSDisplay

+ (instancetype)sharedInstance {
    static FPSDisplay *_fpsDisplay;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _fpsDisplay = [[FPSDisplay alloc] init];
    });
    return _fpsDisplay;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initDisplayLabel];
    }
    return self;
}

- (void)initDisplayLabel {
    // 设置 Label 的大小（放在屏幕右下角位置）
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGRect frame = CGRectMake(screenWidth - 100, screenHeight - 50, 80, 30);
    self.displayLabel = [[UILabel alloc] initWithFrame: frame];
    self.displayLabel.layer.cornerRadius = 5;
    self.displayLabel.clipsToBounds = YES;
    self.displayLabel.textAlignment = NSTextAlignmentCenter;
    self.displayLabel.userInteractionEnabled = NO;
    self.displayLabel.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
    _font = [UIFont fontWithName:@"Menlo" size:14];
    if (_font) {
        _subFont = [UIFont fontWithName:@"Menlo" size:4];
    } else {
        _font = [UIFont fontWithName:@"Courier" size:14];
        _subFont = [UIFont fontWithName:@"Courier" size:4];
    }
    [self initCADisplayLink];
    // 在每个页面都可以显示 FPS
    [[UIApplication sharedApplication].keyWindow addSubview:self.displayLabel];
}

- (void)initCADisplayLink {
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)tick:(CADisplayLink *)link {
    // 初始化 LastTime
    if (self.lastTime == 0) {
        self.lastTime = link.timestamp;
        return;
    }
    // 记录 tick 在1秒内执行的次数
    self.count += 1;
    // 计算本次刷新和上次更新 FPS 的时间间隔
    NSTimeInterval delta = link.timestamp - self.lastTime;
    // 大于等于1秒时，来计算FPS
    if (delta >= 1) {
        self.lastTime = link.timestamp;
        // FPS（次/秒）= 次数 / 时间
        float fps = self.count / delta;
        self.count = 0;
        // 刷新 FPS 值
        [self updateDisplayLabelText: fps];
    }
}

/// 更新 Label 上的 FPS 值
/// @param fps FPS 值
- (void)updateDisplayLabelText:(float) fps {
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    self.displayLabel.text = [NSString stringWithFormat:@"%d FPS", (int)round(fps)];
    self.displayLabel.textColor = color;
}

- (void)dealloc {
    [_link invalidate];
}

@end
